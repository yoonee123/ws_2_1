<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
String u_id = request.getParameter("id");
String u_pw = request.getParameter("pw");

String driverName = "com.mysql.jdbc.Driver";
String url = "jdbc:mysql://localhost:3307/jyp";
String username = "root";
String password = "dongyang";
Connection conn = null;

Class.forName(driverName);
conn = DriverManager.getConnection(url, username, password);

String sql = "select * from jypuser where id = ? AND pw = ?";
PreparedStatement ps = conn.prepareStatement(sql);
ps.setString(1, u_id);
ps.setString(2, u_pw);

ResultSet rs = ps.executeQuery();

if(rs.next()) {
	session.setAttribute("id", u_id);
	session.setAttribute("pw", u_pw);
%>
<script>
	alert("로그인 성공!")
	window.location.href = "Main.jsp";
</script>
<%
} else {
%>
<script>
	alert("아이디 또는 비밀번호가 잘못되었습니다.")
	history.back();
</script>
<%
}
rs.close();
ps.close();
conn.close();
%>