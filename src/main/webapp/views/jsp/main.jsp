<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>메인 페이지</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://cdn.jsdelivr.net/npm/alpinejs@3.x.x/dist/cdn.min.js" defer></script>
    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=fa4ea1c9043252a4e21db24e7aa57069&autoload=false" defer></script>
</head>
<body class="bg-gray-100 p-6" x-data="mapApp">
	<!-- 네비게이션 바 -->
	<nav class="bg-blue-500 p-4 text-white flex justify-between">
	    <a href="main" class="text-lg font-bold">여행 기록</a>
	    <ul class="flex space-x-4">
	        <li><a href="mypage" class="hover:underline">마이페이지</a></li>
	        <li><a href="post" class="hover:underline">게시글 작성</a></li>
	        <li><a href="recommend" class="hover:underline">추천 여행지</a></li>
	    </ul>
	</nav>

    <!-- 메인 레이아웃 -->
    <div class="max-w-6xl mx-auto flex gap-4 mt-6">
        <!-- 📌 게시글 리스트 (왼쪽) -->
        <div class="w-1/3 bg-white p-4 rounded-lg shadow-lg max-h-[500px] overflow-y-scroll">
            <h2 class="text-xl font-bold mb-4">📜 가족 여행 기록</h2>
            <ul>
                <template x-for="post in posts" :key="post.id">
                    <li class="p-3 border-b hover:bg-gray-100 cursor-pointer" @click="selectedPost = post">
                        <h3 class="text-lg font-bold" x-text="post.title"></h3>
                        <p class="text-gray-600" x-text="post.description"></p>
                    </li>
                </template>
            </ul>
        </div>

        <!-- 📌 카카오맵 (오른쪽) -->
        <div class="w-2/3">
            <h2 class="text-2xl font-bold mb-4">📍 여행 기록 지도</h2>
            <div id="map" class="w-full h-[500px] bg-gray-200"></div>
        </div>
    </div>

    <!-- 📌 모달창 (마커 클릭 or 리스트 클릭 시) -->
    <div class="fixed inset-0 bg-black bg-opacity-50 flex justify-center items-center" 
         x-show="selectedPost" x-transition>
        <div class="bg-white p-6 rounded-lg shadow-lg w-96">
            <h2 class="text-xl font-bold" x-text="selectedPost ? selectedPost.title : ''"></h2>
            <p x-text="selectedPost ? selectedPost.description : ''" class="mt-2 text-gray-700"></p>
            <button class="mt-4 bg-red-500 text-white p-2 rounded" @click="selectedPost = null">닫기</button>
        </div>
    </div>


    <script>
    document.addEventListener('alpine:init', () => {
        Alpine.data('mapApp', () => ({
            posts: [],
            selectedPost: null, // 선택된 게시글 (리스트/마커 클릭 시)
            markers: [], // 기존 마커를 저장할 배열
            map: null,

            init() {
                this.loadPosts();
                this.initMap();
            },

            loadPosts() {
                let cachedPosts = localStorage.getItem("posts");

                if (cachedPosts) {
                    this.posts = JSON.parse(cachedPosts);
                    this.updateMarkers();
                }

                fetch("/post")
                    .then(res => res.json())
                    .then(data => {
                        this.posts = data;
                        localStorage.setItem("posts", JSON.stringify(data));  // 📌 데이터 캐싱
                        this.updateMarkers();
                    })
                    .catch(error => console.error("❌ 데이터 로드 오류:", error));
            }
,

            initMap() {
                if (!window.kakao || !window.kakao.maps) {
                    console.error("⚠️ Kakao API가 아직 로드되지 않음. 500ms 후 다시 실행...");
                    setTimeout(() => this.initMap(), 500);
                    return;
                }

                kakao.maps.load(() => {
                    this.map = new kakao.maps.Map(document.getElementById("map"), {
                        center: new kakao.maps.LatLng(37.5665, 126.9780),
                        level: 7
                    });

                    // 📌 지도 이동 후 마커 유지
                    kakao.maps.event.addListener(this.map, "idle", () => {
                        this.updateMarkers();
                    });

                    this.updateMarkers();
                });
            },

            updateMarkers() {
                if (!this.map) return;

                // 📌 기존 마커 제거
                this.markers.forEach(marker => marker.setMap(null));
                this.markers = [];

                this.posts.forEach(post => {
                    let coords = new kakao.maps.LatLng(post.latitude, post.longitude);
                    let marker = new kakao.maps.Marker({
                        position: coords,
                        map: this.map
                    });

                    // 📌 마커 클릭 시 모달 띄우기
                    kakao.maps.event.addListener(marker, 'click', () => {
                        this.selectedPost = post;
                    });

                    this.markers.push(marker); // 📌 생성된 마커를 배열에 저장
                });
            }
        }));
    });
    </script>
</body>
</html>
