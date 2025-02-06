<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>마이페이지</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://cdn.jsdelivr.net/npm/alpinejs@3.x.x/dist/cdn.min.js" defer></script>
</head>
<body class="bg-gray-100 p-6" x-data="calendarApp">
	<nav class="bg-blue-500 p-4 text-white flex justify-between">
	    <a href="main.jsp" class="text-lg font-bold">여행 기록</a>
	    <ul class="flex space-x-4">
	        <li><a href="mypage" class="hover:underline">마이페이지</a></li>
	        <li><a href="post" class="hover:underline">게시글 작성</a></li>
	        <li><a href="recommend" class="hover:underline">추천 여행지</a></li>
	    </ul>
	</nav>

    <div class="max-w-4xl mx-auto">
        <h2 class="text-2xl font-bold mb-4">👨‍👩‍👧‍👦 가족 공유 캘린더</h2>
        <table class="w-full bg-white shadow-lg rounded-lg">
            <tr class="bg-blue-500 text-white">
                <th class="p-3">날짜</th>
                <th class="p-3">이벤트</th>
            </tr>
            <template x-for="event in events">
                <tr class="border-t">
                    <td class="p-3" x-text="event.date"></td>
                    <td class="p-3" x-text="event.description"></td>
                </tr>
            </template>
        </table>
    </div>

    <script>
        document.addEventListener('alpine:init', () => {
            Alpine.data('calendarApp', () => ({
                events: [],

                init() {
                    this.loadEvents();
                },

                loadEvents() {
                    fetch("getCalendar.jsp")
                        .then(res => res.json())
                        .then(data => {
                            this.events = data;
                        });
                }
            }));
        });
    </script>
</body>
</html>
