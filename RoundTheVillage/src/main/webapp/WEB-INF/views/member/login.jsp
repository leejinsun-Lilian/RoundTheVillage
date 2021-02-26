<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
        <!-- 스타일 링크 -->
        <link rel="stylesheet" href="${contextPath}/resources/css/member/login.css" type="text/css">
        <!-- 부트스트랩 사용을 위한 css 추가 -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css"
            integrity="sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2" crossorigin="anonymous">
        <link rel="stylesheet" type="text/css" href="https://cdn.rawgit.com/moonspam/NanumSquare/master/nanumsquare.css">
        <!-- 부트스트랩 사용을 위한 라이브러리 추가 (반드시 jQuery가 항상 먼저여야한다. 순서 중요!) -->
        <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-ho+j7jyWK8fNQe+A12Hb8AhRq26LrZ/JpcUGGOn+Y7RsweNrtN/tE3MoK7ZeZDyx"
            crossorigin="anonymous"></script>
    </head>
<body>
    <div class="container">

        <div class="loginUp">

            <!-- 아이디 입력 -->
            <label class="title">아이디</label><br>
            <input type="text" name="id" id="id" class="text-input">
            
            <!-- 비밀번호 -->
            <label class="title">비밀번호</label><br>
            <input type="text" name="pwd" id="pwd" class="text-input">
            
            <!-- 아이디 저장 -->
            <label class="id-checkbox">
                <input type="checkbox" name="saveId">
            </label>
            <label class="id-checkbox-text">아이디저장</label>

            <!-- 로그인 버튼 -->
            <div>
                <button type="submit" id="loginBtn"  class="btn" onclick="location.href='#'"   >로그인</button>
            </div>

            <!-- 아이디 -->
            <div class="idPwdSignUp">
                <span class="id-link-area">
                    <a href="#" class="search-id-pwd">아이디/비밀번호 찾기</a>
                </span>
                <span class="signUp-link-area">
                    <a href="#" class="search-id-pwd">회원가입</a>
                </span>
            </div>
            <hr>

            <!-- 카카오계정 로그인 -->
            <div>
                <img src="${contextPath}/resources/images/login/kakaoLogin.png" class="sns-btn kakaoBtn">
            </div>
                
            <!-- 네이버계정 로그인 -->
            <div>
                <img src="${contextPath}/resources/images/login/naverLogin.png" class="sns-btn">
            </div>

        </div>

    </div>
</body>
</html>