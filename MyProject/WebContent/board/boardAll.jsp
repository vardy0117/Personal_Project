<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="Board.BoardBean"%>
<%@page import="Board.BoardDAO"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>



<%
//페이징 작업하면서 ajax방식으로 게시글목록을 보여주는방식에 오류가생겨서 일단 보류

// 	//boardList.jsp에서 ajax방식으로 글목록을 요청한 페이지
// 	BoardDAO bDAO = new BoardDAO();
// 	ArrayList<BoardBean> list = bDAO.selectAll();

// 	JSONArray jsonAr = new JSONArray();
// 	JSONObject jsonOb2 = new JSONObject();
// 	for(int i = 0;i<list.size();i++){
// 		JSONObject jsonOb = new JSONObject();
// 		jsonOb.put("number", list.get(i).getNumber());
// 		jsonOb.put("name", list.get(i).getName());
// 		jsonOb.put("subject", list.get(i).getSubject());
// 		jsonOb.put("date", list.get(i).getDate());
		
// 		jsonAr.add(jsonOb);
// 	}
// 	jsonOb2.put("board", jsonAr);
%>

<%-- <%=jsonOb2.toJSONString() %> --%>
