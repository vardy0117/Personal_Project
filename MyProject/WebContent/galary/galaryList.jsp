<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Galary.GalaryDAO"%>
<%@page import="Galary.GalaryBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
// 	GalaryDAO gDAO = new GalaryDAO();
// 	ArrayList<GalaryBean> list = gDAO.selectGalary();
	


// 	for(int i = 0;i<list.size();i++){
// 		GalaryBean gBean = new GalaryBean();
// 		gBean = list.get(i);
// 		out.print(gBean);
// 	}
	
// 	JSONObject jsonObj = new JSONObject();
// 	JSONArray jsonArr = new JSONArray();
// 	for(int i =0;i<list.size();i++){
// 		 JSONObject jsonObj2 = new JSONObject();
// 		 jsonObj2.put("name", list.get(i).getName());
// 		 jsonObj2.put("subject", list.get(i).getSubject());
// 		 jsonObj2.put("file", list.get(i).getFile());
// 		 jsonObj2.put("content", list.get(i).getContent());
// 		 jsonObj2.put("date", list.get(i).getDate());
// 		 jsonObj2.put("num", list.get(i).getNum());
// 		 jsonArr.add(jsonObj2);
// 	}
// 	jsonObj.put("galaryBoard", jsonArr);



%>
<%-- <%=jsonObj.toJSONString() %> --%>
