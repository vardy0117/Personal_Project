<%@page import="Board.BoardBean"%>
<%@page import="Board.BoardDAO"%>
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
	//게시글 작성 동작을 처리하는 jsp페이지
	
	request.setCharacterEncoding("UTF-8");
	String name = request.getParameter("name");
	String pass = request.getParameter("pass");
	String subject = request.getParameter("subject");
	String content = request.getParameter("content");
	content = content.replace("\r\n", "<br>");	// 엔터키 적용 작업
	
	BoardBean bBean = new BoardBean(name,pass,subject,content);
	BoardDAO bDAO = new BoardDAO();
	int result = bDAO.insertBoard(bBean);
	
	
	
	
%>
<script type="text/javascript">
	if(result ==0){
		alert("글 작성이 완료되었습니다.");
		<%response.sendRedirect("boardList.jsp");%>
	}else{
		alert("글 작성에 실패하셨습니다.");
	}
</script>
</body>
</html>