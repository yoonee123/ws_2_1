<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html>
<head>
    <title>앨범 목록 페이지</title>
</head>
<body>

<h2>업로드된 사진 목록</h2>

<!-- 업로드된 사진을 표시할 영역 -->
<div id="photoList">
    <%
        // MySQL 데이터베이스 연결 정보 설정
        String driverName = "com.mysql.cj.jdbc.Driver";
        String url = "jdbc:mysql://localhost:3306/jyp";
        String username = "root";
        String password = "dongyang";

        // JDBC 드라이버 로드
        Class.forName(driverName);
        // 데이터베이스 연결
        Connection conn = DriverManager.getConnection(url, username, password);
        
        // 업로드된 사진 경로 및 업로드 시간을 조회하는 SQL 쿼리
        String photoSql = "SELECT * FROM photos";
        Statement photoStmt = conn.createStatement();
        ResultSet photoRs = photoStmt.executeQuery(photoSql);
        
        // 각 사진을 반복하여 표시
        while (photoRs.next()) {
            int photoId = photoRs.getInt("id");  // 각 사진의 고유 ID
            String photoPath = photoRs.getString("path");  // 사진 경로
            Timestamp createdAt = photoRs.getTimestamp("created_at"); // 사진 업로드 시간
            
            // SimpleDateFormat을 사용하여 원하는 형식으로 시간을 변환
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
            String formattedCreatedAt = dateFormat.format(createdAt);
    %>
    <div>
        <!-- 사진을 화면에 표시 -->
        <a href='Album_view.jsp?photoId=<%= photoId %>'>
            <img src='<%= photoPath %>' style='max-width: 150px;'>
        </a>
    </div>
    <% } %>

    <!-- 데이터베이스 리소스 해제 -->
    <%
        photoRs.close();
        photoStmt.close();
        conn.close();
    %>
</div>

<!-- Main.jsp로 돌아가는 버튼 -->
<form action="Main.jsp" method="get">
    <button type="submit">처음으로 돌아가기</button>
</form>

</body>
</html>
