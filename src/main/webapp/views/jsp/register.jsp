<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>여가錄 | 회원가입</title>
    
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

    <div class="max-w-lg w-full bg-white bg-opacity-90 p-8 rounded-lg shadow-lg backdrop-blur-md">
        
        <!-- 타이틀 -->
        <h2 class="text-3xl font-bold text-center text-green-600 mb-4">📝 회원가입</h2>

        <!-- 회원가입 폼 -->
        <form action="<%= request.getContextPath() %>/register" method="post" class="space-y-4">
            <input type="text" name="name" placeholder="이름" class="w-full p-3 border border-gray-300 rounded-lg focus:ring focus:ring-green-300" required>
            <input type="text" name="id" placeholder="아이디" class="w-full p-3 border border-gray-300 rounded-lg focus:ring focus:ring-green-300" required>
            <input type="password" name="password" placeholder="비밀번호" class="w-full p-3 border border-gray-300 rounded-lg focus:ring focus:ring-green-300" required>
            <input type="email" name="email" placeholder="이메일" class="w-full p-3 border border-gray-300 rounded-lg focus:ring focus:ring-green-300" required>
            <input type="text" name="fid" placeholder="가족 그룹 ID" class="w-full p-3 border border-gray-300 rounded-lg focus:ring focus:ring-green-300" required>

            <button type="submit" class="w-full bg-green-500 text-white p-3 rounded-lg hover:bg-green-600 transition">
                회원가입
            </button>
        </form>


        <!-- 회원가입 결과 메시지 -->
        <%
            String status = request.getParameter("status");
            if ("success".equals(status)) {
        %>
            <p class="text-green-600 font-bold text-center mt-4">✅ 회원가입이 완료되었습니다!</p>
        <%
            } else if ("failure".equals(status)) {
        %>
            <p class="text-red-600 font-bold text-center mt-4">❌ 회원가입에 실패했습니다. 다시 시도해주세요.</p>
        <%
            }
        %>
    </div>

</body>
</html>

