<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ page import="java.util.List, domain.Post, domain.Family, domain.User" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>메인 페이지</title>
  <!-- FullCalendar CDN -->
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/fullcalendar@5.11.3/main.min.css">
  <script src="https://cdn.jsdelivr.net/npm/fullcalendar@5.11.3/main.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/fullcalendar@5.11.3/locales/ko.js"></script>
  
  <!-- Tailwind CSS -->
  <script src="https://cdn.tailwindcss.com"></script>
  
  <!-- Alpine.js -->
  <script src="https://cdn.jsdelivr.net/npm/alpinejs@3.12.0/dist/cdn.min.js" defer></script>
  
  <!-- Kakao 지도 API -->
  <script type="text/javascript" 
        src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=fa4ea1c9043252a4e21db24e7aa57069&libraries=services&autoload=false"
        defer></script>
  
  <script defer>
    document.addEventListener('alpine:init', () => {
      Alpine.data('mapApp', () => ({
        posts: [],
        selectedPost: null,
        map: null,
        markers: [],
        geocodeCache: {},

        init() {
          this.loadPosts();
          this.initMap();
        },
        
        loadPosts() {
          fetch("<%= request.getContextPath() %>/main", {
            headers: { "X-Requested-With": "XMLHttpRequest" }
          })
          .then(res => res.json())
          .then(data => {
            this.posts = data;
            console.log("✅ 게시글 로드 완료:", this.posts);
          })
          .catch(error => console.error("❌ 데이터 로드 오류:", error));
        },
        
        initMap() {
          if (!window.kakao || !window.kakao.maps) {
            setTimeout(() => this.initMap(), 500);
            return;
          }
          window.kakao.maps.load(() => {
            this.map = new window.kakao.maps.Map(document.getElementById("map"), {
              center: new window.kakao.maps.LatLng(37.5665, 126.9780),
              level: 7
            });
            this.updateMarkers();
          });
        },
        
        updateMarkers() {
          this.markers.forEach(marker => marker.setMap(null));
          this.markers = [];
          this.posts.forEach(post => {
            if (post.latitude && post.longitude) {
              let coords = new window.kakao.maps.LatLng(post.latitude, post.longitude);
              this.createMarker(post, coords);
            }
          });
        },
        
        createMarker(post, coords) {
          let marker = new kakao.maps.Marker({
            position: coords,
            map: this.map
          });
          kakao.maps.event.addListener(marker, 'click', () => {
            this.selectedPost = post;
          });
          this.markers.push(marker);
        },

        openPostDetail(post) {
          this.selectedPost = post;
        }
      }));
    });

    // 모달 외부 클릭 시 닫기
    window.addEventListener("click", function (event) {
      const modal = document.querySelector(".fixed.inset-0");
      if (modal && event.target === modal) {
        Alpine.store('mapApp').selectedPost = null;
      }
    });

    // FullCalendar 일정 불러오기
    document.addEventListener('DOMContentLoaded', function () {
      var calendarEl = document.getElementById('calendar');
      var calendar = new FullCalendar.Calendar(calendarEl, {
        locale: 'ko',
        initialView: 'dayGridMonth',
        headerToolbar: {
          left: 'prev,next today',
          center: 'title',
          right: 'dayGridMonth,timeGridWeek'
        },
        events: function(fetchInfo, successCallback, failureCallback) {
          fetch('<%= request.getContextPath() %>/main?type=schedule', {
            headers: { "X-Requested-With": "XMLHttpRequest" }
          })
          .then(response => response.json())
          .then(data => {
            let events = data.map(schedule => ({
              title: schedule.title,
              start: schedule.start,
              end: schedule.end,
              location: schedule.location
            }));
            successCallback(events);
          })
          .catch(error => {
            failureCallback(error);
          });
        }
      });
      calendar.render();
    });
  </script>

</head>
<body class="bg-gray-100 p-6" x-data="mapApp()">

  <!-- Navigation Bar -->
  <nav class="bg-blue-600 p-4 text-white flex justify-between items-center shadow-md">
    <a href="main" class="text-2xl font-bold">여행 기록</a>
    <ul class="flex space-x-6 text-lg">
      <li><a href="mypage" class="hover:underline">마이페이지</a></li>
      <li><a href="post" class="hover:underline">게시글 작성</a></li>
      <li><a href="recommend" class="hover:underline">추천 여행지</a></li>
    </ul>
  </nav>

  <!-- Main Layout -->
  <div class="max-w-7xl mx-auto flex gap-6 mt-6">
    <!-- Post List -->
    <div class="bg-white p-6 rounded-xl shadow-lg overflow-y-auto flex flex-col w-[55%] h-[650px]">
      <h2 class="text-2xl font-bold text-blue-600 mb-4">📜 가족 여행 기록</h2>
      <ul x-show="posts.length > 0" class="space-y-3 flex-grow overflow-y-auto">
        <template x-for="(post, index) in posts" :key="index">
          <li class="p-4 border rounded-lg shadow hover:bg-gray-100 cursor-pointer" @click="openPostDetail(post)">
            <h3 class="text-xl font-semibold" x-text="post.title"></h3>
            <p class="text-gray-600 text-sm" x-text="post.description"></p>
          </li>
        </template>
      </ul>
    </div>

    <!-- Calendar -->
    <div class="bg-white p-6 rounded-xl shadow-lg flex flex-col w-[50%] h-[650px]">
      <h2 class="text-2xl font-bold text-blue-600 mb-4">📅 가족 여행 일정</h2>
      <div id="calendar" class="border rounded-xl p-6 bg-gray-50 flex-grow min-h-[500px] h-full w-full overflow-hidden"></div>
    </div>
  </div>

  <!-- Kakao Map -->
  <div class="bg-white p-6 rounded-xl shadow-lg mt-6 max-w-7xl mx-auto">
    <h2 class="text-2xl font-bold text-blue-600 mb-4">📍 여행 기록 지도</h2>
    <div id="map" class="w-full h-[500px] bg-gray-200 rounded-lg"></div>
  </div>

  <!-- Modal -->
  <div class="fixed inset-0 z-50 bg-black bg-opacity-50 flex justify-center items-center" x-show="selectedPost">
    <div class="bg-white p-6 rounded-xl shadow-xl w-[400px] relative">
      <button class="absolute top-3 right-3 text-gray-600 hover:text-black text-2xl" @click="selectedPost = null">&times;</button>
      <h2 class="text-2xl font-bold mb-2 text-blue-600" x-text="selectedPost.title"></h2>
      <p class="text-gray-700 mb-2" x-text="selectedPost.description"></p>
      <p class="text-gray-600 text-sm" x-text="'📍 위치: ' + selectedPost.location"></p>
      <img :src="selectedPost.imgsrc" class="w-full h-48 object-cover rounded-lg mt-4">
    </div>
  </div>

</body>
</html>

