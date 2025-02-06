<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" language="java"  %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>추천 여행지</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://cdn.jsdelivr.net/npm/alpinejs@3.x.x/dist/cdn.min.js" defer></script>
</head>
<body class="bg-gray-100 p-6">
	<nav class="bg-blue-500 p-4 text-white flex justify-between">
	    <a href="main.jsp" class="text-lg font-bold">여행 기록</a>
	    <ul class="flex space-x-4">
	        <li><a href="mypage.jsp" class="hover:underline">마이페이지</a></li>
	        <li><a href="post.jsp" class="hover:underline">게시글 작성</a></li>
	        <li><a href="recommend.jsp" class="hover:underline">추천 여행지</a></li>
	    </ul>
	</nav>

    <div class="max-w-4xl mx-auto" x-data="recommendApp">
        <h2 class="text-2xl font-bold mb-4">🌍 추천 여행지</h2>
        
        <button class="bg-green-500 text-white p-2 rounded" @click="fetchRecommendations">추천 여행지 보기</button>

        <ul class="mt-4">
            <template x-for="place in recommendations">
                <li class="p-3 bg-white rounded-lg shadow-md mt-2">
                    <h3 class="text-lg font-bold" x-text="place.name"></h3>
                    <p x-text="place.description"></p>
                </li>
            </template>
        </ul>
    </div>

    <script>
        document.addEventListener('alpine:init', () => {
            Alpine.data('recommendApp', () => ({
                recommendations: [],

                fetchRecommendations() {
                    fetch("getRecommendations.jsp")
                        .then(res => res.json())
                        .then(data => {
                            this.recommendations = data;
                        });
                }
            }));
        });
    </script>
</body>
</html>
