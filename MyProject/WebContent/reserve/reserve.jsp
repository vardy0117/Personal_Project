<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
   <link href=../css/reserveStyle.css rel="stylesheet" type="text/css">
<title>동물미용</title>
	<script src="https://code.jquery.com/jquery-3.3.1.js"></script>
</head>
<body>
	
	<jsp:include page="../include/header.jsp"/>
<div id="body">
	<center>
		<table align="center">
			<tr>
				<th><h2>예약하기</h2></th>
			</tr>
		</table>
		<div id="dogGroomImg">
			<img src="../img/dogGroom.jpg">
		</div>
		<div id="dogGroomText">
			<h3>Hair Cut & Grooming</h3>
			<p>50,000 ￦</p>
			<input type="button" value="예약하기" onclick="location.href='reserveDogGrooming.jsp'">		
		</div>
		
	</center>
	
	<div style="clear:both;"></div>
	<br>
	<br>
</div>
<jsp:include page="../include/footer.jsp"/>
</body>
</html>