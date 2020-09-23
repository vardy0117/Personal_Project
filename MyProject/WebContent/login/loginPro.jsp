<%@page import="Member.MemberBean"%>
<%@page import="Member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>로그인 화면</title>
</head>
<body>
<%
	//한글처리
	request.setCharacterEncoding("UTF-8");

	String id = request.getParameter("id");
	String pw = request.getParameter("pw");


	MemberDAO mDAO = new MemberDAO();
	int result = mDAO.loginDAO(id, pw);
	
	if(result ==0){	//로그인에 성공했을시
		
		session.setAttribute("id", id);
		response.sendRedirect("../main.jsp");

		
	}else if(result == 1){ // ID는 맞고 비밀번호가틀릴시
%>
		<script type="text/javascript">
			alert("비밀번호를 확인하세요");
			history.back();
		</script>
<%
	}else{ // ID가 틀릴시
%>
		<script type="text/javascript">
			alert("ID를 확인하세요");
			history.back();
		</script>
<%		
	}
%>

<%=result %>
</body>
</html>