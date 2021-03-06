<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>아이디 찾기 완료</title>
<!-- 스타일 링크 -->
<link rel="stylesheet" href="${contextPath}/resources/css/member/idFindComplete.css" type="text/css">
<!-- 부트스트랩 사용을 위한 css 추가 -->
<link rel="stylesheet" type="text/css" href="https://cdn.rawgit.com/moonspam/NanumSquare/master/nanumsquare.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css" integrity="sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2" crossorigin="anonymous">
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

		<!-- 메인 이동 로고 -->
		<div class="login-logo-area">
				<a href="${contextPath}"><img src="${contextPath}/resources/images/logo/main_logo_zero.png" class="login-logo"></a>
		</div>

		<!-- 아이디찾기, 비밀번호 찾기 -->
    <div class="s_radio">
       <span class="f">
           <label class="box-radio-input">
               <input type="radio" name="cp_item" checked="checked" onclick="location.href='${contextPath}/member/idFind'"  ><span>아이디 찾기</span>
           </label>
       </span>

       <span class="s">
           <label class="box-radio-input">
               <input type="radio" name="cp_item" onclick="location.href='${contextPath}/member/pwdFind'" ><span>비밀번호 찾기</span>
           </label>
       </span>
   </div>
   <hr>
   
   <!-- 아이디 출력부분 -->
   <div class="output-area">
			<div style="font-size: 22px;">회원님의 ID는 <strong>${memberIdFind}</strong>입니다.</div>
   </div>
   	
   	<!-- 로그인 , 홈으로  -->
   	<!-- 완료 버튼 -->
    <div id="c-btn">
        <button id="btn-mm" type="button" name="login-mm" id="login-mm"  onclick="location.href='${contextPath}/member/login'">로그인</button>
        <button id="btn-mm" type="button" name="home-mm" id="home-mm"  onclick="location.href='${contextPath}'">홈으로</button>
    </div>
				












	</div>







</body>
</html>