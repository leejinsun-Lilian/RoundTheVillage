<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
}

#searchForm>* {
	top: 0;
}

.boardTitle>img {
	width: 50px;
	height: 50px;
}

.container notice-list {
	width: 1200px
	margin: 0 0 0;
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
	border : 1px solid #FBBC73;
	margin-top: -5px;
}

#insertBtn {
  color: #FFF;
	background-color: #FBBC73;
	border : 1px solid #FBBC73;
}

.pagination {
	margin-top: 90px;
}
</style>

</head>
<body>
	<jsp:include page="../common/header.jsp"/>

	<div class="container notice-list">
		<h3 id="title">공지사항 </h3>
		<div>
			<table class="table table-hover table-striped text-center" id="list-table">
				<thead>
					<tr>
						<th>글번호</th>
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
									<%-- 날짜 출력 모양 지정 --%>
									<fmt:formatDate var="createDate" value="${notice.noticeCreateDate}" pattern="yyyy-MM-dd"/>
									<fmt:formatDate var="now" value="<%=new java.util.Date()%>" pattern="yyyy-MM-dd"/> 
									<c:choose>
										<c:when test="${createDate != now}">
											${createDate }
										</c:when>
										<c:otherwise>
											<fmt:formatDate value="${notice.noticeCreateDate}" pattern="HH:mm"/>
										</c:otherwise>
									</c:choose>
								</td>

							</tr>
						</c:forEach>
					</c:if>
				</tbody>
			</table>
		</div>


		<%-- 로그인이 되어있는 경우 --%> <!-- 관리자일 경우에만 공지사항 글쓰기 버튼 활성화 ------------------ -->
		<%-- <c:if test="${!empty loginMember && loginMember.memberType =='A' }">--%>
			<a class="btn btn-warning float-right" id="insertBtn" href="noticeInsert">글쓰기</a>
		<%-- </c:if> --%>

		<!--------------------------------- pagination  ---------------------------------->

		<div class="my-4">
			<ul class="pagination pagination-sm justify-content-center">
	
				<%-- 주소 조합 작업 --%>
				<c:url var="pageUrl" value="${pInfo}?"/>

				<!-- 화살표에 들어갈 주소를 변수로 생성 -->
				<c:set var="firstPage" value="${pageUrl}cp=1"/>
				<c:set var="lastPage" value="${pageUrl}cp=${pInfo.maxPage}"/>
				
				
				<fmt:parseNumber var="c1" value="${(pInfo.currentPage - 1) / 10 }"  integerOnly="true" />
				<fmt:parseNumber var="prev" value="${ c1 * 10 }"  integerOnly="true" />
				<c:set var="prevPage" value="${pageUrl}cp=${prev}" />
				
				<fmt:parseNumber var="c2" value="${(pInfo.currentPage + 9) / 10 }" integerOnly="true" />
				<fmt:parseNumber var="next" value="${ c2 * 10 + 1 }" integerOnly="true" />
				<c:set var="nextPage" value="${pageUrl}cp=${next}" />
				


				<c:if test="${pInfo.currentPage > pInfo.pageSize}">
					<li> <!-- 첫 페이지로 이동(<<) -->
						<a class="page-link" href="${firstPage}">&lt;&lt;</a>
					</li>
					
					<li> <!-- 이전 페이지로 이동 (<) -->
						<a class="page-link" href="${prevPage}">&lt;</a>
					</li>
				</c:if>



				<!-- 페이지 목록 -->
				<c:forEach var="page" begin="${pInfo.startPage}" end="${pInfo.endPage}" >
					<c:choose>
						<c:when test="${pInfo.currentPage == page }">
							<li>
								<a class="page-link">${page}</a>
							</li>
						</c:when>
					
						<c:otherwise>
							<li>	
								<a class="page-link" href="${pageUrl}cp=${page}">${page}</a>
							</li>
						</c:otherwise>
					</c:choose>
				</c:forEach>
					
		
				<%-- 다음 페이지가 마지막 페이지 이하인 경우 --%>
				<c:if test="${next <= pInfo.maxPage}">
					<li> <!-- 다음 페이지로 이동 (>) -->
						<a class="page-link" href="${nextPage}">&gt;</a>
					</li>
					
					<li> <!-- 마지막 페이지로 이동(>>) -->
						<a class="page-link" href="${lastPage}">&gt;&gt;</a>
					</li>
				</c:if>
			</ul>
		</div>

	
	<div>
			<div class="text-center" id="searchForm" style="margin-bottom: 100px;">
				<select name="sk" class="form-control" style="width: 100px; display: inline-block;">
					<option value="tit">글제목</option>
					<option value="con">내용</option>
					<option value="titcont">제목+내용</option>
				</select> 
				<input type="text" name="sv" class="form-control" style="width: 25%; display: inline-block;">
				<button class="form-control btn btn-warning" id="searchBtn" type="button" style="width: 100px; display: inline-block;">검색</button>
			</div>
		</div>
	
	
	</div>
	<jsp:include page="../common/footer.jsp" />
	
	<%-- 목록으로 버튼에 사용할 URL 저장 변수 선언 --%>
	<c:set var="returnListURL" value="${contextPath}/CScenter/noticeList/${pageUrl}cp=${pInfo.currentPage}" scope="session" />
																
	<script>
		// 게시글 상세보기 기능 (jquery를 통해 작업)
		$("#list-table td").on("click", function(){
			var noticeNo = $(this).parent().children().eq(0).text();
											//td    tr        td      첫 번째(게시글 번호)
											
			var noticeViewURL = noticeNo;
			
			location.href = noticeViewURL;
		});
		
	</script>
</body>
</html>
