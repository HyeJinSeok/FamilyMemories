<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="includes/header.jsp" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>게시글 작성</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://cdn.jsdelivr.net/npm/alpinejs@3.x.x/dist/cdn.min.js" defer></script>
</head>
<body class="bg-gray-100 p-6">
    <div class="max-w-2xl mx-auto bg-white p-6 rounded-lg shadow-lg" x-data="postForm">
        <h2 class="text-2xl font-bold mb-4">✍ 게시글 작성</h2>
        
        <input type="text" placeholder="제목" x-model="title" class="w-full p-2 border rounded mb-2">
        <textarea placeholder="내용" x-model="content" class="w-full p-2 border rounded mb-2"></textarea>
        <input type="number" placeholder="위도" x-model="latitude" class="w-full p-2 border rounded mb-2">
        <input type="number" placeholder="경도" x-model="longitude" class="w-full p-2 border rounded mb-2">
        
        <button class="w-full bg-blue-500 text-white p-2 rounded mt-2 hover:bg-blue-600 transition" @click="submitPost">게시글 등록</button>
    </div>

    <script>
        document.addEventListener('alpine:init', () => {
            Alpine.data('postForm', () => ({
                title: '',
                content: '',
                latitude: '',
                longitude: '',
                
                submitPost() {
                    fetch("addPost.jsp", {
                        method: "POST",
                        headers: { "Content-Type": "application/json" },
                        body: JSON.stringify({
                            title: this.title,
                            content: this.content,
                            latitude: this.latitude,
                            longitude: this.longitude
                        })
                    }).then(() => alert("게시글이 등록되었습니다!"));
                }
            }));
        });
    </script>
</body>
</html>
