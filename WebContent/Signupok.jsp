<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<% 
	String u_name = request.getParameter("username");
	String u_id = request.getParameter("userid");
	String u_pw = request.getParameter("userpw");
	String u_pwch = request.getParameter("userpwcheck");
	
	if(u_name.trim().isEmpty()) {
%>	
	<script>
		alert("닉네임을 입력하세요.");
		history.back();
	</script>
<%
} else if("admin".equals(u_id)) {
%>
	<script>
		alert("관리자 계정은 생성할 수 없습니다.");
		history.back();
	</script>
<%
} else if(u_id.length() < 6 || u_pw.length() > 12) {
%>
	<script>
		alert("아이디는 6자리 이상 12자리 이하로 입력해야 합니다.");
		history.back();
	</script>
<%
} else if(u_pw.length() < 8 || u_pw.length() > 20) {
%>
	<script>
		alert("비밀번호는 8자리 이상 20자리 이하로 입력해야 합니다.");
		history.back();
	</script>
<%
} else if(!u_pw.equals(u_pwch)) {
%>
	<script>
		alert("비밀번호가 맞지 않습니다.");
		history.back();
	</script>
<%
	}
	else {
        String sql = "INSERT INTO jypuser(name, id, pw) VALUES";
        sql += "('" + u_name + "','" + u_id + "','" + u_pw + "')";
    
        String driverName = "com.mysql.jdbc.Driver";
        String url = "jdbc:mysql://localhost:3307/jyp";
        String username = "root";
        String password = "dongyang";
        Connection conn = null;
    
        
        Class.forName(driverName);
        conn = DriverManager.getConnection(url, username, password);
        Statement sm = conn.createStatement();
        
        int count = sm.executeUpdate(sql);
        
        sm.close();
        conn.close();
        
        session.setAttribute("username", u_name);
%>
    <script>
        alert("회원가입이 성공적으로 완료되었습니다.");
        window.location.href = "Login.jsp";
    </script>
<%    
    }
%>
