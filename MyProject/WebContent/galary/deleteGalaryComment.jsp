<%@page import="GalaryComment.GalaryCommentDAO"%>
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
	// galaryDetail.jsp에서 자신이 작성한 댓글에 삭제 버튼을 클릭했을때 이동되는 페이지
	// DB와 연동하여 해당 글의 고유번호를 넘겨 받아서 삭제 작업을 한다
	int primaryNum= Integer.parseInt(request.getParameter("primaryNum"));
	GalaryCommentDAO gcDAO = new GalaryCommentDAO();
	int result = gcDAO.deleteComment(primaryNum);

	if(result == 1){	//삭제가 되었따.
%>
		<script type="text/javascript">
			alert("댓글이 삭제 되었씁니다.");
			location.href = document.referrer;	//페이지 뒤로가기 후 새로고침
		</script>
<%		
	}

%>

</body>
</html>