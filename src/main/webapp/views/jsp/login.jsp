<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>여행 가족 기록 | 로그인</title>
    
    <!-- Tailwind CSS -->
    <script src="https://cdn.tailwindcss.com"></script>
    
    <!-- Alpine.js -->
    <script src="https://cdn.jsdelivr.net/npm/alpinejs@3.x.x/dist/cdn.min.js" defer></script>

    <style>
        /* 배경 이미지 스타일 */
        .bg-travel {
            background: url('https://source.unsplash.com/1600x900/?travel,family') no-repeat center center/cover;
        }
    </style>
</head>
<body class="bg-travel h-screen flex items-center justify-center">
    
    <div class="max-w-md w-full bg-white bg-opacity-90 p-8 rounded-lg shadow-lg backdrop-blur-md" x-data="loginForm">
        
        <!-- 타이틀 -->
        <h2 class="text-3xl font-bold text-center text-blue-600 mb-6">🌍 여가錄</h2>
        <p class="text-center text-gray-600 mb-4">여행의 추억을 가족과 함께 기록하세요.</p>

        <!-- 로그인 폼 -->
        <form method="post" action="login" class="space-y-4">
            <input type="text" name="id" placeholder="아이디" class="w-full p-3 border border-gray-300 rounded-lg focus:ring focus:ring-blue-300" required>
            <input type="password" name="pw" placeholder="비밀번호" class="w-full p-3 border border-gray-300 rounded-lg focus:ring focus:ring-blue-300" required>
            
            <button type="submit" class="w-full bg-blue-500 text-white p-3 rounded-lg hover:bg-blue-600 transition">
                로그인
            </button>
        </form>

        <!-- 회원가입 버튼 -->
        <div class="mt-6 text-center">
            <p class="text-gray-700"></p>
            <button onclick="location.href='register'" class="mt-2 w-full bg-green-500 text-white p-3 rounded-lg hover:bg-green-600 transition">
                회원가입
            </button>
        </div>
    </div>

</body>
</html>

