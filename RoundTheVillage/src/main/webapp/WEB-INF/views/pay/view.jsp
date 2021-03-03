<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>예약 내역 상세</title>
<link rel="stylesheet" href="${contextPath}/resources/css/pay/pay.css">
</head>
<body>
<jsp:include page="../common/header.jsp"></jsp:include>
<div class="container">

    <!-- <h5 class="hr-sect">구매 내역</h5> -->
    <div class="row p-3 bg-light rounded mb-5">
        <div class="col-md-12 py-4">
            <div class="d-flex justify-content-between bb">
                <span>결제 번호: ${pay.payNo}</span>
                <span class=""><fmt:formatDate pattern="yyyy-MM-dd" value="${pay.payDate}"/></span>
            </div>
            <div class="d-flex justify-content-left py-4 mb-5 bb">
                <img src="${contextPath}/resources/images/lesson/${pay.fileName}" class="rounded img-responsive w-25">
                <div class="p-3">
                    <h4>${pay.lesTitle}</h4>
                    <span>${pay.craftshopName}</span> |
                    <span>${pay.lesCategory}</span>
                    
                    <div class="row pt-4 d-block">
	                    <span class="font-weight-bold col-md-6">예약 날짜</span>
	                    <span class="col-md-6"><fmt:formatDate pattern="yyyy-MM-dd HH:mm" value="${pay.resDate}"/></span>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-md-12 py-4 mb-3 bb">결제 금액 정보</div>

        <div class="col-md-12">
            <ul class="list-group list-group-flush mb-3">
                <li class="list-group-item d-flex justify-content-between lh-condensed bg-light">
                    <div>
                        <h6 class="my-0 font-weight-bold">상품 금액</h6>
                    </div>
                    <span class="font-weight-bold">${pay.lesPrice}원</span>
                </li>
                <li class="list-group-item d-flex justify-content-between lh-condensed bg-light">
                    <div class="text-around">
                        <h6 class="my-0">할인 금액</h6>
                    </div>
                    <span class="text-around">-${pay.gradeDis + pay.couponDis}원</span>
                </li>
                <li class="list-group-item d-flex justify-content-between lh-condensed bg-light">
                    <div>
                        <h6 class="my-0 text-around">회원 등급 할인</h6>
                    </div>
                    <span class="text-around">-${pay.gradeDis}원</span>
                </li>
                <li class="list-group-item d-flex justify-content-between lh-condensed bg-light bb">
                    <div>
                        <h6 class="my-0 text-around">쿠폰 할인</h6>
                    </div>
                    <span class="text-around">-${pay.couponDis}원</span>
                </li>
                <li class="list-group-item d-flex justify-content-between bg-light">
                    <span>결제 금액</span>
                    <strong>${pay.payAmt}원</strong>
                </li>
            </ul>
        </div>
    </div>

    <div class="text-right">
        <button class="btn btn-around">목록으로</button>
    </div>
</div>
<jsp:include page="../common/footer.jsp" />
</body>
</html>