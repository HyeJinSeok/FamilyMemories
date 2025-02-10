<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>메인 페이지</title>
  <script src="https://cdn.tailwindcss.com"></script>
  <!-- Alpine.js 최신 버전 (예: 3.12.0) -->
  <script src="https://cdn.jsdelivr.net/npm/alpinejs@3.12.0/dist/cdn.min.js" defer></script>
  <!-- Kakao 지도 API (defer) -->
  <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=fa4ea1c9043252a4e21db24e7aa57069&autoload=false" defer></script>
  
  <!-- Alpine 컴포넌트 등록: 지도 초기화, 게시글 로드, 마커 업데이트 -->
  <script defer>
    document.addEventListener('alpine:init', () => {
      Alpine.data('mapApp', () => ({
        posts: [],
        selectedPost: null, // 클릭한 게시글 전체 정보
        markers: [],
        map: null,
  
        init() {
          this.loadPosts();
          this.initMap();
        },
  
        loadPosts() {
          // 로컬 스토리지에 캐시된 게시글이 있으면 먼저 사용
          let cachedPosts = localStorage.getItem("posts");
          if (cachedPosts) {
            this.posts = JSON.parse(cachedPosts);
            this.updateMarkers();
          }
  
          // Ajax 요청: "X-Requested-With" 헤더를 추가해서 서블릿에서 Ajax 요청임을 인식하도록 함
          fetch("<%= request.getContextPath() %>/main", {
            headers: {
              "X-Requested-With": "XMLHttpRequest"
            }
          })
          .then(res => res.json())
          .then(data => {
            this.posts = data;
            localStorage.setItem("posts", JSON.stringify(data));
            console.log(this.posts);
            this.updateMarkers();
          })
          .catch(error => console.error("❌ 데이터 로드 오류:", error));
        },
  
        initMap() {
          if (!window.kakao || !window.kakao.maps) {
            console.error("⚠️ Kakao API가 아직 로드되지 않음. 500ms 후 다시 시도...");
            setTimeout(() => this.initMap(), 500);
            return;
          }
  
          kakao.maps.load(() => {
            this.map = new kakao.maps.Map(document.getElementById("map"), {
              center: new kakao.maps.LatLng(37.5665, 126.9780),
              level: 7
            });
  
            // 지도 이동 시 마커 갱신
            kakao.maps.event.addListener(this.map, "idle", () => {
              this.updateMarkers();
            });
  
            this.updateMarkers();
          });
        },
  
        updateMarkers() {
          if (!this.map) return;
  
          // 기존 마커 제거
          this.markers.forEach(marker => marker.setMap(null));
          this.markers = [];
  
          // 각 게시글에 대해 마커 생성
          this.posts.forEach(post => {
            let coords = new kakao.maps.LatLng(post.latitude, post.longitude);
            let marker = new kakao.maps.Marker({
              position: coords,
              map: this.map
            });
  
            // 마커 클릭 시 해당 게시글을 모달창으로 표시
            kakao.maps.event.addListener(marker, 'click', () => {
              this.selectedPost = post;
            });
  
            this.markers.push(marker);
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
  
  <!-- 메인 레이아웃: 게시글 리스트와 카카오맵 -->
  <div class="max-w-6xl mx-auto flex gap-4 mt-6">
    <!-- 게시글 리스트 (왼쪽) -->
    <div class="w-1/3 bg-white p-4 rounded-lg shadow-lg max-h-[500px] overflow-y-scroll">
      <h2 class="text-xl font-bold mb-4">📜 가족 여행 기록</h2>
      <ul>
        <template x-for="post in posts" :key="post.id">
          <!-- 게시글 클릭 시 selectedPost에 전체 정보를 저장 -->
          <li class="p-3 border-b hover:bg-gray-100 cursor-pointer" @click="selectedPost = post">
            <h3 class="text-lg font-bold" x-text="post.title"></h3>
            <p class="text-gray-600" x-text="post.description"></p>
          </li>
        </template>
      </ul>
    </div>
    
    <!-- 카카오맵 (오른쪽) -->
    <div class="w-2/3">
      <h2 class="text-2xl font-bold mb-4">📍 여행 기록 지도</h2>
      <div id="map" class="w-full h-[500px] bg-gray-200"></div>
    </div>
  </div>
  
  <!-- 모달창: 게시글 클릭 시 전체 정보(제목, 설명, 위치, 날짜, 이미지) 표시 -->
  <div class="fixed inset-0 z-50 bg-black bg-opacity-50 flex justify-center items-center"
       x-show="selectedPost"
       x-transition:enter="transition ease-out duration-300"
       x-transition:enter-start="opacity-0"
       x-transition:enter-end="opacity-100"
       x-transition:leave="transition ease-in duration-200"
       x-transition:leave-start="opacity-100"
       x-transition:leave-end="opacity-0"
       @click.away="selectedPost = null">
    <div class="bg-white p-4 rounded-lg shadow-lg max-w-lg w-full">
      <h2 class="font-bold text-xl mb-2" x-text="selectedPost.title"></h2>
      <p x-text="selectedPost.description"></p>
      <p class="mt-2" x-text="'Location: ' + selectedPost.location"></p>
      <p class="mt-2" x-text="'Dates: ' + selectedPost.startDate + ' - ' + selectedPost.endDate"></p>
      <img :src="selectedPost.imgsrc" alt="Post Image" class="w-full h-64 object-cover rounded mt-2">
      <button @click="selectedPost = null" class="mt-4 bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded">
        Close
      </button>
    </div>
  </div>
</body>
</html>
