<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>동물미용</title>
</head>
<body>
<%
	//세션값초기화
	session.invalidate();
%>

	<script type="text/javascript">
		alert("로그아웃 되었습니다.");
		location.href="../main.jsp";
	</script>
</body>
</html>