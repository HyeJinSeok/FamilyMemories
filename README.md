# JSP/Servlet 기반 가족여행 기록 서비스 - 여가錄

<br>

'여가錄'은 여행•가족•기록(錄)의 줄임말로 가족과 함께한 여행을 기록 및 공유하는 서비스입니다. <br>

60대 이상 연령층이 쉽고 편리하게 추억을 00할 수 있도록 서비스를 구축하였습니다.

<br>

#### • 기술 목표

− Servlet 및 JSP 기반의 Web Application 개발 <br>

− Session을 통한 사용자 인증 및 상태 관리 <br>

− DataBase 연동으로 동적 데이터 처리

<br>

#### • 프로젝트 기간

📆 2025.02.03 ~ 2025.02.10

<br>

#### • 프로젝트 구조

[🔗 src/main 바로가기 클릭](./src/main)


<br>

#### • 팀원 소개

|<img src="https://avatars.githubusercontent.com/u/193798531?v=4" width="150" height="150"/>|<img src="https://avatars.githubusercontent.com/u/153366521?v=4" width="150" height="150"/>|<img src="https://avatars.githubusercontent.com/u/74342019?v=4" width="150" height="150"/>|<img src="https://avatars.githubusercontent.com/u/127267532?v=4" width="150" height="150"/>|
|:-:|:-:|:-:|:-:|
|[@riyeong0916](https://github.com/riyeong0916)|[@parkjhhh](https://github.com/parkjhhh)|[@CooolRyan](https://github.com/CooolRyan)|[@HyeJinSeok](https://github.com/HyeJinSeok)|


<br><br>

## ◈ 프로젝트 개요


### ▶ 가족여행 기록 및 플랜 추천 애플리케이션

- 지도 API 기반 여행지 탐색 기능 구현
- 여행 기록 포스팅(사진 업로드 및 게시글 작성 가능)
- ElasticSearch 기반 인기 여행지 분석 및 연관 검색어 추천 시스템 구축 (아이디어)

<br>

### ▶ 예상 타겟 고객층

- **50~60대 부모 세대** → 2030 자녀 세대를 통해 자연스럽게 유입
- **30~40대 부모 세대** → 영유아 자녀를 둔 가족 단위의 추가 유입

<br>

💡 가족 구성원 모두가 서비스를 편리하게 이용할 수 있도록 스마트폰 사용에 능숙하고, 여행을 다니는 데 제약이 적으며, 경제적 여유가 있어 평균적인 가족보다 **여행 빈도가 높은 계층**을 주요 타겟으로 설정하는 것이 적절하다고 판단했다.<br>

이러한 기준을 바탕으로, 2030 자녀 세대의 유입을 시작점으로 삼아 궁극적으로는 여가錄의 본래 타겟인 **은퇴 후 여유로운 삶을 즐기려는 50~60대 연령층**까지 자연스럽게 확산될 것이라는 의견을 모았다.<br>

또한 10세 미만의 영유아를 둔 30~40대 부모 세대는 가족과의 **추억을 기록하는 데 높은 관심**을 가지며 실제로 가족 관련 사진을 많이 남기려는 경향이 있다. 이러한 특성을 반영하면, 이들이 서비스에 적극적으로 유입될 가능성이 높으며 이를 통해 여가錄의 초기 홍보 효과를 기대할 수 있다.

<br><br>

## ◈ 서비스 기능
<img src="https://github.com/user-attachments/assets/b541edf9-86a4-4e00-a6ca-27acfd1b6837"
     alt="서비스 개요"
     style="display: block; margin: 0 auto; width: 70%; max-width: 400px;">

<br>


### ① 회원가입
![Image](https://github.com/user-attachments/assets/fc1ed61b-7336-48ea-be6d-35570dd59758)
+ **이름, 아이디, 비밀번호, 이메일, 가족 그룹ID**를 입력하여 회원가입을 합니다. 
+ 만약 실패시 **"회원가입에 실패했습니다. 다시 시도해주세요."** 문구가 뜬다.

<br>

<details>
  <summary>회원가입 실패 메시지 보기</summary>

![register](https://github.com/user-attachments/assets/24574b0c-85e7-44f7-b4e8-7e3160c91899)

</details>

<br>

### ② 로그인

![login](https://github.com/user-attachments/assets/2350c813-4ab8-4ce4-96b3-316d836c5754)


+ **ID와 PW**를 정확하게 입력하면 로그인시 창이 **main 페이지로 넘어갑니다**.

<br>



#### ③ 메인 페이지
![Image](https://github.com/user-attachments/assets/b1d096db-ee39-41f7-8b4e-4a0ca8bf177e)



+ main 페이지에서는 **가족들이 적은 모든 게시물**과 **캘린더 형태로 일정**을 확인 가능합니다.
+ 가족 여행 기록에 적혀있는 **장소**들을 지도에서 **핀 형태로**도 확인할 수 있습니다.

<br>

#### ④ 마이페이지

![mypage](https://github.com/user-attachments/assets/13108112-2be2-4e29-9747-4eb883483a11)

+ 마이페이지에서는 **본인이 작성한 게시글, 본인 및 가족 정보**를 확인 가능합니다. .<br>
+ 내가 쓴 게시물의 제목을 누르면 **내용과 장소, 여행날짜와 사진**이 뜹니다. 

<br>

 
#### ⑤ 게시글 작성
![Post_O](https://github.com/user-attachments/assets/e2bd8f97-8008-4a89-bd32-fff601518c0d)

+ 게시글을 올리기 위해 **제목과 내용, 여행 날짜**를 작성합니다. 
+ **키워드를 입력**하면 장소를 검색할 수 있고, 장소를 선택하면 **자동적으로 위치가 선택**됩니다. 
+ **사진파일**을 선택해서 올리고 게시글을 등록합니다. 

<br>


#### ⑥ 추천 여행지(아이디어)

![recommend](https://github.com/user-attachments/assets/095a7e9a-01fe-4dd7-b72f-0367ec16722b)

+ ELK를 활용해서 DB에 저장된 포스팅 글을 분석하고 연관 단어나 추천 키워드를 제시

<br>

<hr style="border: 0.5px solid #ccc;" />



###  기술 스택 및 구조
<p>
  <img src="https://img.shields.io/badge/Java-007396?style=flat&logo=Java&logoColor=white">
  <img src="https://img.shields.io/badge/JSP-ff7800?style=flat&logo=coffeescript&logoColor=white">
  <img src="https://img.shields.io/badge/MySQL-4479A1?style=flat&logo=MySQL&logoColor=white">
  <img src="https://img.shields.io/badge/Git-F05032?style=flat&logo=Git&logoColor=white">
</p>


<br>


## ◈ Trouble Shooting
### ▸ include UTF-8 깨짐 현상 
```
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<nav class="bg-blue-500 p-4 text-white flex justify-between">
	    <a href="main.jsp" class="text-lg font-bold">여행 기록</a>
	    <ul class="flex space-x-4">
	        <li><a href="mypage.jsp" class="hover:underline">마이페이지</a></li>
	        <li><a href="post.jsp" class="hover:underline">게시글 작성</a></li>
	        <li><a href="recommend.jsp" class="hover:underline">추천 여행지</a></li>
	    </ul>
	</nav>

</body>
</html>
```


![alt text](image-2.png)


```
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
```


- pageEncoding으로 해결 불가

<br><br>






### ▸ window 객체 내 kakao 변수

![alt text](image-1.png)

- response 객체를 확인한 결과 kakao 객체는 window 객체 하위의 프로퍼티로 추가됨

<br>

### ▸ Failed to execute 'write' on 'Document'

- 비동기로 로드 (async defer) 된 카카오 API가 내부적으로 document.write()를 실행<br>
- 비동기 스크립트에서는 document.write()가 차단됨 → 크롬 최신 버전에서 오류 발생<br>
- 카카오 API가 정상적으로 로드되지 않아 window.kakao.maps가 undefined 상태로 남음<br><br><br>


✅ **async defer 제거 후 onload 이벤트로 실행**<br>

![alt text](image.png)

<br>

### ▸ Enctype = multipart 객체 전달 간 오류

![alt text](image-3.png)<br><br>


- 이전 servlet의 경우 enctype 변환을 통한 form 전달은 apache commons 관련 lib을 통해 이루어짐


- 그러나 이를 사용하자 HttpServletRequest request 객체 인식 문제가 발생


- 현재 servlet은 6 버전으로 이전 lib와 호환이 되지 않음을 짐작함

<br>

```
 File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs(); // 폴더가 없으면 생성
        }

        String imgsrc = null;
        Part filePart = request.getPart("imgsrc"); // `imgsrc` input name 가져오기
        if (filePart != null && filePart.getSize() > 0) {
            String fileName = UUID.randomUUID().toString() + "_" + filePart.getSubmittedFileName();
            imgsrc = "uploads/" + fileName; // DB에 저장할 상대 경로

            // 파일 저장
            Path filePath = Path.of(uploadPath, fileName);
            Files.copy(filePart.getInputStream(), filePath, StandardCopyOption.REPLACE_EXISTING);
        }
```

<br>

- servlet 6버전에 맞는 File 전달 방식을 사용. getPart를 통해 파일 물리 정보를 받아옴.


```
@MultipartConfig(
	    fileSizeThreshold = 1024 * 1024 * 1, // 1MB
	    maxFileSize = 1024 * 1024 * 10,      // 10MB
	    maxRequestSize = 1024 * 1024 * 15    // 15MB
	)
```
