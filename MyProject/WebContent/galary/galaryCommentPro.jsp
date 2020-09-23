<%@page import="GalaryComment.GalaryCommentBean"%>
<%@page import="GalaryComment.GalaryCommentDAO"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//galaryDetail.jsp에서 댓글 등록 버튼을 클릭시 ajax로 요청하여 해당 댓글을 DB에 등록하는 작업
	
	// 해당 글의 number도 같이 전달 , textArea의 쓴 내용 전달, session에 저장되어있는 아이디도 전달
	String n = request.getParameter("num");
	int num = Integer.parseInt(n);
	String comment = request.getParameter("comment");
	String id = (String)session.getAttribute("id");
	
	GalaryCommentDAO gcDAO = new GalaryCommentDAO();
	gcDAO.insertComment(id,comment,num);

	
	// 댓글 등록이 완료가 되었다 !! 
	// 이제 만들어두었던 selectComment()를 이용하여 댓글들을 가져와 JSON객체로 보내주자
	ArrayList<GalaryCommentBean> list = gcDAO.selectComment(num);
	JSONArray jsonArr = new JSONArray();
	for(int i=0;i<list.size();i++){
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("number", list.get(i).getNumber());
		jsonObj.put("id", list.get(i).getId());
		jsonObj.put("comment", list.get(i).getComment());
		jsonObj.put("date", list.get(i).getDate());
		jsonObj.put("primaryNum", list.get(i).getPrimaryNum());
		jsonArr.add(jsonObj);
	}
%>
<%=jsonArr.toJSONString() %>
