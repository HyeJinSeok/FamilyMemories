<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="includes/header.jsp" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>회원가입</title>
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

    <div class="max-w-md mx-auto bg-white p-6 rounded-lg shadow-lg" x-data="registerForm">
        <h2 class="text-2xl font-bold mb-4">📝 회원가입</h2>

        <input type="text" placeholder="아이디" x-model="username" class="w-full p-2 border rounded mb-2">
        <input type="password" placeholder="비밀번호" x-model="password" class="w-full p-2 border rounded mb-2">

        <button class="w-full bg-green-500 text-white p-2 rounded mt-2 hover:bg-green-600 transition" @click="register">회원가입</button>
    </div>
</body>
</html>
