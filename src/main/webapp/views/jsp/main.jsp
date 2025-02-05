<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="includes/header.jsp" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>메인 페이지</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://cdn.jsdelivr.net/npm/alpinejs@3.x.x/dist/cdn.min.js" defer></script>
    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=YOUR_KAKAO_API_KEY"></script>
</head>
<body class="bg-gray-100 p-6" x-data="mapApp">
	<nav class="bg-blue-500 p-4 text-white flex justify-between">
	    <a href="main.jsp" class="text-lg font-bold">여행 기록</a>
	    <ul class="flex space-x-4">
	        <li><a href="mypage.jsp" class="hover:underline">마이페이지</a></li>
	        <li><a href="post.jsp" class="hover:underline">게시글 작성</a></li>
	        <li><a href="recommend.jsp" class="hover:underline">추천 여행지</a></li>
	    </ul>
	</nav>

    <div class="max-w-4xl mx-auto">
        <h2 class="text-2xl font-bold mb-4">📍 여행 기록 지도</h2>
        <div id="map" class="w-full h-96 bg-gray-200"></div>

        <!-- 모달 -->
        <div class="fixed inset-0 bg-black bg-opacity-50 flex justify-center items-center" x-show="selectedPost" x-transition>
            <div class="bg-white p-6 rounded-lg shadow-lg w-96">
                <h2 class="text-xl font-bold" x-text="selectedPost.title"></h2>
                <p x-text="selectedPost.description" class="mt-2 text-gray-700"></p>
                <button class="mt-4 bg-red-500 text-white p-2 rounded" @click="selectedPost = null">닫기</button>
            </div>
        </div>
    </div>

    <script>
        document.addEventListener('alpine:init', () => {
            Alpine.data('mapApp', () => ({
                posts: [],
                selectedPost: null,

                init() {
                    this.loadPosts();
                    this.initMap();
                },

                initMap() {
                    kakao.maps.load(() => {
                        this.map = new kakao.maps.Map(document.getElementById('map'), {
                            center: new kakao.maps.LatLng(37.5665, 126.9780),
                            level: 7
                        });
                        this.addMarkers();
                    });
                },

                loadPosts() {
                    fetch("getPosts.jsp")
                        .then(res => res.json())
                        .then(data => {
                            this.posts = data;
                            this.addMarkers();
                        });
                },

                addMarkers() {
                    if (!this.map) return;
                    this.posts.forEach(post => {
                        let marker = new kakao.maps.Marker({
                            position: new kakao.maps.LatLng(post.latitude, post.longitude),
                            map: this.map
                        });

                        kakao.maps.event.addListener(marker, 'click', () => {
                            this.selectedPost = post;
                        });
                    });
                }
            }));
        });
    </script>
</body>
</html>
