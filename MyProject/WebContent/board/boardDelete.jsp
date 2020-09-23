<%@page import="BoardComment.BoardCommentDAO"%>
<%@page import="Board.BoardDAO"%>
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
	// boardDetail.jsp의 게시글 삭제하기 버튼을 클릭했을때 이동되어서 해당 Num을 가지고 DB에서 삭제하는 작업
	request.setCharacterEncoding("UTF-8");
	String num = request.getParameter("Num");
	int number = Integer.parseInt(num);
	BoardDAO bDAO = new BoardDAO();
	bDAO.deleteBoard(number);
%>
	<script type="text/javascript">
		alert("삭제완료");
		location.href="boardList.jsp";
	</script>
	
<%
	// 게시글이 삭제되면 해당 게시글에 있던 댓글도 DB에서 삭제 되어야 한다
	BoardCommentDAO bcDAO = new BoardCommentDAO();
	bcDAO.deleteBoardComment(number);

%>
</body>
</html>