<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="java.util.List" %>
<%@ page import="domain.Post" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>메인 페이지</title>
    <!-- Tailwind CSS -->
    <script src="https://cdn.tailwindcss.com"></script>
    <!-- Alpine.js 최신 버전 (예: 3.12.0) -->
    <script src="https://cdn.jsdelivr.net/npm/alpinejs@3.12.0/dist/cdn.min.js" defer></script>
    <!-- Kakao 지도 API (defer) -->
    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=fa4ea1c9043252a4e21db24e7aa57069&autoload=false" defer></script>
    
    <!-- 서버에서 전달한 posts를 JSON 문자열로 초기화 -->
    <script>
        // request attribute "posts"를 JSON 문자열로 변환하여 initialPosts 변수에 저장
        var initialPosts = <%= new Gson().toJson((List<Post>)request.getAttribute("posts")) %>;
    </script>
    
    <!-- Alpine.js 컴포넌트 등록 -->
    <script defer>
        document.addEventListener('alpine:init', () => {
            Alpine.data('mapApp', () => ({
                posts: initialPosts, // 서버에서 받아온 전체 게시글 배열
                selectedPost: null,   // 모달창에 표시할 게시글
                markers: [],          // 지도에 추가된 마커들을 저장할 배열
                map: null,

                init() {
                    this.initMap();
                },

                initMap() {
                    if (!window.kakao || !window.kakao.maps) {
                        console.error("⚠️ Kakao API가 아직 로드되지 않음. 500ms 후 다시 시도...");
                        setTimeout(() => this.initMap(), 500);
                        return;
                    }
                    // 카카오 지도 생성
                    kakao.maps.load(() => {
                        this.map = new kakao.maps.Map(document.getElementById("map"), {
                            center: new kakao.maps.LatLng(37.5665, 126.9780),
                            level: 7
                        });
                        // 지도 idle 이벤트 시 마커 재설정
                        kakao.maps.event.addListener(this.map, "idle", () => {
                            this.addMarkers();
                        });
                        // 초기 마커 추가
                        this.addMarkers();
                    });
                },

                addMarkers() {
                    if (!this.map) return;
                    
                    // 기존 마커 제거
                    this.markers.forEach(marker => marker.setMap(null));
                    this.markers = [];
                    
                    // geocoder 생성
                    const geocoder = new kakao.maps.services.Geocoder();
                    
                    this.posts.forEach(post => {
                        // 주소를 기반으로 좌표 변환
                    	geocoder.addressSearch(post.location, (result, status) => {
                    	    if (status === kakao.maps.services.Status.OK) {
                    	        console.log(`주소 변환 성공: ${post.location}`, result[0]);
                    	        let coords = new kakao.maps.LatLng(result[0].y, result[0].x);
                    	        let marker = new kakao.maps.Marker({
                    	            position: coords,
                    	            map: this.map
                    	        });
                    	        kakao.maps.event.addListener(marker, 'click', () => {
                    	            this.selectedPost = post;
                    	        });
                    	        this.markers.push(marker);
                    	    } else {
                    	        console.warn(`❗ 주소 변환 실패: ${post.location}`, status);
                    	    }
                    	});
                    });
                }
            }));
        });
    </script>
</head>
<body class="bg-gray-100 p-6" x-data="mapApp()">
    <!-- 네비게이션 바 -->
    <nav class="bg-blue-500 p-4 text-white flex justify-between">
        <a href="main" class="text-lg font-bold">여행 기록</a>
        <ul class="flex space-x-4">
            <li><a href="mypage" class="hover:underline">마이페이지</a></li>
            <li><a href="post" class="hover:underline">게시글 작성</a></li>
            <li><a href="recommend" class="hover:underline">추천 여행지</a></li>
        </ul>
    </nav>
    
    <!-- 메인 레이아웃: 좌측 게시글 리스트, 우측 지도 -->
    <div class="max-w-6xl mx-auto flex gap-4 mt-6">
        <!-- 게시글 리스트 (좌측) -->
        <div class="w-1/3 bg-white p-4 rounded-lg shadow-lg max-h-[500px] overflow-y-scroll">
            <h2 class="text-xl font-bold mb-4">📜 가족 여행 기록</h2>
            <ul>
                <!-- 각 게시글 클릭 시 selectedPost에 저장하여 모달창 표시 -->
                <%
                    List<Post> posts = (List<Post>) request.getAttribute("posts");
                    if (posts != null && !posts.isEmpty()) {
                        for (Post post : posts) {
                %>
                    <div @click="selectedPost = {
                            title: '<%= post.getTitle() %>',
                            description: '<%= post.getDescription() %>',
                            location: '<%= post.getLocation() %>',
                            startDate: '<%= post.getStartDate() %>',
                            endDate: '<%= post.getEndDate() %>',
                            imgsrc: '<%= post.getImgsrc() %>'
                        }" class="cursor-pointer hover:bg-gray-100 p-2">
                        <h3 class="text-xl font-semibold"><%= post.getTitle() %></h3>
                    </div>
                <%
                        }
                    } else {
                %>
                    <p class="text-gray-600">아직 작성한 게시물이 없습니다.</p>
                <%
                    }
                %>
            </ul>
        </div>
        
        <!-- 카카오 지도 (우측) -->
        <div class="w-2/3">
            <h2 class="text-2xl font-bold mb-4">📍 여행 기록 지도</h2>
            <div id="map" class="w-full h-[500px] bg-gray-200"></div>
        </div>
    </div>
    
    <!-- 모달창 (마커 클릭 또는 게시글 리스트 클릭 시) -->
    <div class="fixed inset-0 z-50 bg-black bg-opacity-50 flex justify-center items-center" 
         x-show="selectedPost"
         x-transition:enter="transition ease-out duration-300"
         x-transition:enter-start="opacity-0"
         x-transition:enter-end="opacity-100"
         x-transition:leave="transition ease-in duration-200"
         x-transition:leave-start="opacity-100"
         x-transition:leave-end="opacity-0"
         @click.away="selectedPost = null">
        <div class="bg-white p-6 rounded-lg shadow-lg w-96">
            <h2 class="text-xl font-bold" x-text="selectedPost ? selectedPost.title : ''"></h2>
            <p class="mt-2 text-gray-700" x-text="selectedPost ? selectedPost.description : ''"></p>
            <p x-text="selectedPost ? 'Location: ' + selectedPost.location : ''"></p>
            <p x-text="selectedPost ? 'Dates: ' + selectedPost.startDate + ' - ' + selectedPost.endDate : ''"></p>
            <img :src="selectedPost ? selectedPost.imgsrc : ''" alt="Post Image" class="w-full h-64 object-cover rounded mt-2">
            <button class="mt-4 bg-red-500 text-white p-2 rounded" @click="selectedPost = null">닫기</button>
        </div>
    </div>
</body>
</html>
