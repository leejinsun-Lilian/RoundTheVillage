<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="https://cdn.rawgit.com/moonspam/NanumSquare/master/nanumsquare.css">
<title>공지사항</title>
<style>
#title {
	font-family: 'NanumSquare', sans-serif !important;
	margin-top: 50px;
}

.pagination {
	justify-content: center;
}

#searchForm {
	position: relative;
	margin-top: 20px;
}

#searchForm>* {
	top: 0;
}

.boardTitle>img {
	width: 50px;
	height: 50px;
}

.container notice-list {
	width: 1200px margin: 0 0 0;
}

#list-table {
	text-align: center;
}

.list-wrapper {
	min-height: 540px;
}

#list-table td:hover {
	cursor: pointer;
}

#searchBtn {
	color: #FFF;
	background-color: #FBBC73;
	border: 1px solid #FBBC73;
	margin-top: -5px;
}

#insertBtn {
	color: #FFF;
	background-color: #FBBC73;
	border: 1px solid #FBBC73;
}

.pagination {
	margin-top: 90px;
}

#noticeN {
	width: 200px;
}

.pagination-success {
	margin-top: 40px;
}

.page-item > a {
	color: #5B3929;
}

.page-item > a:hover {
	color: #FBBC73;
	background-color: #fff;
}

.page-item:active, .page-item:active {
    z-index: 3;
    color: #fff;
    background-color: #FBBC73;
    border-color: #FBBC73;
}

.page-item>a {
	color: black;
}

.page-item>a:hover {
	color: orange;
}
</style>

</head>
<body>
	<jsp:include page="../common/header.jsp" />

	<div class="container notice-list">
		<h3 id="title">공지사항</h3>
		<div>
			<table class="table table-hover table-striped text-center" id="list-table">
				<thead>
					<tr>
						<th id="noticeN">글번호</th>
						<th>제목</th>
						<th>작성일</th>
					</tr>
				</thead>
				<tbody>
					<c:if test="${empty nList}">
						<tr>
							<td colspan="6">존재하는 게시글이 없습니다.</td>
						</tr>
					</c:if>

					<c:if test="${!empty nList}">
						<c:forEach var="notice" items="${nList}" varStatus="vs">

							<tr>
								<td>${notice.noticeNo}</td>

								<td class="noticeTitle">${notice.noticeTitle}</td>

								<td>
									<%-- 날짜 출력 모양 지정 --%> <fmt:formatDate var="createDate" value="${notice.noticeCreateDate}" pattern="yyyy-MM-dd" /> <fmt:formatDate var="now" value="<%=new java.util.Date()%>" pattern="yyyy-MM-dd" /> <c:choose>
										<c:when test="${createDate != now}">
											${createDate }
										</c:when>
										<c:otherwise>
											<fmt:formatDate value="${notice.noticeCreateDate}" pattern="HH:mm" />
										</c:otherwise>
									</c:choose>
								</td>

							</tr>
						</c:forEach>
					</c:if>
				</tbody>
			</table>
		</div>


		<!-- 관리자일 경우에만 공지사항 글쓰기 버튼 활성화 ------------------ -->
		 <c:if test="${!empty loginMember && loginMember.memberType =='A' }">
		<a class="btn btn-warning float-right" id="insertBtn" href="noticeInsert">글쓰기</a>
		</c:if>

		<!--------------------------------- pagination  ---------------------------------->

		<c:choose>
			<c:when test="${!empty param.sk && !empty param.sv}">
				<c:url var="pageUrl" value="/CScenter/noticeList" />

				<c:set var="searchStr" value="&sk=${param.sk}&sv=${param.sv}" />
			</c:when>

			<c:otherwise>
				<c:url var="pageUrl" value="/CScenter/noticeList" />
			</c:otherwise>
		</c:choose>

		<div class="padding">
		
		<!-- 검색할 경우 -->
			<c:choose>
				<%-- 검색 내용이 파라미터에 존재할 때 == 검색을 통해 만들어진 페이지인가? --%>
				<c:when test="${!empty param.sk && !empty param.sv}">
					<c:url var="pageUrl" value="searchNotice"/>
					
					<%-- 쿼리 스트링으로 사용할 내용을 변수에 저장 --%>
					<c:set var="searchStr" value="&sk=${param.sk}&sv=${param.sv}"/></c:when>
				
				<c:otherwise><c:url var="pageUrl" value="/CScenter/noticeList"/></c:otherwise>
			</c:choose>
			
			<c:set var="firstPage" value="?cp=1${searchStr}" />
			<c:set var="lastPage" value="?cp=${pInfo.maxPage}${searchStr}" />
			
			

			<fmt:parseNumber var="c1" value="${(pInfo.currentPage - 1) / 10 }" integerOnly="true" />
			<fmt:parseNumber var="prev" value="${ c1 * 10 }" integerOnly="true" />
			<c:set var="prevPage" value="?cp=${prev}${searchStr}" />


			<fmt:parseNumber var="c2" value="${(pInfo.currentPage + 9) / 10 }" integerOnly="true" />
			<fmt:parseNumber var="next" value="${ c2 * 10 + 1 }" integerOnly="true" />
			<c:set var="nextPage" value="?cp=${next}${searchStr}" />

			<div class="container d-flex justify-content-center">
				<div class="col-md-4 col-sm-6 grid-margin stretch-card">
					<nav>
						<ul class="pagination pagination-sm d-flex justify-content-center flex-wrap pagination-rounded-flat pagination-success">
							<c:if test="${pInfo.currentPage > pInfo.pageSize}">
								<!-- 첫 페이지로 이동(<<) -->
								<li class="page-item"><a class="page-link" href="${firstPage }" data-abc="true">&lt;&lt;</a></li>
								<!-- 이전 페이지로 이동 (<) -->
								<li class="page-item"><a class="page-link" href="${prevPage }" data-abc="true">&lt;</a></li>
							</c:if>

							<!-- 페이지 목록 -->
							<c:forEach var="page" begin="${pInfo.startPage}" end="${pInfo.endPage}">
								<c:choose>
									<c:when test="${pInfo.currentPage == page }">
										<li class="page-item active"><a class="page-link" data-abc="true">${page}</a></li>
									</c:when>

									<c:otherwise>
										<li class="page-item"><a class="page-link" href="?cp=${page}${searchStr}" data-abc="true">${page}</a></li>
									</c:otherwise>
								</c:choose>
							</c:forEach>

							<%-- 다음 페이지가 마지막 페이지 이하인 경우 --%>
							<c:if test="${next <= pInfo.maxPage}">
								<!-- 다음 페이지로 이동 (>) -->
								<li class="page-item"><a class="page-link" href="${nextPage }" data-abc="true">&gt;</a></li>
								<!-- 마지막 페이지로 이동(>>) -->
								<li class="page-item"><a class="page-link" href="${lastPage }" data-abc="true">&gt;&gt;</a></li>
							</c:if>
						</ul>
					</nav>

				</div>
			</div>
		</div>


			<div class="row search-area">
				<div class="col-md-12">
					<div class="search">
						<form action="search" method="GET" class="text-center" id="searchForm">
							<select name="sk" class="form-control" style="width: 100px; display: inline-block;">

								<option value="title">글 제목</option>
								<option value="content">내용</option>
							</select> 
							<input type="text" name="sv" class="form-control" style="width: 25%; display: inline-block;">
							<button class="form-control btn btn-warning" id="searchBtn" type="button" style="width: 100px; display: inline-block;">검색</button>
						</form>
					</div>
				</div>
			</div>

	</div>
	<jsp:include page="../common/footer.jsp" />

	<%-- 목록으로 버튼에 사용할 URL 저장 변수 선언 --%>
	<c:set var="returnListURL" value="${pageUrl}?cp=${pInfo.currentPage}" scope="session" />
	
	<script>
		// 게시글 상세보기 기능 (jquery를 통해 작업)
		$("#list-table td").on("click", function(){
			var noticeNo = $(this).parent().children().eq(0).text();
											
			var noticeViewURL = noticeNo;
			
			location.href = noticeViewURL;
		});
		

		
	</script>
</body>
</html>
