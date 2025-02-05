<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="includes/header.jsp" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>로그인</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://cdn.jsdelivr.net/npm/alpinejs@3.x.x/dist/cdn.min.js" defer></script>
</head>
<body class="bg-gray-100 p-6">
    <div class="max-w-md mx-auto bg-white p-6 rounded-lg shadow-lg" x-data="loginForm">
        <h2 class="text-2xl font-bold mb-4">🔑 로그인</h2>

        <input type="text" placeholder="아이디" x-model="username" class="w-full p-2 border rounded mb-2">
        <input type="password" placeholder="비밀번호" x-model="password" class="w-full p-2 border rounded mb-2">

        <button class="w-full bg-blue-500 text-white p-2 rounded mt-2 hover:bg-blue-600 transition" @click="login">로그인</button>
    </div>

    <script>
        document.addEventListener('alpine:init', () => {
            Alpine.data('loginForm', () => ({
                username: '',
                password: '',

                login() {
                    fetch("loginAction.jsp", {
                        method: "POST",
                        headers: { "Content-Type": "application/json" },
                        body: JSON.stringify({
                            username: this.username,
                            password: this.password
                        })
                    }).then(res => res.json())
                    .then(data => {
                        if (data.success) {
                            alert("로그인 성공!");
                            window.location.href = "main.jsp";
                        } else {
                            alert("로그인 실패!");
                        }
                    });
                }
            }));
        });
    </script>
</body>
</html>
