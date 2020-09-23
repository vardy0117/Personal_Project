<%@page import="Reserve.ReserveBean"%>
<%@page import="Reserve.ReserveDAO"%>
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

	// reserveDogGrooming.jsp에서 예약 시간 등등을 입력하고 예약하기 버튼을 클릭했을때 이동되는 페이지로써..
	// DB에 insert작업을 수행
	request.setCharacterEncoding("utf-8");

	//예약한 사람의 ID
	String id = (String)session.getAttribute("id");
	//예약한 날짜
	String date = request.getParameter("date");
	//예약한 시간
	String time = request.getParameter("time");
	//예약한 강아지 이름
	String dogName = request.getParameter("dogName");
	//예약한 추가 요청사항
	String order = request.getParameter("order");
	
	//DB에 예약정보를 insert하자 
	ReserveDAO rDAO = new ReserveDAO();
	ReserveBean rBean = new ReserveBean();
	rBean.setId(id);
	rBean.setDate(date);
	rBean.setTime(time);
	rBean.setDogname(dogName);
	rBean.setOrder(order);
	
	int result = rDAO.insertReserve(rBean);
	
	if(result == 1){
%>
	<script type="text/javascript">
		alert("예약이 완료되었습니다.")
		location.href="../main.jsp";
	</script>
<%		
	}else{
%>
	<script type="text/javascript">
		alert("예약에 실패하셨습니다. \n관리자에게 문의하세요");
		history.back();	
	</script>
<%		
	}
%>
</body>
</html>