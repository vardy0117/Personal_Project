<%@page import="Member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
request.setCharacterEncoding("UTF-8");
String id = request.getParameter("id");
response.setContentType("text/html;charset=utf-8");

MemberDAO mDAO = new MemberDAO();
int result = mDAO.checkId(id);
%>
<%=result %>
