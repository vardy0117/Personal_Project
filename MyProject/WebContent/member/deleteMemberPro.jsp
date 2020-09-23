<%@page import="BoardComment.BoardCommentDAO"%>
<%@page import="Board.BoardDAO"%>
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
	//회원 탈퇴를 위한 jsp 페이지
	// 로그인되어있는 ID 와 입력받은 PWD를 이용하여 DB에서 DELETE 작업을 수행
	String id = (String)session.getAttribute("id");
	
	//입력받은 비밀번호값
	String pwd = request.getParameter("pwd");
	
	MemberDAO mDAO = new MemberDAO();
	int result = mDAO.selectPwd(id,pwd);

	if(result==0){
%>
	<script type="text/javascript">
		alert("탈퇴가 완료되었습니다.");
		location.href="../main.jsp";
		<%session.invalidate();%>	<%-- 세션 초기화 --%>
	</script>
<%		
	}else{
%>
		<script type="text/javascript">
			alert("입력한 비밀번호가 회원정보의 비밀번호와 일치하지 않습니다.");
			history.back();
		</script>
<%		
	}

	
	
	
	// 로그인 되어있는 id값과 일치하는 게시판의 글도
	// 탈퇴 버튼을 클릭했을때 삭제 시켜준다.
	BoardDAO bDAO = new BoardDAO();
	bDAO.secessionBoard(id);
	
	// 로그인 되어있는 id값과 일치하는 게시판의 댓글도
	// 탈퇴버튼을 클릭했을때 삭제 시켜준다.
	BoardCommentDAO bcDAO = new BoardCommentDAO();
	bcDAO.secessionBoardComment(id);
	
%>

<%	
		
	
	
%>
</body>
</html>