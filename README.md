# FamilyMemories


## 서비스 고객층 예상 변화

### 1. 20~30대 자식들을 통해 홍보 및 유입 시도. 50~60대 부모 세대의 서비스 참여


가족 구성원 모두 온전히 서비스를 사용하기 위한 조건으로

* 스마트폰 사용에 능통할 것
* 가족 여행을 다니는데 제약이 적을 것
* 경제적인 여유가 생김에 따라 가족 여행의 빈도가 평균 가족 세대원 이상일 것<br><br>

**자녀 세대의 유입을 시작으로 처음 타겟팅 했던 은퇴 후 삶을 즐기려는 50~60대 층을 자연스럽게 유도할 수 있을 것이라 생각**<br><br>


### 2. 영유아 자식을 보유한 30~40대 부모 세대의 추가 유입


* 실제 가족 관련 사진을 많이 남기고 싶어하는 대상 가족은 10세 미만의 영유아를 보유한 30대 부모층
* 서비스 유입이 시작되게 되면 자연스러운 홍보 
* 어린 시절을 기록하기 위한 용도로 사용하기 위해 서비스 유입


### 3. 추가적인 가족 단위의 유입을 통한 서비스 개선 및 통합 가족 서비스로 진화





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

