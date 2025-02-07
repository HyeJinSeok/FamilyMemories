<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>게시글 작성</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://cdn.jsdelivr.net/npm/alpinejs@3.x.x/dist/cdn.min.js" defer></script>
</head>
<body class="bg-gray-100 p-6">
	<nav class="bg-blue-500 p-4 text-white flex justify-between">
	    <a href="main.jsp" class="text-lg font-bold">여행 기록</a>
	    <ul class="flex space-x-4">
	        <li><a href="mypage" class="hover:underline">마이페이지</a></li>
	        <li><a href="post" class="hover:underline">게시글 작성</a></li>
	        <li><a href="recommend" class="hover:underline">추천 여행지</a></li>
	    </ul>
	</nav>


    <div class="max-w-2xl mx-auto bg-white p-6 rounded-lg shadow-lg">
        <h2 class="text-2xl font-bold mb-4">✍ 게시글 작성</h2>

        <%-- 게시글 등록 성공/실패 메시지 출력 --%>
        <%
            String status = request.getParameter("status");
            if ("success".equals(status)) {
        %>
            <p class="text-green-600 font-bold mb-2">✅ 게시글이 성공적으로 등록되었습니다!</p>
        <%
            } else if ("failure".equals(status)) {
        %>
            <p class="text-red-600 font-bold mb-2">❌ 게시글 등록에 실패하였습니다. 다시 시도해주세요.</p>
        <%
            }
        %>

        <form action="post" method="post">
            <input type="text" name="title" placeholder="제목" class="w-full p-2 border rounded mb-2">
            <textarea name="description" placeholder="내용" class="w-full p-2 border rounded mb-2"></textarea>
            <input type="date" name="start_date" class="w-full p-2 border rounded mb-2">
            <input type="date" name="end_date" class="w-full p-2 border rounded mb-2">
            <input type="text" name="location" placeholder="위치" class="w-full p-2 border rounded mb-2">
            <input type="text" name="imgsrc" placeholder="이미지 URL" class="w-full p-2 border rounded mb-2">
            <input type="number" name="fid" placeholder="가족 그룹 ID" class="w-full p-2 border rounded mb-2">
            
            <button type="submit" class="w-full bg-blue-500 text-white p-2 rounded mt-2 hover:bg-blue-600 transition">
                게시글 등록
            </button>
        </form>
    </div>

</body>
</html>
