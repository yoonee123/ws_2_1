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
    <!-- 앨범 페이지로 이동하는 버튼 -->
    <form action="Album_page.jsp" method="get">
        <input type="submit" value="앨범">
    </form>
    <form action="addMessage.jsp" method="get">
        <input type="submit" value="방명록">
    </form>
</body>
</html>
