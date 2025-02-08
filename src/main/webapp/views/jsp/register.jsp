<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>회원가입</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://cdn.jsdelivr.net/npm/alpinejs@3.x.x/dist/cdn.min.js" defer></script>
</head>
<body class="bg-gray-100 p-6">

    <div class="max-w-md mx-auto bg-white p-6 rounded-lg shadow-lg">
        <h2 class="text-2xl font-bold mb-4">📝 회원가입</h2>

        <form action="<%= request.getContextPath() %>/register" method="post">
            <input type="text" name="name" placeholder="이름" class="w-full p-2 border rounded mb-2" required>
            <input type="text" name="id" placeholder="아이디" class="w-full p-2 border rounded mb-2" required>
            <input type="password" name="password" placeholder="비밀번호" class="w-full p-2 border rounded mb-2" required>
            <input type="email" name="email" placeholder="이메일" class="w-full p-2 border rounded mb-2" required>
            <input type="text" name="fid" placeholder="가족 그룹 ID" class="w-full p-2 border rounded mb-2" required>

            <button type="submit" class="w-full bg-green-500 text-white p-2 rounded mt-2 hover:bg-green-600 transition">
                회원가입
            </button>
        </form>

        <%-- 회원가입 결과 메시지 --%>
        <%
            String status = request.getParameter("status");
            if ("success".equals(status)) {
        %>
            <p class="text-green-600 font-bold mt-2">✅ 회원가입이 완료되었습니다!</p>
        <%
            } else if ("failure".equals(status)) {
        %>
            <p class="text-red-600 font-bold mt-2">❌ 회원가입에 실패했습니다. 다시 시도해주세요.</p>
        <%
            }
        %>
    </div>

</body>
</html>
