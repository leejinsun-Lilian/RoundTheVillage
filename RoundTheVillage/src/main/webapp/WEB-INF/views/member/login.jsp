<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
<!-- 스타일 링크 -->
<link rel="stylesheet" href="${contextPath}/resources/css/member/login.css" type="text/css">
<!-- 부트스트랩 사용을 위한 css 추가 -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css" integrity="sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2" crossorigin="anonymous">
<link rel="stylesheet" type="text/css" href="https://cdn.rawgit.com/moonspam/NanumSquare/master/nanumsquare.css">
<!-- 부트스트랩 사용을 위한 라이브러리 추가 (반드시 jQuery가 항상 먼저여야한다. 순서 중요!) -->
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ho+j7jyWK8fNQe+A12Hb8AhRq26LrZ/JpcUGGOn+Y7RsweNrtN/tE3MoK7ZeZDyx" crossorigin="anonymous"></script>
<!-- sweetalert : alert창을 꾸밀 수 있게 해주는 라이브러리 https://sweetalert.js.org/ -->
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>

</head>
<body>
	<c:if test="${!empty swalTitle}">
      <script>
         swal({icon  : "${swalIcon}",
              title : "${swalTitle}",
              text  : "${swalText}"});
      </script>
   </c:if>
	<div class="container">

		<div class="loginUp">

			<!-- 메인 이동 로고 -->
			<div class="login-logo-area">
				<a href="${contextPath}"><img src="${contextPath}/resources/images/logo/main_logo_zero.png" class="login-logo"></a>
			</div>

			<form action="loginAction" method="post">
				<!-- 아이디 입력 -->
				<label class="title">아이디</label><br> <input type="text" name="memberId" id="memberId" class="text-input" value="${cookie.saveId.value}" required>

				<!-- 비밀번호 -->
				<label class="title">비밀번호</label><br> <input type="password" name="memberPwd" id="memberPwd" class="text-input" required>

				<!-- 아이디 저장 -->
				<label class="id-checkbox"> <input type="checkbox" name="saveId" <c:if test="${!empty cookie.saveId.value}"> checked </c:if>>
				</label> <label class="id-checkbox-text">아이디저장</label>

				<!-- 로그인 버튼 -->
				<div>
					<button type="submit" id="loginBtn" name="loginBtn" class="loginBtn">로그인</button>
				</div>

				<!-- 아이디/비밀번호 찾기 -->
				<div class="idPwdSignUp">
					<span class="id-link-area"> <a href="${contextPath}/member/idFind" class="search-id-pwd">아이디 찾기</a> <a class="search-id-pwd">/</a> <a href="${contextPath}/member/pwdFind" class="search-id-pwd">비밀번호 찾기</a>
					</span> <span class="signUp-link-area"> <a href="${contextPath}/member/signUp" class="search-id-pwd">회원가입</a>
					</span>
				</div>
				<hr>

				<!-- 카카오계정 로그인 -->
				<div id="kakao_id_login" style="text-align: center"> 
					<a href="https://kauth.kakao.com/oauth/authorize?client_id=3c56b25609c3861587b904b7f8db4860&redirect_uri=http://localhost:8082/RoundTheVillage/kakaoLogin&response_type=code"> 
						<img class="sns-btn kakaoBtn" src="${contextPath}/resources/images/member/kakaoLogin.png" />
					</a> 
				</div>

				<!-- 네이버계정 로그인 -->
				<%-- <div>
					<img src="${contextPath}/resources/images/member/naverLogin.png" class="sns-btn">
				</div> --%>


			</form>
		</div>

	</div>
</body>
</html>