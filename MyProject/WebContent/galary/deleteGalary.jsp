<%@page import="Galary.GalaryDAO"%>
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
		//galaryDetail.jsp에서 게시글 하나를 삭제 하려고 할때 이동되는 페이지
		request.setCharacterEncoding("utf-8");
		int num = Integer.parseInt(request.getParameter("num"));
		GalaryDAO gDAO = new GalaryDAO();
		int result = gDAO.deleteGalary(num);
		
		if(result > 0){
	%>
		<script type="text/javascript">
			alert("게시글 삭제가 완료되었습니다.");
			location.href="galary.jsp";	
		</script>
	<%		
		}
	
	%>
</body>
</html>