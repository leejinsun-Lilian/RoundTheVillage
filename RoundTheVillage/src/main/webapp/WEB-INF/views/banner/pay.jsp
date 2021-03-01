<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>배너 결제</title>
<link rel="stylesheet" href="${contextPath}/resources/css/pay/pay.css">
</head>
<body>
<jsp:include page="../common/header.jsp"></jsp:include>
<div class="container">

    <!-- <h5 class="hr-sect">배너 결제</h5> -->
    <div class="row bg-light rounded">
        <form class=" col-md-12" onsubmit="return vaildation()">
            <div class="form-group">
                <label for="URL" class="font-weight-bold py-3">링크 URL</label>
                <input type="text" class="form-control" id="URL" name="URL">
            </div>
            <div class="form-group">
                <label for="banImg" class="font-weight-bold">배너 이미지</label>
                <input type="file" class="form-control-file" id="banImg" name="banImg" onchange="LoadImg(this)" required>
                <div class="py-3 imgPrivew"></div>
            </div>

            <div class="mb-4">
                <strong>배너 광고 시작일 선택</strong>
            </div>
            <table id="calendar">
                <tr>
                    <th onclick="beforem()" id="before">&lt;</th>
                    <th colspan="5" id="yearmonth" class="p-3"></th>
                    <th onclick="nextm()" id="next">&gt;</th>
                </tr>
                <tr>
                    <th style="color:#dc3545">SUN</th>
                    <th>MON</th>
                    <th>TUE</th>
                    <th>WED</th>
                    <th>THU</th>
                    <th>FRI</th>
                    <th style="color:#007bff">SAT</th>
                </tr>
            </table>

            <div class="text-muted text-right small" style="width: 320px;">배너는 선택한 날짜부터 10일동안 등록됩니다.</div>
            <div class="text-right p-2" style="width: 320px;">
                <span class="color today mr-2">오늘</span>
                <span class="color select">선택</span>
            </div>

            <div class="row py-4">
                <strong class="col-md-3">기간</strong>
                <input type="text" class="form-control-plaintext col-md-9 pl-3" id="term" name="term" readonly>
            </div>
            <div class="row">
                <strong class="col-md-3">결제 금액</strong>
                <input type="text" readonly class="form-control-plaintext col-md-9 pl-3" name="price"
                    value="100,000 원">
            </div>

            <div class="text-center p-5">
                <button type="submit" class="btn btn-around">결제하기</button>
                <a href="#" class="btn btn-around-2">취소</a>
            </div>
        </form>
    </div>
</div>
<jsp:include page="../common/footer.jsp" />

<!-- Modal -->
<div class="modal fade" id="myModal" role="dialog">
    <div class="modal-dialog">

        <!-- Modal content-->
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title">Modal Methods</h4>
            </div>
            <div class="modal-body">
                <p>시작 날짜를 선택해주세요.</p>
            </div>
        </div>

    </div>
</div>
<script>
    function vaildation() {
        if ($("#term").val() == "") {
            // swal({ icon: "info", title: "시작 날짜를 선택해주세요" });
            $("#myModal").modal("show");
            return false;
        }
    }

    function LoadImg(value) {
        if (value.files && value.files[0]) {
            var reader = new FileReader();
            reader.readAsDataURL(value.files[0]);

            reader.onload = function (e) {
                var img = $("<img>").attr("src", e.target.result).addClass("col-md-10");
                $(".imgPrivew").append(img);
            }
        }
    }

    // 달력
    var today = new Date(); // 오늘 날짜
    var date = new Date();
    var startDate;
    build();

    function beforem() { // 이전 달을 today에 값을 저장
        today = new Date(today.getFullYear(), today.getMonth() - 1, today.getDate());

        if (today.getFullYear() > date.getFullYear() || today.getMonth() >= date.getMonth())
            build();
        else
            today = new Date(today.getFullYear(), today.getMonth() + 1, today.getDate());
    }

    function nextm() { // 다음 달을 today에 저장
        today = new Date(today.getFullYear(), today.getMonth() + 1, today.getDate());
        build();
    }

    function build() {
        var nMonth = new Date(today.getFullYear(), today.getMonth(), 1); // 현재달의 첫째 날
        var lastDate = new Date(today.getFullYear(), today.getMonth() + 1, 0); // 현재 달의 마지막 날
        var tbcal = document.getElementById("calendar"); // 테이블 달력을 만들 테이블
        var yearmonth = document.getElementById("yearmonth"); // 년도와 월 출력할곳
        yearmonth.innerHTML = today.getFullYear() + "." + (today.getMonth() + 1); // 년도와 월 출력

        // 남은 테이블 줄 삭제
        while (tbcal.rows.length > 2) {
            tbcal.deleteRow(tbcal.rows.length - 1);
        }
        var row = null;
        row = tbcal.insertRow();
        var cnt = 0;

        // 1일 시작칸 찾기
        for (var i = 0; i < nMonth.getDay(); i++) {
            cell = row.insertCell();
            cnt++;
        }

        // 달력 출력
        for (var i = 1; i <= lastDate.getDate(); i++) { // 1일부터 마지막 일까지

            cell = row.insertCell();
            cell.innerHTML = i;
            cnt++;

            if (cnt % 7 == 1) // 일요일
                cell.innerHTML = "<font color=#dc3545>" + i;
            else if (cnt % 7 == 0) { // 토요일
                cell.innerHTML = "<font color=#007bff>" + i;
                row = calendar.insertRow(); // 줄 추가
            }


            if (today.getFullYear() == date.getFullYear() && today.getMonth() == date.getMonth() && i == date.getDate()) {
                cell.bgColor = "#FBBC73"; // 오늘
                cell.innerHTML = "<font color=#00000>" + i;
                $(cell).css("cursor", "default");
                $(cell).prop("disabled", true);
            }

            if (startDate != undefined && today.getFullYear() == startDate.getFullYear() && today.getMonth() == startDate.getMonth() && i == startDate.getDate())
                $(cell).addClass("selected");

            if (today.getFullYear() == date.getFullYear() && today.getMonth() == date.getMonth() && i < date.getDate()) {
                $(cell).css("opacity", "0.3");
                $(cell).css("cursor", "default");
                $(cell).prop("disabled", true);
            }
        }
    }

    // 날짜 선택
    $(document).on("click", "td", function (event) {
        $("td").removeClass("selected");
        $(this).addClass("selected");

        startDate = new Date(today.getFullYear(), today.getMonth(), $(this).text());
        console.log(startDate)
        var startDateStr = today.getFullYear() + "." + (today.getMonth() + 1) + "." + $(this).text();

        var endDate = new Date(today.getFullYear(), today.getMonth(), $(this).text());
        endDate.setDate(endDate.getDate() + 7)
        var endDateStr = endDate.getFullYear() + "." + (endDate.getMonth() + 1) + "." + endDate.getDate();

        $("#term").val(startDateStr + " ~ " + endDateStr);
    });
</script>
</body>
</html>