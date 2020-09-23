<%@page import="Reserve.ReserveDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//adminResrve.jsp에서 [취소] 버튼 클릭했을때 ajax방식으로 요청되는 페이지로 DB와 연동하여 DELETE 작업을 한다
	request.setCharacterEncoding("utf-8");
	int num = Integer.parseInt(request.getParameter("num"));
	
	ReserveDAO rDAO = new ReserveDAO();
	int result = rDAO.deleteReserve(num);
%>
<%=result%>