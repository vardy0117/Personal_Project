<%@page import="Member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	request.setCharacterEncoding("UTF-8");
	String id = request.getParameter("id");
	MemberDAO mDAO = new MemberDAO();
	int result = mDAO.dropMember(id);
	if(result == 0){	//입력한 아이디가 존재하면
		
%>
		<script type="text/javascript">
			alert("회원강제탈퇴가 완료되었습니다.");
			window.close();
		</script>
<%
	}else{	//입력한 아이다가 존재하지 않으면
%>
		<script>
			alert("입력한 회원은 존재하지 않습니다.");
			history.back();
		</script>
<%		
	}
%>
</body>
</html>