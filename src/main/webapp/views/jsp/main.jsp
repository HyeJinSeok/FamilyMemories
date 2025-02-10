<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ page import="java.util.List, domain.Post, domain.Family, domain.User" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>메인 페이지</title>
  <!-- Tailwind CSS -->
  <script src="https://cdn.tailwindcss.com"></script>
  <!-- Alpine.js 최신 버전 (예: 3.12.0) -->
  <script src="https://cdn.jsdelivr.net/npm/alpinejs@3.12.0/dist/cdn.min.js" defer></script>
  <!-- Kakao 지도 API (defer, autoload=false) -->
<script type="text/javascript" 
        src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=fa4ea1c9043252a4e21db24e7aa57069&libraries=services&autoload=false"
        defer></script>
  
  <!-- Alpine 컴포넌트 등록 -->
  <script defer>
    document.addEventListener('alpine:init', () => {
      Alpine.data('mapApp', () => ({
        posts: [],
        selectedPost: null, // 리스트 또는 마커 클릭 시 상세 정보를 보여줄 게시글
        markers: [],        // 지도에 추가된 마커들을 저장하는 배열
        map: null,
        geocodeCache: {},   // 주소 → 좌표 변환 결과 캐시

        init() {
          this.loadPosts();
          this.initMap();
        },
        loadPosts() {
          // localStorage 캐시 우선 사용
          let cachedPosts = localStorage.getItem("posts");
          if (cachedPosts) {
            this.posts = JSON.parse(cachedPosts);
            // 만약 map이 이미 생성되었으면 마커 갱신
            if (this.map) {
              this.updateMarkers();
            }
          }
          // Ajax 요청: 서버에서 전체 게시글 JSON 데이터 받아오기
          fetch("<%= request.getContextPath() %>/main", {
            headers: {
              "X-Requested-With": "XMLHttpRequest"
            }
          })
          .then(res => res.json())
          .then(data => {
            this.posts = data;
            localStorage.setItem("posts", JSON.stringify(data));
            console.log("게시글 데이터:", this.posts);
            // map이 생성되어 있으면 마커 갱신
            if (this.map) {
              this.updateMarkers();
            }
          })
          .catch(error => console.error("❌ 데이터 로드 오류:", error));
        },
        initMap() {
            console.log("initMap 호출됨");

            // Kakao API가 로드되지 않았으면 500ms 후 재시도
            if (!window.kakao || !window.kakao.maps) {
                console.error("⚠️ Kakao API가 아직 로드되지 않음. 500ms 후 재시도...");
                setTimeout(() => this.initMap(), 500);
                return;
            }

            console.log("Kakao API 로드 완료");

            // ✅ `window.kakao.maps.load()` 내부에서 지도 생성 (이전에는 없던 부분)
            window.kakao.maps.load(() => {
                console.log("window.kakao.maps.load() 호출됨");

                // 📌 지도 생성
                this.map = new window.kakao.maps.Map(document.getElementById("map"), {
                    center: new window.kakao.maps.LatLng(37.5665, 126.9780),
                    level: 7
                });

                // ✅ `idle` 이벤트에 디바운스 적용: 지도 이동 후 500ms 동안 추가 호출 없으면 updateMarkers() 실행
                let debounceTimer;
                window.kakao.maps.event.addListener(this.map, "idle", () => {
                    clearTimeout(debounceTimer);
                    debounceTimer = setTimeout(() => {
                        this.updateMarkers();
                    }, 500);
                });

                // ✅ 초기 마커 업데이트
                this.updateMarkers();
            });
        },
        updateMarkers() {
          if (!this.map) return;
          // 카카오 지도 API의 geocoder 객체가 준비되어 있는지 확인
          if (!window.kakao.maps.services || !window.kakao.maps.services.Geocoder) {
            console.error("kakao.maps.services.Geocoder가 아직 로드되지 않음");
            return;
          }
          // 기존 마커 제거
          this.markers.forEach(marker => marker.setMap(null));
          this.markers = [];
          // 각 게시글에 대해 마커 생성
          this.posts.forEach(post => {
            // 만약 latitude와 longitude 값이 있으면 그대로 사용
            if (post.latitude && post.longitude) {
              let coords = new window.kakao.maps.LatLng(post.latitude, post.longitude);
              this.createMarker(post, coords);
            } else {
              // 주소 기반 좌표 변환: 캐시된 결과가 있으면 사용
              if (this.geocodeCache[post.location]) {
                let cached = this.geocodeCache[post.location];
                let coords = new window.kakao.maps.LatLng(cached.y, cached.x);
                this.createMarker(post, coords);
              } else {
                const geocoder = new window.kakao.maps.services.Geocoder();
                geocoder.addressSearch(post.location, (result, status) => {
                  if (status === window.kakao.maps.services.Status.OK) {
                    let coords = new window.kakao.maps.LatLng(result[0].y, result[0].x);
                    // 캐시 저장
                    this.geocodeCache[post.location] = { y: result[0].y, x: result[0].x };
                    this.createMarker(post, coords);
                  } else {
                    console.warn("❗ 주소 변환 실패:", post.location, status);
                  }
                });
              }
            }
          });
        },
        createMarker(post, coords) {
          let marker = new kakao.maps.Marker({
            position: coords,
            map: this.map
          });
          // 마커 클릭 시 모달창에 해당 게시글 상세 정보를 표시
          kakao.maps.event.addListener(marker, 'click', () => {
            this.selectedPost = post;
          });
          this.markers.push(marker);
        }
      }));
    });
    
    
  </script>
</head>
<body class="bg-gray-100 p-6" x-data="mapApp()">
  <!-- Navigation Bar -->
  <nav class="bg-blue-500 p-4 text-white flex justify-between">
    <a href="main" class="text-lg font-bold">여행 기록</a>
    <ul class="flex space-x-4">
      <li><a href="mypage" class="hover:underline">마이페이지</a></li>
      <li><a href="post" class="hover:underline">게시글 작성</a></li>
      <li><a href="recommend" class="hover:underline">추천 여행지</a></li>
    </ul>
  </nav>
  <!-- Main Layout -->
  <div class="max-w-6xl mx-auto flex gap-4 mt-6">
    <!-- Post List (Left) -->
    <div class="w-1/3 bg-white p-4 rounded-lg shadow-lg max-h-[500px] overflow-y-scroll">
      <h2 class="text-xl font-bold mb-4"><i class="fas fa-scroll"></i> 가족 여행 기록</h2>
      <ul x-show="posts.length > 0">
        <template x-for="(post, index) in posts" :key="index">
          <li class="p-3 border-b hover:bg-gray-100 cursor-pointer" @click="selectedPost = post">
            <h3 class="text-lg font-bold" x-text="post.title"></h3>
            <p class="text-gray-600" x-text="post.description"></p>
          </li>
        </template>
      </ul>
    </div>
    <!-- KakaoMap (Right) -->
    <div class="w-2/3">
      <h2 class="text-2xl font-bold mb-4"><i class="fas fa-map-pin"></i> 여행 기록 지도</h2>
      <div id="map" class="w-full h-[500px] bg-gray-200"></div>
    </div>
  </div>
  <!-- Modal Dialog -->
  <div class="fixed inset-0 z-50 bg-black bg-opacity-50 flex justify-center items-center"
       x-show="selectedPost">
    <div class="bg-white p-6 rounded-lg shadow-lg w-96">
      <h2 class="text-xl font-bold" x-text="selectedPost ? selectedPost.title : ''"></h2>
      <p class="mt-2 text-gray-700" x-text="selectedPost ? selectedPost.description : ''"></p>
      <p x-text="selectedPost ? 'Location: ' + selectedPost.location : ''"></p>
      <p x-text="selectedPost ? 'Dates: ' + selectedPost.startDate + ' - ' + selectedPost.endDate : ''"></p>
      <img :src="selectedPost ? selectedPost.imgsrc : ''" alt="Post Image" class="w-full h-64 object-cover rounded mt-2">
      <button class="mt-4 bg-red-500 text-white p-2 rounded" @click="selectedPost = null"><i class="fas fa-times"></i> 닫기</button>
    </div>
  </div>
  
  <script>
document.addEventListener('DOMContentLoaded', function() {
    if (window.kakao && window.kakao.maps) {
        try {
            var testLatLng = new window.kakao.maps.LatLng(37.5665, 126.9780);
            console.log("DOMContentLoaded: 테스트 LatLng 생성 성공:", testLatLng);
        } catch(e) {
            console.error("DOMContentLoaded: LatLng 생성 오류:", e);
        }
    } else {
        console.error("DOMContentLoaded: Kakao Maps SDK가 완전히 로드되지 않음");
    }
});
</script>
  
</body>


</html>
