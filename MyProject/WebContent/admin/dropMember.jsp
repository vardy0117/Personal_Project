<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
   <link href=../css/adminStyle.css rel="stylesheet" type="text/css">
<title>동물미용</title>
	<script src="https://code.jquery.com/jquery-3.3.1.js"></script>
</head>
<body>
	<form action="dropMemberPro.jsp" method="post">
		<table border="1" width="500">
			<tr><th align="center">탈퇴시킬 회원의 아이디를 입력하세요</th></tr>
			<tr align="center"><td>ID&nbsp;<input type="text" name="id"></td></tr>
			<tr align="center"><td><input type="submit" value="강제탈퇴"><input type="reset" value="다시입력"></td></tr>
			
		</table>
	</form>
</body>
</html>