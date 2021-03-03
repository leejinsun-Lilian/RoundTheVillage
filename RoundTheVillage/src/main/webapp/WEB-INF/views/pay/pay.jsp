<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>수업 결제</title>
<link rel="stylesheet" href="${contextPath}/resources/css/pay/pay.css">
</head>
<body>
<jsp:include page="../common/header.jsp"/>
<div class="container">

    <!-- <h5 class="hr-sect mb-4">수업 결제</h5> -->
    <div class="row p-3">
	    <div class="bb row">
	        <div class="col-md-6">
	            <img src="${contextPath}/resources/images/lesson/${lesson.fileName}" class="rounded float-left mb-4 w-100" id="classImg">
	        </div>
	        <div class="col-md-6 d-flex flex-column position-static">
	            <h3 class="mb-2 font-weight-bold" id="lseTitle">${lesson.lesTitle}</h3>
	            <div class="mb-4">${lesson.craftshopName}</div>
	
	            <div class="row">
	                <div class="col-md-4">
	                    <h6 class="font-weight-bold">예약 날짜</h6>
	                </div>
	                <span class="col-md-8 font-weight-bold">2021년 2월 18일 오후 2시</span>
	            </div>
	        </div>
	    </div>

			<div class="col-md-12 mt-4">
			    <ul class="list-group list-group-flush mb-3">
			        <li class="list-group-item d-flex justify-content-between lh-condensed">
			            <div>
			                <h6 class="my-0 font-weight-bold">상품 금액</h6>
			            </div>
			            <span>${lesson.lesPrice}원</span>
			        </li>
			        <li class="list-group-item d-flex justify-content-between bg-light">
			            <div class="text-around">
			                <h6 class="my-0">할인 금액</h6>
			            </div>
			            <span class="text-around" id="totalDis">- 0원</span>
			        </li>
			        <li class="list-group-item d-flex justify-content-between lh-condensed">
			            <div>
			                <h6 class="my-0 text-around">회원 등급 할인</h6>
			            </div>
			            <span class="text-around" id="gradeDis">- 0원</span>
			        </li>
			        <li class="list-group-item d-flex justify-content-between lh-condensed bb">
			            <div>
			                <h6 class="my-0 text-around">쿠폰 할인</h6>
			            </div>
			            <span class="text-around" id="couponDis">- 0원</span>
			        </li>
			        <li class="list-group-item d-flex justify-content-between">
			            <strong>결제 금액</strong>
			            <strong id="totalPrice"></strong>
			        </li>
			    </ul>
			
			    <div class="px-4 py-5 bb">
			        <h6 class="mb-3 font-weight-bold">쿠폰 선택</h6>
			        <select class="col-md-12 custom-select" id="coupon">
			            <option class="couponCnt"></option>
			            
			            <c:forEach var="coupon" items="${cList}">
								    	<option value="${coupon.discount}" id="${coupon.couponNo}">${coupon.couponName}</option>
									</c:forEach>
			        </select>
			    </div>
			</div>
    </div>

    <!-- <div class="mx-auto d-block rounded p-5 bg-light" style="width: 95%;">
        <p>전자금융거래 기본약관</p>

        <p>제1조 (목적)</p>

        <p>이 약관은 주식회사 진선지니어스 (이하 '회사'라 합니다)가 제공하는 전자 지급 결제 대행 서비스 및 결제대금예치서비스를 이용자가 이용함에 있어 회사와 이용자 사이의 전자 금융 거래에 관한
            기본적인 사항을 정함을 목적으로 합니다.</p>

        <p>제2조 (용어의 정의)</p>

        <p>이 약관에서 정하는 용어의 정의는 다음과 같습니다.</p>

        <p>1. '전자 금융 거래'라 함은 회사가 전자적 장치를 통하여 전자 지급 결제 대행 서비스 및 결제 대금 예치 서비스(이하 '전자 금융 거래 서비스'라고 합니다)를 제공하고, 이용자가 회사의
            종사자와 직접 대면하거나 의사소통을 하지 아니하고 자동화된 방식으로 이를 이용하는 거래를 말합니다.</p>

        <p>2. '전자 지급 결제 대행 서비스'라 함은 전자적 방법으로 재화의 구입 또는 용역의 이용에 있어서 지급결제정보를 송신하거나 수신하는 것 또는 그 대가의 정산을 대행하거나 매개하는 서비스를
            말합니다.</p>

        <p>3. '결제 대금 예치 서비스'라 함은 이용자가 재화의 구입 또는 용역의 이용에 있어서 그 대가(이하 '결제 대금이라 한다)의 전부 또는 일부를 재화 또는 용역(이하 '재화 등이라
            합니다)을
            공급받기 전에 미리 지급하는 경우,
            회사가 이용자의 물품 수령 또는 서비스 이용 확인 시점까지 결제 대금을 예치하는 서비스를 말합니다.</p>

        <p> 4. '이용자'라 함은 이 약관에 동의하고 회사가 제공하는 전자 금융 거래 서비스를 이용하는 자를 말합니다.
    </div>

    <div class="mx-auto d-block p-4 checks bb">
        <input type="checkbox" id="check">
        <label for="check"> 위 상품의 구매조건 확인 및 결제진행 동의</label>
    </div> -->
    
    <div class="myinfobox p-5">
        <h6 class="font-weight-bold mb-4">주문고객 정보</h6>
        <div class="form-group row">
            <label for="name" class="col-md-3 col-form-label">이름</label>
            <div class="col-md-9">
                <input type="text" class="form-control" id="name" value="">
            </div>
        </div>
        <div class="form-group row">
            <label for="phone1" class="col-md-3 col-form-label">전화번호</label>
            <div class="col-md-3">
                <select class="custom-select" id="phone1" name="phone1" required>
                    <option>010</option>
                    <option>011</option>
                    <option>016</option>
                    <option>017</option>
                    <option>019</option>
                </select>
            </div>
            <div class="col-md-3">
                <input type="number" class="form-control phone" id="phone2" maxlength="4" name="phone2" required>
            </div>
            <div class="col-md-3">
                <input type="number" class="form-control phone" id="phone3" maxlength="4" name="phone3" required>
            </div>
        </div>

        <div class="form-group row">
            <label for="name" class="col-md-3 col-form-label">Email</label>
            <div class="col-md-9">
                <input type="email" class="form-control" id="email" value="">
            </div>
        </div>
    </div>

    <div class="text-center p-5">
        <button class="btn btn-around" onclick="requestPay()">결제하기</button>
        <button class="btn btn-around-2">취소</button>
    </div>
</div>
<jsp:include page="../common/footer.jsp" />

<script>
    var price = "${lesson.lesPrice}";
    var grade = 1;
    var coupon = 0;
    var couponCnt = "${cList.size()}";
    var couponDis = 0;

    var gradeDis = Math.floor(price * (grade * 0.05));
    $("#gradeDis").text("- " + gradeDis + "원");
    
    if (couponCnt < 1)
        $(".couponCnt").text("적용 가능한 쿠폰이 없습니다.");
    else
        $(".couponCnt").text("적용 가능 쿠폰 (" + couponCnt + "개)");

    $("#coupon").change(function () {
        if ($(this).val() < 1)
            couponDis = Math.floor(price * $(this).val());
        else if ($(this).val() > 1)
            couponDis = Math.floor($(this).val());
        else
            couponDis = 0;

        $("#couponDis").text("- " + couponDis + "원");
        $("#totalDis").text("- " + (gradeDis + Number(couponDis)) + "원");
        $("#totalPrice").text(price - gradeDis - couponDis + "원");
    });

    $("#totalDis").text("- " + (gradeDis + Number(couponDis)) + "원");
    $("#totalPrice").text((price - gradeDis) + "원");
    
    // 전화번호
    $(".phone").on("input", function() {
			if ($(this).val().length > $(this).prop("maxLength")) 
				$(this).val($(this).val().slice(0, $(this).prop("maxLength")));
		});
</script>

<!-- iamport.payment.js -->
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<script>
	var amt = Number($("#totalPrice").text().slice(0, -1));
	var phone = $("#phone1").val() + "-" + $("#phone2").val() + "-" + $("#phone3").val();
	
	IMP.init("imp47764579");
	
  function requestPay() {
      // IMP.request_pay(param, callback) 호출
       IMP.request_pay({ // param
          pg: "html5_inicis",
          pay_method: "card",
          name: $("#lseTitle").text(),
          amount: 100,
          buyer_email: $("#email").text(),
          buyer_name: $("#name").text(),
          buyer_tel: phone,
      }, function (rsp) { // callback
          if (rsp.success) {  // 가맹점 서버 결제 API 성공시 로직
	          jQuery.ajax({
	              url: "${contextPath}/pay/payAction", // 가맹점 서버
	              method: "POST",
	              data: {
	            	  dateStr: "2021-03-21 10:53:00",
	            	  //dateStr: "2021-03-21 10:53:00",
	            		payAmt: rsp.paid_amount,
	            		gradeDis: $("#gradeDis").text().slice(1, -1),
	            		couponDis: $("#couponDis").text().slice(1, -1),
	            		impUid: rsp.imp_uid,
	            		couponNo: $("#coupon option:selected").attr("id"),
	            		lesNo: ${lesson.lesNo}
	              }
	          }) .done(function (data) {
	        		  console.log(data > 0)
	        	  if(data > 0){
	        		  console.log("go")

        		    var form = $("<form>");
        		    form.attr("method", "post");
        		    form.attr("action", "complete");
								
        		    var impUid = $("<input>").attr("type", "hidden").attr("name", "impUid").val(rsp.imp_uid);
        		    form.append(impUid);
        		    $(document.body).append(form);
        		    
        		    form.submit();
		        	  //location.href = "complete/" + rsp.imp_uid;
	        	  }
	        	  else 
	        		  alert("결제에 실패하였습니다.");
	          })
          } else {
        	  alert("결제에 실패하였습니다. 에러 내용: " +  rsp.error_msg);
          }
      }); 
    }
</script>
</body>
</html>