<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>회원탈퇴</title>
</head>
	<script src="https://code.jquery.com/jquery-3.3.1.js"></script>

	<link href=../css/memberStyle.css rel="stylesheet" type="text/css">
<body>

<%--헤더영역 --%>
<jsp:include page="../include/header.jsp"/>
<%--헤더영역 --%>
<div id="body">
<script type="text/javascript">
	//비밀번호를 입력 했는지 확인한다
		function checkPw() {
			
			if($.trim($("#pwd").val()) == ""){
				alert("비밀번호를 확인하세요(공백X)");
				return false;
			}
			if($.trim($("#rePwd").val()) == ""){
				alert("비밀번호확인란을 확인하세요(공백X)");
				return false;
			}
		
		<%-- 비밀번호 란에 입력한 비밀번호와 비밀번호 확인란이 일치하는지 확인 --%>
			
			if($.trim($("#pwd").val()) != $.trim($("#rePwd").val())){
				alert("비밀번호를 확인하세요");
				$("#rePwd").focus();
				return false;
			}
	
	}
	
	
	
	
	
	
	
	//
</script>

<form action="deleteMemberPro.jsp" method="post" onsubmit="return checkPw()">
<table align="center">
	<tr>
		<th colspan="2">회원탈퇴를 위한 회원의 비밀번호를 입력해주세요</th>
	</tr>
	<tr>
		<td><h1>비밀번호</h1></td>
		<td><input type="password" id="pwd" name="pwd"></td>
	</tr>
	<tr>
		<td><h1>비밀번호 확인</h1></td>
		<td><input type="password" id="rePwd" name="rePwd"></td>
	</tr>
	<tr>
		<td></td>
		<td><input type="submit" value="회원탈퇴"><input type="reset" value="다시입력"></td>
	</tr>
</table>
</form>

</div>
<jsp:include page="../include/footer.jsp"/>
</body>
</html>