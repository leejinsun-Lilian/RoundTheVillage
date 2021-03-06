<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>lessonInsertForm</title>
<!--<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
 <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js"></script> -->
<link rel="stylesheet" href="../resources/timepicker/tempusdominus-bootstrap.css"/>
<link rel="stylesheet" href="${contextPath}/resources/timepicker/jquery.timepicker.min.css">
<link rel="stylesheet" href="${contextPath}/resources/summernote/css/summernote-lite.css">
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">

<style>
.container {
	margin-top: 30px;
}
.insert-main {
	width: 800px;
}
form {
	margin-left: 120px;
}
.insert-main > div :not{.insert-time}{
	height: 100px;
} 

.date-buttons {
}
.date-button {
	width: 90px;
	height: 52px;
	margin: 0 7px 0;
	border: 1px solid #ced4da;
	border-radius: 10px;
	background-color: #FFFFFF;
}
.time-button {
	width: 90px;
	height: 52px;
	margin: 0 7px 0;
	border: 1px solid #ced4da;
	border-radius: 10px;
	background-color: #FFFFFF;
}
.insert-title {
	height: 100px;
}
.insert-p {
	margin-bottom: 10px;
}
.insert-content {
}
.button-area button {
	width: 100px;
	height: 55px;
	margin: 0 7px 0;
	border: 1px solid #ced4da;
	border-radius: 10px;
	background-color: #FFFFFF;
}
.insert-time {
	height: auto;
	margin: 20px 0;
}
.time-area {
	margin: 15px 0;
}
.timepicker {
	margin: 15px 0;
}
body {
	width: 100%;
}
#calendar {
	width: 18px;
	height: 18px; 
}
.button-category {
	background-color: #F0F0F0;
	font-size: 15px;
	border: 0;
	border-radius: 15px;
	width: 100px;
	height: 60px;
	margin: 0 20px;
}
#mainimage {
	width: 320px;
	height: 240px;
}
.datetimepicker-input {
	width: 1%;
}
.time-button {
	width: 60px;
	height: 40px;
	background-color: #F0F0F0;
	border: 0;
}
#curri {
	width: 798px;
	resize: none;
}
textarea:focus{
	outline: none;
}
</style>
</head>
<body>
<jsp:include page="../common/header.jsp"/>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.0/moment.min.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.18.0/locale/ko.js"></script>
<script src="../resources/timepicker/tempusdominus-bootstrap.js"></script>
<script src="${contextPath}/resources/timepicker/jquery.timepicker.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script src="${contextPath}/resources/summernote/js/summernote-lite.js"></script>
<script src="${contextPath}/resources/summernote/js/summernote-ko-KR.js"></script>
 <script>
 
   $(document).ready(function() {
      var parentWidth = $(".summerNoteArea").css("width").substring(0, $(".summerNoteArea").css("width").indexOf("px"))   * 0.98;
      
      console.log(parentWidth * 0.98)
      $('#summernote').summernote({
         width : 800, // 에디터 넓이
         height : 700, // 에디터 높이
         lang : 'ko-KR', // 언어 : 한국어
         callbacks : {
            onImageUpload : function(files) {
               sendFile(files[0], this);
            }
         }
      });
   });

   // 섬머노트에 업로드 된 이미지를 비동기로 서버로 전송하여 저장하는 함수
   function sendFile(file, editor) {
      var formData = new FormData();
      formData.append("uploadFile", file);
      $.ajax({
         url : "insertImage",
         type : "post",
         enctype : "multipart/form-data", // 파일 전송 형식으로 지정
         data : formData,
         contentType : false, // 서버로 전송되는 데이터 형식
         cache : false,
         processData : false,
         dataType : "json",
         success : function(at) {
            var contextPath = location.pathname.substring(0,
                  window.location.pathname.indexOf("/", 2));
            $(editor).summernote('editor.insertImage',
                  contextPath + at.filePath + "/" + at.fileName);
         }
      });
   }
 </script>
	<div class="container">
	<form action="${contextPath}/lesson/insert" method="post" enctype="multipart/form-data" onsubmit="return validate();" onreset="return validate2();">

		<div class="insert-main">
			
			<div class="insert-title">
				<p class="insert-p">수업명</p>
				<input class="form-control" name="lesTitle" id="title" placeholder="수업명">
			</div>
		<div class="insert-category">
				<p class="insert-p">카테고리</p>
				<div class="date-buttons">
			 		<button class="button-category" type="button" name="lesCategory" value="미술">미술</button>
					<button class="button-category" type="button" name="lesCategory" value="사진/영상">사진/영상</button>
					<button class="button-category" type="button" name="lesCategory" value="요리/음료">요리/음료</button>
					<button class="button-category" type="button" name="lesCategory" value="뷰티">뷰티</button>
					<button class="button-category" type="button" name="lesCategory" value="음악">음악</button>
					<br><br>
					<button class="button-category" type="button" name="lesCategory" value="운동">운동</button>
					<button class="button-category" type="button" name="lesCategory" value="공예">공예</button>
					<button class="button-category" type="button" name="lesCategory" value="글쓰기">글쓰기</button>
					<button class="button-category" type="button" name="lesCategory" value="키즈">키즈</button>
					<button class="button-category" type="button" name="lesCategory" value="플라워">플라워</button>
				</div>
			</div>
			
			<div class="filter-select">
		 
		</div>
			
			<div class="form-group insert-time">
				<p class="insert-p">수업시간</p>
				
       <div class="input-group date" id="datetimepicker1" data-target-input="nearest">
           <input type="text" class="form-control datetimepicker-input" data-target="#datetimepicker1" id="date" name="date"/>
           <div class="input-group-append" data-target="#datetimepicker1" data-toggle="datetimepicker">
               <div class="input-group-text"><i class="fa fa-calendar"></i></div>
       </div>
      </div>
				
				<input class="form-control timepicker t1" id="start-time1" name="start-time" placeholder="시작시간">
				<input class="form-control timepicker t2" id="end-time1" name="end-time" placeholder="종료시간">
				<button type="button" class="time-button" id="add-timeinput">추가</button>
				<button type="button" class="time-button" id="delete-timeinput">삭제</button>

			</div>
			
			<div class="form-group insert-limit">
				<p class="insert-p">정원</p>
				<input type="number" class="form-control" name="lesLimit" id="limit" placeholder="정원">
			</div>
			<div class="form-group insert-price">
				<p class="insert-p">가격</p>
				<input type="number" class="form-control" name="lesPrice" id="price" placeholder="가격">
			</div>
			
			<div class="form-group insert-cover">
				<p class="insert-p">대표이미지</p>
				<img id="mainimage">
				<input type="file" id="mainimage-file" name="mainimageFile" onchange="LoadImg(this)">
			</div>
			
			<div class="form-group insert-price">
				<p class="insert-p">커리큘럼</p>
				<textarea rows="10" cols="20" placeholder="커리큘럼" id="curri" name="lesCurri"></textarea>
			</div>
			
		</div>
		<div class="form-group insert-content">
			<div>
				<label for="content">내용</label>
			</div>
				<div class="summerNoteArea">
				<textarea class="form-control" id="summernote" name="lesContent" rows="20" style="resize: none;"></textarea>
				</div>
		</div>

		<br>
		<div class="button-area">
			<button type="reset">초기화</button>
			<button type="submit" id="submit">수업 등록</button>
		</div>
		</form>
	</div>
		<jsp:include page="../common/footer.jsp"/>

<script type="text/javascript">

$(function () {
    $('#datetimepicker1').datetimepicker({
        format: 'L',
        dayViewHeaderFormat: 'YYYY년 MMMM'
    });
});

var time = "";
$('.timepicker.t1').timepicker({
    timeFormat: 'HH:mm',
    interval: 60,
    minTime: '00',
    maxTime: '23:00',
    startTime: '00:00',
    dynamic: false,
    dropdown: true,
    scrollbar: true,
    change : function(){
    	$(".timepicker.t2").val("");
    	time = Number($(".timepicker.t1").val().substring(0, 2)) + 1;
    	$('.timepicker.t2').timepicker({
		    timeFormat: 'HH:mm',
		    interval: 60,
		    minTime: "0" + time,
		    maxTime: '23:00',
		    startTime: '00:00',
		    dynamic: false,
		    dropdown: true,
		    scrollbar: true,
		    change : function(){
		    	if($(".timepicker.t1").val().substring(0, 2) > $(".timepicker.t2").val().substring(0, 2)) {
		    		$(".timepicker.t1").val("");
		    	}
		    }
		});
    }
});

$("#price").focusout(function(){
	if($(this).val()<1) {
		$(this).val("");
	}
})

$("#limit").focusout(function(){
	if($(this).val()<1) {
		$(this).val("");
	}
})

$("#length").focusout(function(){
	if($(this).val()<1) {
		$(this).val("");
	}
})

var dateBtn = $(".date-button");
dateBtn.click(function() {
	if($(this).hasClass("active")){
		$(this).removeClass("active");
		$(this).css("background-color", "#FFFFFF");
	}
	else {
		$(this).addClass("active");
		$(this).css("background-color", "#FBBC73");
	}
});

function validate() {
	
	var $category = $(".active").val();
	if($category == null){
		window.alert("카테고리를 입력해주세요");
		return false;
	}
	$inputcategory = $("<input>", {type:'hidden', name:'lesCategory', value:$category});
	$("form").append($inputcategory);
	
	if($("#title").val().trim() == "") {
		window.alert("수업명을 입력해주세요");
		$("#title").focus();
		return false;
	} else if($("#limit").val().trim() == "") {
		window.alert("정원수를 입력해주세요");
		$("#limit").focus();
		return false;
	} else if($("#price").val().trim() == "") {
		window.alert("가격을 입력해주세요");
		$("#price").focus();
		return false;
	} else if($("#length").val().trim() == "") {
		window.alert("소요시간을 입력해주세요");
		$("#length").focus();
		return false;
	} else if($("#summernote").val().trim() == "") {
		window.alert("수업 내용을 입력해주세요");
		return false;
	} else if($("#mainimage-file").val.trim() == "") {
		window.alert("수업 내용을 입력해주세요");
		return false;
	} 
	
}

function validate2() {
	return window.confirm("정말 초기화 하시겠습니까?");
}

var index = 1;
$("#add-timeinput").click(function(event) {
	event.stopPropagation();
	index++;
	var $startinput = $("<input>", {'class' : "form-control timepicker t1", id:"start-time"+index, name:"start-time", placeholder:"시작시간"});
	var $endinput = $("<input>", {'class' : "form-control timepicker t2", id:"end-time"+index, name:"end-time", placeholder:"종료시간"});
	var dateinput = '<div class="input-group date" id="datetimepicker' + index + '" data-target-input="nearest">' +
						'<input type="text" class="form-control datetimepicker-input" data-target="#datetimepicker' + index + '" id="date" name="date"/>' +
            '<div class="input-group-append" data-target="#datetimepicker' + index + '" data-toggle="datetimepicker">' + 
                '<div class="input-group-text"><i class="fa fa-calendar"></i></div></div></div>'
   $(function () {
              $('#datetimepicker'+index).datetimepicker({
                  format: 'L'
              });
          });             
                
	$(this).before(dateinput);
	$(this).before($startinput);
	$(this).before($endinput);
	
	
	$('#start-time'+index).timepicker({
	    timeFormat: 'HH:mm',
	    interval: 60,
	    minTime: '00',
	    maxTime: '23:00',
	    startTime: '00:00',
	    dynamic: false,
	    dropdown: true,
	    scrollbar: true,
	    change : function(){
	    	$('#end-time'+index).val("");
	    	time = Number($('#start-time'+index).val().substring(0, 2)) + 1;
	    	$('#end-time'+index).timepicker({
			    timeFormat: 'HH:mm',
			    interval: 60,
			    minTime: "0" + time,
			    maxTime: '23:00',
			    startTime: '00:00',
			    dynamic: false,
			    dropdown: true,
			    scrollbar: true,
			    change : function(){
			    	if($('#start-time'+index).val().substring(0, 2) > $('#end-time'+index).val().substring(0, 2)) {
			    		$('#start-time'+index).val("");
			    	}
			    }
			});
	    }
	});
})

$("#delete-timeinput").click(function(event) {
	event.stopPropagation();
	if(index > 1){
		index--;
		$(this).prev().prev().remove();
		$(this).prev().prev().remove();
		$(this).prev().prev().remove();
	}
});

$(".button-category").click(function() {
		$(".button-category").removeClass("active");
		$(".button-category").css("background-color", "#F0F0F0");
		$(this).addClass("active");
		$(this).css("background-color", "#FBBC73");
	
});

$(function() {
	$("#mainimage-file").hide();
	$("#mainimage").click(function() {
		$("#mainimage-file").click();
	})
})

function LoadImg(value) {
	if(value.files && value.files[0]){ // 해당 요소에 업로드된 파일이 있을 경우
		var reader = new FileReader();
    	reader.readAsDataURL(value.files[0]);
    	reader.onload = function(e){
    	$("#mainimage").prop("src", e.target.result);
    }
	}
}


</script>
	
</body>
</html>