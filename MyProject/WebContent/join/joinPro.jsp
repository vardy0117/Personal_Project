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
<%
	/* join.jsp에서 텍스트 값들을 넘겨서 joinPro.jsp에서 DAO와 연결작업후 DB에 insert 하겠다 */

	request.setCharacterEncoding("UTF-8");
	
	String id = request.getParameter("id");
	String pw = request.getParameter("pw");
	String name = request.getParameter("name");
	String email = request.getParameter("email");
	String phone = request.getParameter("phone");
	String address_code = request.getParameter("address_code");
	String roadAddress = request.getParameter("roadAddress");
	String detailAddress = request.getParameter("detailAddress");
	
	//id,pw,name,email,phone,address_code,roadAddress,detailAddress
	
	//멤버빈 객체에 입력받은 텍스트 값 저장
	MemberBean mb = new MemberBean(id,pw,name,email,phone,address_code,roadAddress,detailAddress);
	
	
	
	//MemberDAO 객체 생성 후 입력받았던 텍스트값을 저장해둔 mb 객체 매개변수로 전달
	MemberDAO mDAO = new MemberDAO();
	
	// result 값에는 회원가입이 성공했으면 1 아니면 0이 저장되어있다
	int result = mDAO.insertDAO(mb);
	
	if(result == 1){
%>
		<script type="text/javascript">
			alert("회원가입이 완료되었습니다.");
			location.href="../main.jsp";
		</script>
<%		
	}
%>

</body>
</html>