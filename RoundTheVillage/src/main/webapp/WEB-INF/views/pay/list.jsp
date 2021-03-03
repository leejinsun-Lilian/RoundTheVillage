<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>예약 내역</title>
<link rel="stylesheet" href="${contextPath}/resources/css/pay/pay.css">
</head>
<body>
<jsp:include page="../common/header.jsp"></jsp:include>
<div class="container">

    <!-- <h5 class="hr-sect">구매 내역</h5> -->
    <div class="row p-3 bg-light rounded mb-5">
		    <c:forEach var="pay" items="${pList}">
	        <div class="col-md-12">
	            <div class="d-flex justify-content-between bb">
	                <span class=""><fmt:formatDate pattern="yyyy-MM-dd" value="${pay.payDate}"/></span>
	                <a href="view/${pay.payNo}" class="ahover">내역 상세 보기 ></a>
	            </div>
	            <div class="d-flex justify-content-left py-4 mb-5 bb">
	                <img src="${contextPath}/resources/images/lesson/${pay.fileName}" class="rounded img-responsive w-25">
	                <div class="p-3">
	                    <h4 class="">${pay.lesTitle}</h4>
	                    <span class="">${pay.craftshopName}</span> |
	                    <span class="">${pay.lesCategory}</span>
	                    
	                    <div class="row pt-4 d-block">
		                    <span class="font-weight-bold col-md-6">예약 날짜</span>
		                    <span class="col-md-6"><fmt:formatDate pattern="yyyy-MM-dd HH:mm" value="${pay.resDate}"/></span>
                    </div>
	                </div>
	            </div>
	        </div>
		    </c:forEach>
    </div>

    <nav aria-label="Page navigation example">
        <ul class="pagination justify-content-center">
            <li class="page-item disabled">
                <a class="page-link" href="#" tabindex="-1" aria-disabled="true">&lt;&lt;</a>
            </li>
            <li class="page-item disabled">
                <a class="page-link" href="#" tabindex="-1" aria-disabled="true">&lt;</a>
            </li>
            <li class="page-item disabled"><a class="page-link" href="#">1</a></li>
            <li class="page-item"><a class="page-link" href="#">2</a></li>
            <li class="page-item"><a class="page-link" href="#">3</a></li>
            <li class="page-item"><a class="page-link" href="#">4</a></li>
            <li class="page-item"><a class="page-link" href="#">5</a></li>
            <li class="page-item">
                <a class="page-link" href="#">&gt;</a>
            </li>
            <li class="page-item">
                <a class="page-link" href="#">&gt;&gt;</a>
            </li>
        </ul>
    </nav>

    <div class="text-right">
        <button class="btn btn-around">등록</button>
        <button class="btn btn-around-2">취소</button>
        <button class="btn btn-around-2">목록으로</button>
    </div>
</div>
<jsp:include page="../common/footer.jsp" />
</body>
</html>