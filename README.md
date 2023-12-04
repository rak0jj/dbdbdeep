# DBDBdeep 스포츠 팀 매칭 서비스
<hr>

### 2023 Fall Semester DB Project 13 Team
스포츠 팀 매칭 서비스 입니닭
<br>
<br>
<br>


### 목차
1. 실행
2. 사용방법
3. 기능 설명
4. 유의사항
5. 제작환경
6. 데모동영상 Youtube Link
<br><br><br>

### 1. 실행<br>
   http://localhost:8080/<br>


### 2. 사용방법<br>
회원가입 > 로그인<br>

로그인 성공 시 메인페이지 진입됨.<br>
메인페이지에서 아래의 기능을 활용하면 됨.<br>


### 3. 기능설명
   #### (1) 강사 관련 기능<br>
   [코드1] InstructorPage.jsp<br>
   기능1. 현재 강의 중인 강사 목록과 강사가 맡은 팀의 ID를 테이블로 조회할 수 있다.<br>
   기능2. 강사를 검색하는 페이지(http://localhost:8080/InstructorSearch.jsp)로 넘어갈 수 있다.

```
SELECT i.Name AS InstructorName, t.Team_id AS TeamID\r\n
FROM instructor i, teach te, team t
WHERE i.Instructor_id = te.Tinstructor_id
AND te.Tteam_id = t.Team_id;
```
<br>

[코드2] InstructorSearch.jsp<br>
기능1. 종목과 월급을 입력하고 검색 버튼을 누르면 강사의 ID, 이름, 연락처, 월급을 테이블로 조회할 수 있다.<br>
(ex. 축구, 1400000입력)

```
SELECT instructor_id, name, phone_number, salary
FROM INSTRUCTOR
WHERE sports=? and salary=?;
```

#### (2) 로그인 관련 기능<br>
[코드1] LoginCheck.jsp<br>
기능1. 사용자의 ID에 따른 이름, 성별, 키, 연락처, 주소를 세션으로 저장해두어 다른 페이지에서도 사용할 수 있도록 한다.<br>

```
SELECT *
FROM userp
WHERE user_id = ?
	AND phone_number = ?;
```

[코드2] LoginPage.jsp<br>
기능1. 사용자가 입력한 아이디와 전화번호를 비밀번호로 받아 LoginCheck.jsp로 넘겨준다.<br>
<br>


#### (3) 메인페이지<br>
[코드1] MainPage.jsp<br>
기능1. 현재 접속 중인 사용자에게 환영 문구를 띄운다.<br>
기능2. 버튼 클릭 시, 기능과 관련된 페이지에 접근할 수 있다.<br>
<br>

#### (4) 경기 관련 기능<br>
[코드1] MatchPage.jsp<br>
기능1. 월별 경기 정보를 조회할 수 있는 페이지(http://localhost:8080/matchMonthlyInfo.html)로 넘어갈 수 있다.<br>
기능2. 지역별 경기 정보를 조회할 수 있는 페이지(http://localhost:8080/matchRegionalInfo.html)로 넘어갈 수 있다.<br>
기능3. 뒤로가기 클릭 시, 메인페이지(http://localhost:8080/MainPage.jsp)로 넘어갈 수 있다.<br>

[코드2] matchMonthlyInfo.html, matchMonthlyInfo.jsp<br>
기능1. 종목과 월을 입력하고 검색 버튼을 누르면 해당 종목과 월에 진행된 경기의 ID, 이긴 팀, 진 팀을 조회할 수 있다.<br>
(Ex. 축구, 2)

```
SELECT game_id, win_team, lose_team
FROM GAME
WHERE sports = ?
and to_date(game_date) LIKE ?;
```

[코드3] matchRegionalInfo.html, matchRegionalInfo.jsp<br>
기능1. 종목과 지역을 입력하고 검색 버튼을 누르면 해당 종목과 지역에서 진행된 경기의 ID, 이긴 팀, 진 팀을 조회할 수 있다.<br>

```
SELECT g.game_id, g.win_team, g.lose_team
FROM Game g, (SELECT
FROM Place
WHERE p.location LIKE ?
and p.sports = ?)
WHERE g.mplace_id=pl.place_id;
```
<br>


#### (5) 구장 관련 기능<br>
[코드1] PlacePage.jsp<br>
기능1. 지역을 입력하고 검색 버튼을 누르면 해당 지역의 구장ID, 지역, 진행가능한 스포츠(종목), 시간 당 비용을 조회할 수 있다.<br>

```
SELECT Place_id, Location, Sports, Price_per_time
FROM place
WHERE Location LIKE ?;
```

기능2. 지역별 구장 개수를 조회할 수 있다.<br>

```
SELECT SUBSTR(Location, 1, 2) AS ShortLocation, COUNT(*) AS StadiumCount
FROM place GROUP BY SUBSTR(Location, 1, 2);
```

기능3. 현재 접속한 사용자의 지역의 구장 ID, 지역을 조회할 수 있다.<br>

```
SELECT Place_id, Location
FROM place
WHERE Place_id IN ( SELECT Mplace_id
FROM game
WHERE Mplace_id IN ( SELECT Place_id
FROM place
WHERE Location LIKE ? ) );
```
<br>

#### (6) 심판 관련 기능<br>
[코드1] RefereePage.jsp<br>
기능1. 종목과 월급을 입력하고 검색 버튼을 누르면 해당하는 심판의 심판 ID, 이름, 연락처, 종목, 월급을 조회할 수 있다.<br>

```
(SELECT referee_id, name, phone_number, sports, salary
FROM REFEREE
WHERE sports=?)
INTERSECT
(SELECT referee_id, name, phone_number, sports, salary\
FROM REFEREE
WHERE salary=?)
```
<br>

#### (7) 회원 가입<br>
[코드1] SignupCheck.jsp<br>
기능1. SignupPage.jsp에서 받은 사용자의 ID가 올바른지 확인한다.<br>

```
SELECT *
FROM userp
WHERE user_id = ?;
```

기능2. SignupPage.jsp에서 받은 사용자의 ID, 비밀번호, 이름, 성별, 나이, 신장, 주소를 DB에 추가한다.<br>

```
INSERT INTO userp VALUES(?,?,?,?,?,?,?);
```

[코드2] SignupPage.jsp<br>
기능1. 사용자로부터 ID, 비밀번호, 이름, 성별, 나이, 신장, 주소를 입력받아 SignupCheck.jsp로 넘겨준다.<br>

<br>

#### (8) 팀 관련 기능<br>
[코드1] TeamPage.jsp<br>
기능1. 팀 가입 페이지(http://localhost:8080/teamInsertPage.html)로 이동할 수 있다.<br>
기능2. 소속 팀 검색 페이지로 이동할 수 있다.<br>
기능3. 소속 팀 탈퇴 페이지로 이동할 수 있다.<br>

[코드2] teamInsertPage.jsp, teamInsertPage.html<br>
기능1. 팀 ID를 입력하고 가입 버튼을 클릭하면 존재하는 팀 ID인지 확인한다.<br>
기능2. 존재하는 팀인 경우 가입한다.<br>

```
select *
from team
where team_id = ?;
```

```
FROM UserP U, team T, participate P
WHERE P.puser_id =?
AND P.pteam_id = ?;
```

```
INSERT INTO participate VALUES(?,?);
```
<br>

#### (9) 사용자 관련 기능<br>
[코드1] UserInfoChangePage.jsp<br>
기능1. 주소를 변경할 수 있는 페이지(http://localhost:8080/UserAddressChangePage.jsp)로 이동할 수 있다.<br>
기능2. 연락처를 변경할 수 있는 페이지(http://localhost:8080/UserPhoneNumChangePage.jsp)로 이동할 수 있다.<br>

[코드1] UserAddressChangePage.jsp<br>
기능1. 새 주소를 입력하고 입력 버튼을 누르면 주소가 변경된다.<br>

```
UPDATE userp
SET address = ?
WHERE user_id = ?;
```

[코드2] UserPhoneNumChangePage.jsp, UserPhoneNumChangePage.html<br>
기능1. 새 연락처를 입력하고 입력 버튼을 누르면 연락처가 변경된다.<br>

```
UPDATE userp
SET phone_number = ?
WHERE user_id = ?;
```
<br>

#### (10) 다른 사용자 검색 관련 기능<br>
[코드1] UserPage.jsp<br>
기능1. 사용자 이름을 입력하면 해당 사용자의 ID, 성별, 나이, 신장, 연락처를 조회할 수 있다.<br>

```
  SELECT user_id, sex, age, height, phone_number
  FROM UserP
  WHERE name = ?
```


### 4. 유의 사항
   (1) mac의 경우 DB 연결 시 세션을 xe로 변경해야함

(2) git commit message
>Feat : 새로운 기능 추가, 기존의 기능을 요구 사항에 맞추어 수정  
Fix : 기능에 대한 버그 수정  
Build : 빌드 관련 수정  
Chore : 패키지 매니저 수정, 그 외 기타 수정 ex) .gitignore  
Docs : 문서(주석) 수정  
Refactor : 기능의 변화가 아닌 코드 리팩터링 ex) 변수 이름 변경  
Test : 테스트 코드 추가/수정


### 5. 제작 환경
#### (1) macOS Sonoma 14.1
- Oracle OpenJDK 11.0.20
- tomcat 10.1.16
- IntelliJ 17.0.8.1+7-b1000.32 aarch6
- JAVA 11 (Module SDK Project SDK 11)

#### (2) windows 11



### 6. 데모동영상 : https://youtu.be/hHc_LGLFYvg

