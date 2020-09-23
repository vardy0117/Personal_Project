<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="jdk.nashorn.api.scripting.JSObject"%>
<%@page import="Member.MemberBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	// lookUpMember.jsp에서 회원정보 조회를 ajax방식을 통해서 얻어오려한다
	// 그래서 <a>회원정보조회</a>를 클릭하면 이 페이지(allMemberSelect.jsp)로 연결되어 Member DB와 연동하여 
	// 모든 회원정보를 가져올거다
	// JSON객체로 넘겨준다
	MemberDAO mDAO = new MemberDAO();
	ArrayList<MemberBean> list = mDAO.selectMember();
	JSONArray jsonArr = new JSONArray(); 
	
	for(int i=0; i<list.size(); i++) {
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("id", list.get(i).getId());
		jsonObj.put("pw", list.get(i).getPw());
		jsonObj.put("name", list.get(i).getName());
		jsonObj.put("email", list.get(i).getEmail());
		jsonObj.put("phone", list.get(i).getPhone());
		jsonObj.put("address_code", list.get(i).getAddress_code());
		jsonObj.put("roadAddress", list.get(i).getRoadAddress());
		jsonObj.put("detailAddress", list.get(i).getDetailAddress());
		jsonArr.add(jsonObj);
	}
	JSONObject jsonObj2 = new JSONObject();
	jsonObj2.put("member", jsonArr);
%>
<%=jsonObj2.toJSONString()%>
