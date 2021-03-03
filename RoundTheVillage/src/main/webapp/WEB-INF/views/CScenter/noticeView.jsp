<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항</title>
<style>
	#board-area{ margin-bottom:100px;}
	#board-content{ padding-bottom:150px;}
	#date-area{font-size: 12px; line-height: 12px}
	#date-area>p{margin: 0}
 

	.boardImgArea{
		height: 300px;
	}

	.boardImg{
		width : 100%;
		height: 100%;
		
		max-width : 300px;
		max-height: 300px;
		
		margin : auto;
	}
	
	.carousel-control-prev-icon {
 		background-image: url("data:image/svg+xml;charset=utf8,%3Csvg xmlns='http://www.w3.org/2000/svg' fill='%23000' viewBox='0 0 8 8'%3E%3Cpath d='M5.25 0l-4 4 4 4 1.5-1.5-2.5-2.5 2.5-2.5-1.5-1.5z'/%3E%3C/svg%3E") !important;
	}
	
	.carousel-control-next-icon {
  		background-image: url("data:image/svg+xml;charset=utf8,%3Csvg xmlns='http://www.w3.org/2000/svg' fill='%23000' viewBox='0 0 8 8'%3E%3Cpath d='M2.75 0l-1.5 1.5 2.5 2.5-2.5 2.5 1.5 1.5 4-4-4-4z'/%3E%3C/svg%3E") !important;
	}
	
	.nline {
		width: 1140px;
	}
	
	#content-main {
		margin:30px;
		margin-top : 50px;
		padding:0px;
	}
	
	#date-area {
		display: inline-block;
		margin:0px;
		margin-left: 840px;
	}
	
	#back, #updateBtn, #deleteBtn {
	color: #FFF;
	background-color: #FBBC73;
	border : 1px solid #FBBC73;
	}
	
</style>
</head>
<body>
	<jsp:include page="../common/header.jsp"/>
	<div class="container" id="content-main">

		<div id="allBoard">
			<div id="board-area">

				
				<!-- Title -->
				<h3 class="mt-4">${notice.noticeTitle}</h3>
	
				<hr class="nline">

				<!-- Writer -->
				<div class="lead">
					작성자 : 관리자
					<div id="date-area">
						<p>작성일 : ${notice.noticeCreateDate}</p>
					</div>
					
				</div>

				<hr class="nline">

				
				<!-- 이미지 부분 -->
                <c:if test="${!empty attachmentList}">
                
					<div class="carousel slide m-3" id="carousel-325626">
	                    
	                    <div class="carousel-inner boardImgArea">
	                    
		                    <c:forEach var="at" items="${attachmentList}" varStatus="vs">
	                    		<c:set var="src" value="${contextPath}${at.filePath}/${at.fileName}"/> <!-- "/"가 부족해서 추가 -->
	                    		
		                        <div class="carousel-item <c:if test="${vs.index == 0}"> active</c:if>">
		                            <img class="d-block w-100 boardImg" src="${src}" />
		                            <input type="hidden" value="${at.fileNo}">
		                        </div>
	                        </c:forEach>
	                        
	                    </div> 
	                    
	                    <a class="carousel-control-prev" href="#carousel-325626" data-slide="prev"><span class="carousel-control-prev-icon"></span> <span class="sr-only">Previous</span></a> <a class="carousel-control-next" href="#carousel-325626" data-slide="next">
	                    <span class="carousel-control-next-icon"></span> 
	                    <span class="sr-only">Next</span></a>
	                </div>
                </c:if>
				

				<!-- Content -->
				<div id="board-content">
				
				<%-- JSTL을 이용한 개행문자 처리 --%>
				<% pageContext.setAttribute("newLine", "\n"); %>
				${fn:replace(notice.noticeContent, newLine, "<br>")}
				<%-- ${fn:replace(board.boardContent, "\n", "<br>")}  EL은 이스케이프 문자를 인식하지 못한다. --%>
				
				</div>

				
				<div>
					<div class="float-right">
					
						<%-- 북마크나 주소로 인한 직접 접근 시 목록으로 버튼 경로 지정 --%>
						<c:if test="${empty sessionScope.returnListURL}">
							<c:set var="returnListURL" value="../list/${notice}" scope="session"/>
						</c:if>
						<a class="btn btn-warning" id="back" href="${sessionScope.returnListURL}">목록으로</a>
	                	
	                	<c:url var="updateUrl" value="${notice.noticeNo}/update" />
	                	
	                	<!-- 로그인된 회원이 글 작성자인 경우 -->
					<%-- 	<c:if test="${(loginMember != null) && (member.memberType == 'A')}"> --%>
							<a href="${updateUrl}" class="btn btn-warning ml-1 mr-1" id="updateBtn">수정</a>
							<button id="deleteBtn" class="btn btn-warning">삭제</button> 
					<%-- 	</c:if>--%>
					</div>
				</div>
			</div>


			
		</div>
	</div>
	<jsp:include page="../common/footer.jsp"/>
	
	<script>	
	
		// 게시글 삭제
		
		
	</script>
</body>
</html>
