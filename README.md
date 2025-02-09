# Family-Trip-Memories

<br>

## 👨‍👩‍👧‍👦 팀원 소개

|<img src="https://avatars.githubusercontent.com/u/193798531?v=4" width="150" height="150"/>|<img src="https://avatars.githubusercontent.com/u/153366521?v=4" width="150" height="150"/>|<img src="https://avatars.githubusercontent.com/u/74342019?v=4" width="150" height="150"/>|<img src="https://avatars.githubusercontent.com/u/127267532?v=4" width="150" height="150"/>|
|:-:|:-:|:-:|:-:|
|김리영 (Kim Ri-yeong)<br/>[@riyeong0916](https://github.com/riyeong0916)|Park ji hye<br/>[@parkjhhh](https://github.com/parkjhhh)|Ryan Na<br/>[@CooolRyan](https://github.com/CooolRyan)|[@HyeJinSeok](https://github.com/HyeJinSeok)|


<br>

## 🚀 프로젝트 목표


### - 기술 목표
- Servlet 및 JSP 기반의 Web Application 개발
- Session을 통한 사용자 인증 및 상태 관리
- DataBase 연동으로 동적 데이터 처리

<br>

### - 서비스 목표
- 60대 연령층을 대상으로 한 맞춤 서비스
- 수익 창출을 위한 비지니스 모델 구현

<br>

## 📆 개발 기간
- 2025.02.03 ~ 2025.02.10

<br>

## 📚 프로젝트 소개


### - 가족여행 기록 및 플랜 추천 애플리케이션

- 지도 API 기반 여행지 탐색 기능 구현
- 여행 기록 포스팅(사진 업로드 및 게시글 작성 가능)
- ElasticSearch 기반 인기 여행지 분석 및 연관 검색어 추천 시스템 구축 (아이디어)

<br>

### - 예상 타겟 고객층

- **50~60대 부모 세대** → 2030 자녀 세대를 통해 자연스럽게 유입
- **30~40대 부모 세대** → 영유아 자녀를 둔 가족 단위의 추가 유입

<br>

💡 가족 구성원 모두가 서비스를 편리하게 이용할 수 있도록 스마트폰 사용에 능숙하고, 여행을 다니는 데 제약이 적으며, 경제적 여유가 있어 평균적인 가족보다 **여행 빈도가 높은 계층**을 주요 타겟으로 설정하는 것이 적절하다고 판단했다.<br>

이러한 기준을 바탕으로, 2030 자녀 세대의 유입을 시작점으로 삼아 궁극적으로는 Family-Trip-Memories의 본래 타겟인 **은퇴 후 여유로운 삶을 즐기려는 50~60대 연령층**까지 자연스럽게 확산될 것이라는 의견을 모았다.<br>

또한 10세 미만의 영유아를 둔 30~40대 부모 세대는 가족과의 **추억을 기록하는 데 높은 관심**을 가지며 실제로 가족 관련 사진을 많이 남기려는 경향이 있다. 이러한 특성을 반영하면, 이들이 서비스에 적극적으로 유입될 가능성이 높으며 이를 통해 Family-Trip-Memories의 초기 홍보 효과를 기대할 수 있다.

<br>

### - 기술 스택 및 구조
| <span style="color:#FF5733">Back-end</span>                                                                                                   | <span style="color:#FF5733">Front-end</span>                        | <span style="color:#FF5733">Database 연동</span>                                                         |
|------------------------------------------------------------------------------------------------------------|----------------------------------|----------------------------------------------------------------------|
| ▪ 클라이언트 요청 처리 및 비즈니스 로직 수행 <br>  ▪ 데이터 처리 및 공통 유틸 제공  | ▪ UI 구현 및 데이터 바인딩 | ▪ 사용자 및 게시글 데이터 관리 <br> ▪ DBConnection 연결 관리 |
| ▪ MVC 패턴 <br> - Java Class : DB 연동 및 비즈니스 로직 <br> - View : JSP 활용 <br> - Controller : Servlet | ▪ HTML<br> ▪ JSP                      | ▪ MySQL<br> ▪ DataSource<br> ▪ DBeaver                                                    | 


<br>

## 📌 프로젝트 폴더 구조

<br>

```
📂 프로젝트 루트
├── 📂 controller
│   ├── CheckDuplicateController.class
│   ├── LoginController.class
│   ├── MainController.class
│   ├── MypageController.class
│   ├── PostController.class
│   ├── RecommendController.class
│   ├── RegisterController.class
│
├── 📂 domain
│   ├── Family.class
│   ├── Post.class
│   ├── Recommend.class
│   ├── User.class
│
├── 📂 repository
│   ├── FamilyRepository.class
│   ├── LoginRepository.class
│   ├── MainRepository.class
│   ├── MypageRepository.class
│   ├── PostRepository.class
│   ├── RecommendRepository.class
│   ├── UserRepository.class
│
├── 📂 resources
│   ├── config.properties
│
├── 📂 utils
│   ├── DBConnection.class
│   ├── SecurityUtil.class
│
├── 📂 views/jsp
│   ├── 📂 includes
│   │   ├── footer.jsp
│   │   ├── header.jsp
│   ├── login.jsp
│   ├── main.jsp
│   ├── mypage.jsp
│   ├── post.jsp
│   ├── recommend.jsp
│   ├── register.jsp
│
├── 📂 META-INF
│   ├── MANIFEST.MF
│   ├── context.xml
```

<br>

## Trouble Shooting
include UTF-8 깨짐 현상

window 객체 내 kakao 변수

현재 콘솔에서 Failed to execute 'write' on 'Document' 라는 오류가 발생하는 이유는:

비동기로 로드 (async defer) 된 카카오 API가 내부적으로 document.write()를 실행
비동기 스크립트에서는 document.write()가 차단됨 → 크롬 최신 버전에서 오류 발생
카카오 API가 정상적으로 로드되지 않아 window.kakao.maps가 undefined 상태로 남음
🔥 해결 방법
✅ 해결 방법 1: async defer 제거 후 onload 이벤트로 실행
✅ 해결 방법 2: kakao.maps.load()를 사용하여 API가 로드된 후 실행
✅ 해결 방법 3: API 호출 방식을 setTimeout에서 MutationObserver 기반으로 변경하여 불필요한 반복 제거
