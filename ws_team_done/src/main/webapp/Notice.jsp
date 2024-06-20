<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html>
<head>
    <title>공지사항</title>
</head>
<body>
<%-- Main.jsp로 이동할 수 있는 버튼 --%>
<button onclick="location.href='Main.jsp'">처음으로 돌아가기</button>
<%
    // 데이터베이스 연결 정보를 설정
    String driverName = "com.mysql.cj.jdbc.Driver";
    String url = "jdbc:mysql://localhost:3306/jyp";
    String username = "root";
    String password = "dongyang";
    Connection conn = null;

    try {
        // JDBC 드라이버를 로드하고 데이터베이스에 연결
        Class.forName(driverName);
        conn = DriverManager.getConnection(url, username, password);

        // 공지사항을 조회하기 위한 SQL 쿼리
        String noticeSql = "SELECT * FROM notices";
        PreparedStatement noticeStmt = conn.prepareStatement(noticeSql);
        ResultSet noticeRs = noticeStmt.executeQuery();

        // 공지사항 표시 섹션: 공지사항 목록을 표시
        out.println("<ul id='noticeList'>");
        while (noticeRs.next()) {
            int noticeId = noticeRs.getInt("id");
            String noticeTitle = noticeRs.getString("title");
            Timestamp timestamp = noticeRs.getTimestamp("created_at");
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
            String noticeDate = dateFormat.format(timestamp);

            out.println("<li><a href='NoticeDetail.jsp?id=" + noticeId + "'>" 
                + noticeTitle + "</a> - " + noticeDate + "</li>");
        }
        out.println("</ul>");

        // 사용한 ResultSet과 PreparedStatement를 닫고 데이터베이스 연결을 종료
        noticeRs.close();
        noticeStmt.close();
        conn.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
%>

</body>
</html>
