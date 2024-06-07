<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.regex.*" %>
<% 
	String u_name = request.getParameter("userName");
	String u_phone = request.getParameter("userPnum");
	
	String sql = "INSERT INTO regular_users(username, password) VALUES";
	sql += "('" + u_name + "','" + u_phone + "')";
	
	String driverName="com.mysql.jdbc.Driver";
	String url = "jdbc:mysql://localhost:3306/fanpage";
	String username = "root";
	String password = "dongyang";
	Connection conn = null;
	
	Class.forName(driverName);
	conn = DriverManager.getConnection(url, username, password);
	Statement sm = conn.createStatement();
	
	int count = sm.executeUpdate(sql);
	if(count == 1){
		out.println("등록 성공!");
	}else{
		out.println("등록 실패!");
	}
	sm.close();
	conn.close();	
%>