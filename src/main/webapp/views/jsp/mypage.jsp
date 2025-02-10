<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ page import="java.util.List, domain.Post, domain.Family, domain.User" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>마이페이지</title>
    <script src="https://cdn.tailwindcss.com"></script>
<script
	src="https://cdn.jsdelivr.net/npm/alpinejs@3.x.x/dist/cdn.min.js" defer></script>
</head>
<body class="bg-gray-100 p-6">
    <!-- 네비게이션 바 -->
    <nav class="bg-blue-500 p-4 text-white flex justify-between">
        <a href="main" class="text-lg font-bold">여행 기록</a>
        <ul class="flex space-x-4">
            <li><a href="mypage" class="hover:underline">마이페이지</a></li>
            <li><a href="post" class="hover:underline">게시글 작성</a></li>
            <li><a href="recommend" class="hover:underline">추천 여행지</a></li>
        </ul>
    </nav>

<div class="max-w-4xl mx-auto mt-10 bg-white p-6 rounded-lg shadow-lg" x-data="{ showModal: false, selectedPost: {} }">
    <h2 class="text-2xl font-bold text-blue-600 mb-4">📝 내가 쓴 게시물</h2>
    <!-- 스크롤 가능한 영역 -->
    <div class="h-64 overflow-y-auto">
        <%
            List<Post> myPosts = (List<Post>) request.getAttribute("myPosts");
            if (myPosts != null && !myPosts.isEmpty()) {
                for (Post post : myPosts) {
        %>
                    <div @click="showModal = true; selectedPost = {title: '<%= post.getTitle() %>', description: '<%= post.getDescription() %>', location: '<%= post.getLocation() %>', startDate: '<%= post.getStartDate() %>', endDate: '<%= post.getEndDate() %>', imgsrc: '<%= post.getImgsrc() %>' }" class="cursor-pointer hover:bg-gray-100 p-2">
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
    </div>

    <!-- Modal Dialog (동일한 x-data 범위 내) -->
    <div x-show="showModal" class="fixed inset-0 bg-black bg-opacity-50 flex justify-center items-center"
         x-transition:enter="transition ease-out duration-300"
         x-transition:enter-start="opacity-0"
         x-transition:enter-end="opacity-100"
         x-transition:leave="transition ease-in duration-200"
         x-transition:leave-start="opacity-100"
         x-transition:leave-end="opacity-0"
         @click.away="showModal = false">
        <div class="bg-white p-4 rounded-lg shadow-lg max-w-lg w-full">
            <h2 class="font-bold text-xl mb-2" x-text="selectedPost.title"></h2>
            <p x-text="selectedPost.description"></p>
            <p x-text="'Location: ' + selectedPost.location"></p>
            <p x-text="'Dates: ' + selectedPost.startDate + ' - ' + selectedPost.endDate"></p>
            <img :src="selectedPost.imgsrc" alt="Post Image" class="w-full h-64 object-cover rounded mt-2">
            <button @click="showModal = false" class="mt-4 bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded">Close</button>
        </div>
    </div>
</div>


    <!-- 우리 가족 정보 -->
    <div class="max-w-4xl mx-auto mt-10 bg-white p-6 rounded-lg shadow-lg">
        <h2 class="text-2xl font-bold text-blue-600 mb-4">🏠 우리 가족 정보</h2>
        <%
            Family family = (Family) request.getAttribute("family");
            List<User> familyMembers = (List<User>) request.getAttribute("familyMembers");

            if (family != null) {
        %>
            <div class="bg-gray-100 p-4 rounded-lg shadow-md">
                <h3 class="text-lg font-bold">👨‍👩‍👧‍👦 가족명: <%= family.getFname() %></h3>
                <p class="text-gray-700">📝 설명: <%= family.getFdescription() %></p>

                <h4 class="text-md font-semibold mt-3">📌 가족 구성원</h4>
                <ul class="list-disc pl-5">
                <%
                    if (familyMembers != null && !familyMembers.isEmpty()) {
                        for (User user : familyMembers) {
                %>
                            <li class="text-gray-600">👤 <%= user.getName() %> (<%= user.getEmail() %>)</li>
                <%
                        }
                    } else {
                %>
                        <li class="text-gray-500">가족 구성원이 없습니다.</li>
                <%
                    }
                %>
                </ul>
            </div>
        <%
            }
        %>
    </div>
        <!-- 내 정보 -->
    <div class="max-w-4xl mx-auto mt-10 bg-white p-6 rounded-lg shadow-lg">
        <h2 class="text-2xl font-bold text-blue-600 mb-4">🙍‍♂️ 내 정보</h2>
        <%
            User user = (User) request.getAttribute("userInfo"); // 컨트롤러에서 전달된 내 정보
            if (user != null) {
        %>
            <div class="bg-gray-100 p-4 rounded-lg shadow-md">
                <p class="text-lg font-semibold">👤 이름: <%= user.getName() %></p>
                <p class="text-gray-700">📧 이메일: <%= user.getEmail() %></p>
            </div>
        <%
            } else {
        %>
            <p class="text-gray-600">사용자 정보를 불러올 수 없습니다.</p>
        <%
            }
        %>
    </div>

</body>
</html>


