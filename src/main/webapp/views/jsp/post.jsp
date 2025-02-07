<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>게시글 작성</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://cdn.jsdelivr.net/npm/alpinejs@3.x.x/dist/cdn.min.js" defer></script>
    <script src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=fa4ea1c9043252a4e21db24e7aa57069&libraries=services"></script>
</head>
<body class="bg-gray-100 p-6" x-data="postForm">
	<nav class="bg-blue-500 p-4 text-white flex justify-between">
	    <a href="main.jsp" class="text-lg font-bold">여행 기록</a>
	    <ul class="flex space-x-4">
	        <li><a href="mypage" class="hover:underline">마이페이지</a></li>
	        <li><a href="post" class="hover:underline">게시글 작성</a></li>
	        <li><a href="recommend" class="hover:underline">추천 여행지</a></li>
	    </ul>
	</nav>

    <div class="max-w-2xl mx-auto bg-white p-6 rounded-lg shadow-lg">
        <h2 class="text-2xl font-bold mb-4">✍ 게시글 작성</h2>

        <form action="post" method="post">
            <input type="text" name="title" placeholder="제목" class="w-full p-2 border rounded mb-2">
            <textarea name="description" placeholder="내용" class="w-full p-2 border rounded mb-2"></textarea>
            <input type="date" name="start_date" class="w-full p-2 border rounded mb-2">
            <input type="date" name="end_date" class="w-full p-2 border rounded mb-2">

            <!-- 📌 키워드로 장소 검색 -->
            <div class="relative">
                <input type="text" id="searchLocation" placeholder="키워드로 장소 검색" x-model="searchQuery" class="w-full p-2 border rounded mb-2">
                <button type="button" class="absolute right-2 top-2 bg-blue-500 text-white p-1 rounded" @click.prevent="searchLocation">🔍</button>
            </div>

            <!-- 📌 검색된 장소 리스트 -->
            <ul class="bg-white border rounded mt-2 max-h-40 overflow-y-auto" x-show="searchResults.length > 0">
                <template x-for="place in searchResults">
                    <li class="p-2 hover:bg-gray-200 cursor-pointer" @click="selectLocation(place)">
                        <span x-text="place.place_name"></span> - <span class="text-sm text-gray-500" x-text="place.address_name"></span>
                    </li>
                </template>
            </ul>

            <!-- 📌 선택된 주소 자동 입력 -->
            <input type="text" id="location" name="location" placeholder="위치" class="w-full p-2 border rounded mb-2" readonly>

            <input type="text" name="imgsrc" placeholder="이미지 URL" class="w-full p-2 border rounded mb-2">
            
            <button type="submit" class="w-full bg-blue-500 text-white p-2 rounded mt-2 hover:bg-blue-600 transition">
                게시글 등록
            </button>
        </form>

        <!-- 지도 -->
        <div id="map" class="w-full h-96 bg-gray-200 mt-4"></div>
    </div>

    <script>
        document.addEventListener('alpine:init', () => {
            Alpine.data('postForm', () => ({
                searchQuery: '',
                searchResults: [],
                map: null,
                markers: [],
                infowindow: null,
                activeMarker: null,

                init() {
                    let checkCount = 0;
                    let checkAPI = setInterval(() => {
                        if (window.kakao && window.kakao.maps && window.kakao.maps.services) {
                            console.log("✅ 카카오 API 로드 완료!");
                            clearInterval(checkAPI);
                            this.initMap();
                        } else if (checkCount >= 10) {
                            console.error("❌ 카카오 API 로드 실패. 페이지를 새로고침 해보세요.");
                            clearInterval(checkAPI);
                        }
                        checkCount++;
                    }, 500);
                },

                initMap() {
                    let mapContainer = document.getElementById('map');
                    let mapOption = {
                        center: new kakao.maps.LatLng(37.566826, 126.9786567),
                        level: 3
                    };
                    this.map = new kakao.maps.Map(mapContainer, mapOption);
                    this.infowindow = new kakao.maps.InfoWindow({zIndex:1});
                },

                searchLocation() {
                    if (!window.kakao || !window.kakao.maps || !window.kakao.maps.services) {
                        console.error("❗ 카카오 API가 아직 로드되지 않음. 다시 시도해주세요.");
                        return;
                    }

                    const places = new kakao.maps.services.Places();
                    const geocoder = new kakao.maps.services.Geocoder();

                    // 📌 1. 키워드 검색 시도 (장소명, 도로명 주소 가능)
                    places.keywordSearch(this.searchQuery, (data, status) => {
                        if (status === kakao.maps.services.Status.OK) {
                            this.searchResults = data;
                            this.displayMarkers(data);
                        } else {
                            // 📌 2. 키워드 검색 실패 시 주소 검색 (지번 주소 가능)
                            geocoder.addressSearch(this.searchQuery, (result, status) => {
                                if (status === kakao.maps.services.Status.OK && result.length > 0) {
                                    this.searchResults = [{
                                        place_name: result[0].address_name, // 📌 주소 그대로 사용
                                        address_name: result[0].address_name, 
                                        y: result[0].y,
                                        x: result[0].x
                                    }];
                                    this.displayMarkers(this.searchResults);
                                } else {
                                    console.warn("❗ 검색 결과 없음");
                                    this.searchResults = [];
                                }
                            });
                        }
                    });
                },

                displayMarkers(places) {
                    this.markers.forEach(marker => marker.setMap(null));
                    this.markers = [];

                    let bounds = new kakao.maps.LatLngBounds();
                    places.forEach(place => {
                        let marker = new kakao.maps.Marker({
                            map: this.map,
                            position: new kakao.maps.LatLng(place.y, place.x)
                        });

                        kakao.maps.event.addListener(marker, "click", () => {
                            this.highlightMarker(marker, place);
                        });

                        this.markers.push(marker);
                        bounds.extend(marker.getPosition());
                    });

                    this.map.setBounds(bounds);
                },

                highlightMarker(marker, place) {
                    if (this.activeMarker) {
                        this.activeMarker.setImage(null);
                    }

                    let highlightImage = new kakao.maps.MarkerImage(
                        "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_red.png", 
                        new kakao.maps.Size(30, 45),
                        { offset: new kakao.maps.Point(15, 45) }
                    );

                    marker.setImage(highlightImage); 
                    this.map.setCenter(marker.getPosition());
                    this.infowindow.setContent('<div style="padding:5px;font-size:12px;">' + place.place_name + '</div>');
                    this.infowindow.open(this.map, marker);
                    this.activeMarker = marker;

                    // 📌 마커 클릭 시 위치 입력
                    document.getElementById('location').value = place.address_name;
                },

                selectLocation(place) {
                    this.searchQuery = place.place_name;
                    document.getElementById('location').value = place.address_name;
                    this.searchResults = [];

                    let selectedMarker = this.markers.find(m => 
                        m.getPosition().getLat() === parseFloat(place.y) &&
                        m.getPosition().getLng() === parseFloat(place.x)
                    );

                    if (selectedMarker) {
                        this.highlightMarker(selectedMarker, place);
                    }
                }
            }));
        });
    </script>
</body>
</html>
