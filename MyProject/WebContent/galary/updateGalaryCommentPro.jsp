<%@page import="GalaryComment.GalaryCommentDAO"%>
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
	//updateGalaryComment.jsp에서 댓글 수정하기 버튼 클릭했을때 이동되는 페이지로 
	// DB와 연동하여 update작업을 한다.
	request.setCharacterEncoding("utf-8");
	String comment = request.getParameter("newComment");
	int primaryNum = Integer.parseInt( request.getParameter("primaryNum"));
	
	GalaryCommentDAO gcDAO = new GalaryCommentDAO();
	int result = gcDAO.updateDetailComment(comment,primaryNum);

	if(result == 1){//수정에 성공
%>
		<script type="text/javascript">
			alert("댓글이 수정되었습니다.");
			window.opener.location.reload();
			window.close();
		</script>
<%		
	}
%>


</body>
</html>