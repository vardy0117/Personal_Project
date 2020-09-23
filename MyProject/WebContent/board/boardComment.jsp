<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.eclipse.jdt.internal.compiler.ast.JavadocQualifiedTypeReference"%>
<%@page import="java.util.ArrayList"%>
<%@page import="BoardComment.BoardCommentBean"%>
<%@page import="BoardComment.BoardCommentDAO"%>
<%@page import="Board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	
	
// 	String Num1 = request.getParameter("Num");
// 	int Num = Integer.parseInt(Num1);
	//String num = (String)session.getAttribute("Num");
	
	//댓글을 등록한 사용자의 ID
	String id = (String)session.getAttribute("id");
	
	//댓글
	String comment = request.getParameter("comment");
	
	//댓글을 작성한 글 번호
	String num = request.getParameter("pageNum");
	int number = Integer.parseInt(num);
	
	//DB와 연동하여 댓글 추가 작업
	BoardCommentDAO bcDAO = new BoardCommentDAO();
	BoardCommentBean bcBean = new BoardCommentBean(number,id,comment);
	int result = bcDAO.insertComment(bcBean);
	
	
	//댓글 등록 후 등록된 댓글 + 기존 댓글 작업
	ArrayList<BoardCommentBean> list = bcDAO.selectComment(number);
	JSONArray jsonAr = new JSONArray();
	
	for(int i=0;i<list.size();i++){
		JSONObject jsonOb = new JSONObject();
		
		jsonOb.put("id", list.get(i).getId());
		jsonOb.put("comment", list.get(i).getComment());
		jsonOb.put("date", list.get(i).getDate());
		jsonOb.put("primaryNum",list.get(i).getPrimaryNum());
		
		jsonAr.add(jsonOb);
	}
	out.print(jsonAr.toJSONString());
	
%>
