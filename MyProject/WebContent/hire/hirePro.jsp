<%@page import="javax.mail.Transport"%>
<%@page import="javax.mail.Message"%>
<%@page import="javax.mail.internet.InternetAddress"%>
<%@page import="javax.mail.Address"%>
<%@page import="javax.mail.internet.MimeMessage"%>
<%@page import="javax.mail.Session"%>
<%@page import="mail.SendMail"%>
<%@page import="javax.mail.Authenticator"%>
<%@page import="java.util.Properties"%>
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
	request.setCharacterEncoding("utf-8");
	String name =request.getParameter("name");
	String age = request.getParameter("age");
	String phone = request.getParameter("phone");
	String info = request.getParameter("info");
	String content = "이름 : "+name+" \n 나이 : "+age+" \n 휴대폰 번호 : "+phone+" \n 자기 소개 : "+ info;
	
	Properties p = new Properties();
	
	p.put("mail.smtp.host","smtp.naver.com"); // 네이버 SMTP
	p.put("mail.smtp.port", "465");
	p.put("mail.smtp.starttls.enable", "true");
	p.put("mail.smtp.auth", "true");
	p.put("mail.smtp.debug", "true");
	p.put("mail.smtp.socketFactory.port", "465");
	p.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
	p.put("mail.smtp.socketFactory.fallback", "false");

	Authenticator auth = new SendMail();
	Session ses = Session.getInstance(p, auth);
	ses.setDebug(true);
	 MimeMessage msg = new MimeMessage(ses); // 메일의 내용을 담을 객체
    msg.setSubject(name+"의 이력서"); 
     
    Address fromAddr = new InternetAddress("vardy0117@naver.com",name);
    msg.setFrom(fromAddr); // 보내는 사람
     
    Address toAddr = new InternetAddress("vardy0117@naver.com");
    msg.addRecipient(Message.RecipientType.TO, toAddr); // 받는 사람
     
   // msg.setContent(content, "text/html;charset=UTF-8"); // 내용과 인코딩
     msg.setText(content);
    Transport.send(msg); // 전송


%>
	<script type="text/javascript">
		alert("이력서 전송 완료 !");
		location.href="../main.jsp";
	</script>
</body>
</html>