<%@page import="Reserve.ReserveDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	//myReserve.jsp 에서 [취소] 버튼 클릭 시 사용자가 자신이 예약한 접수 내용을 취소 할수 있게
	int num = Integer.parseInt(request.getParameter("num"));

	// DB와 연동하여 해당 num의 행을 삭제한다
	ReserveDAO rDAO = new ReserveDAO();
	int result = rDAO.deleteReserve(num);
	
	
%>
<%=result %>
