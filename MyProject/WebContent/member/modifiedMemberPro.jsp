<%@page import="Member.MemberDAO"%>
<%@page import="Member.MemberBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<!-- modifiedMember.jsp 에서 입력한 회원정보들을 DB와 연동해 수정하는 작업 -->

<%
	request.setCharacterEncoding("UTF-8");
	
	//기존 session에 입력되어있던 Id
	String oldId = (String)session.getAttribute("id");

	//modifiedMember.jsp에서 입력한 내용들 가져오기
	String newPw = request.getParameter("newPw");
	String newCheckPw = request.getParameter("newCheckPw");
	String newName = request.getParameter("newName");
	String newEmail = request.getParameter("newEmail");
	String newPhone = request.getParameter("newPhone");
	String newAddress_code = request.getParameter("newAddress_code");
	String newRoadAddress = request.getParameter("newRoadAddress");
	String newDetailAddress = request.getParameter("newDetailAddress");
	
	//입력한 정보들을 DB에 전송해서 수정하기
	MemberBean mBean = new MemberBean(oldId,newPw,newName,newEmail,newPhone,newAddress_code,newRoadAddress,newDetailAddress);
	
	MemberDAO mDAO = new MemberDAO();
	int result = mDAO.updateMember(oldId,mBean);
%>
	<script type="text/javascript">
		if(<%=result%>==0){
			alert("회원정보가 수정되었습니다.");
			location.href="../main.jsp";
		}else{
			alert("회원정보 수정에 실패하셨습니다.");
			history.back();
		}
	</script>
</body>
</html>