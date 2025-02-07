<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ page import="java.util.List, domain.Post, domain.Family, domain.User" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>마이페이지</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 p-6">
    <!-- 네비게이션 바 -->
    <nav class="bg-blue-500 p-4 text-white flex justify-between">
        <a href="main.jsp" class="text-lg font-bold">여행 기록</a>
        <ul class="flex space-x-4">
            <li><a href="mypage" class="hover:underline">마이페이지</a></li>
            <li><a href="post" class="hover:underline">게시글 작성</a></li>
            <li><a href="recommend" class="hover:underline">추천 여행지</a></li>
        </ul>
    </nav>

    <!-- 📝 내가 쓴 게시물 -->
    <div class="max-w-4xl mx-auto mt-10 bg-white p-6 rounded-lg shadow-lg">
        <h2 class="text-2xl font-bold text-blue-600 mb-4">📝 내가 쓴 게시물</h2>
        <%
            List<Post> myPosts = (List<Post>) request.getAttribute("myPosts");
            if (myPosts != null && !myPosts.isEmpty()) {
                for (Post post : myPosts) {
        %>
                    <div class="border-b pb-4 mb-4">
                        <h3 class="text-xl font-semibold"><%= post.getTitle() %></h3>
                        <p class="text-gray-600"><%= post.getDescription() %></p>
                        <p class="text-sm text-gray-400">📍 <%= post.getLocation() %> | 🗓 <%= post.getStartDate() %> ~ <%= post.getEndDate() %></p>
                        <% if (post.getImgsrc() != null && !post.getImgsrc().isEmpty()) { %>
                            <img src="<%= post.getImgsrc() %>" alt="Post Image" class="w-full h-40 object-cover rounded mt-2">
                        <% } %>
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

    <!-- 🏠 우리 가족 정보 -->
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


