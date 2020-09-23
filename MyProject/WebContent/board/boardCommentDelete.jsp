<%@page import="BoardComment.BoardCommentDAO"%>
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
	//자신이 작성한 댓글  옆에 [ X ] 버튼 클릭시 이동되는 jsp페이지로 댓글 삭제 기능을 한다.
	request.setCharacterEncoding("UTF-8");
	String primaryNum2 = request.getParameter("primaryNum");
	int primaryNum = Integer.parseInt(primaryNum2);
	BoardCommentDAO bcDAO = new BoardCommentDAO();
	bcDAO.deleteComment(primaryNum);
	
	//삭제 작업은 잘되는데 페이지 새로고침을 일일이 해줘야함
%>
	<script type="text/javascript">
		alert("댓글 삭제 완료");
		location.href = document.referrer;	//페이지 뒤로가기 후 새로고침
	</script>
</body>
</html>