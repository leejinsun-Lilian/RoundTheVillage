<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>info</title>
<style>
.lesson-content, .lesson-curriculum, .lesson-location {
	border-bottom: 1px solid #e4e9ef;
}
</style>
</head>
<body>
	<div class="lesson-content">
		<div class="title">수업내용</div>
		<p>${lesson.lesContent}</p>
	</div>
	<div class="lesson-curriculum">
		<div class="title">${lesson.lesCurri}</div>
	</div>
	<div class="lesson-location">
		<div class="title">위치</div>
	</div>
</body>
</html>