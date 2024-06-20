<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Main</title>
</head>
<body>
<%
    String u_id = (String)session.getAttribute("id");
    String u_pw = (String)session.getAttribute("pw");
    String u_name = (String)session.getAttribute("username");

    if("admin".equals(u_id) && "123456".equals(u_pw)){
        out.println("관리자님 환영합니다.");
    } else {
        out.println(u_name + "님 환영합니다.");
    }
%>
    <br><br>
    <form action="Login.jsp" method="get">
        <input type="submit" value="로그아웃">
    </form>
    <form action="Album_page.jsp" method="get">
        <input type="submit" value="앨범">
    </form>
    <form action="NoticeForm.jsp" method="get">
        <input type="submit" value="공지사항">
    </form>
    <form action="addMessage.jsp" method="get">
        <input type="submit" value="방명록">
    </form>
    <form action="jyp.jsp" method="get">
        <input type="submit" value="소개글">
    </form>
</body>
</html>
