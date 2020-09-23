<%@page import="Reserve.ReserveDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	//adminReserve.jsp에서 [접수] 버튼 클릭시 해당 예약 정보의 예약번호를 ajax통신으로 이 페이지로 전송했다
	int num = Integer.parseInt(request.getParameter("num"));

	//이 num을가지고 DB로 이동하여 해당 예약정보의 check값을 1로 변경시켜준다
	ReserveDAO rDAO = new ReserveDAO();
	int result = rDAO.submit(num);
	
%>	
<%=result %>

