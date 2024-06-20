<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>댓글 작성</title>
</head>
<body>

<%
    // 댓글 폼에서 전송된 데이터 받기
    int noticeId = Integer.parseInt(request.getParameter("noticeId"));
    String username = request.getParameter("username");
    String commentContent = request.getParameter("commentContent");

    // 데이터베이스 연결 정보
    String driverName = "com.mysql.cj.jdbc.Driver";
    String url = "jdbc:mysql://localhost:3306/jyp";
    String usernameDb = "root";
    String passwordDb = "dongyang";
    Connection conn = null;

    try {
        // 드라이버 로드 및 데이터베이스 연결
        Class.forName(driverName);
        conn = DriverManager.getConnection(url, usernameDb, passwordDb);

        // SQL 문 준비 및 실행
        String sql = "INSERT INTO noticecomments (notice_id, username, content, created_at) VALUES (?, ?, ?, NOW())";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setInt(1, noticeId);
        stmt.setString(2, username);
        stmt.setString(3, commentContent);

        // SQL 문 실행
        stmt.executeUpdate();

        // 자원 해제
        stmt.close();
        conn.close();

        // 공지사항 상세 페이지로 리디렉션
        response.sendRedirect("NoticeDetail.jsp?id=" + noticeId);
    } catch (Exception e) {
        e.printStackTrace();
        // 데이터베이스 오류 발생 시 메시지 출력
        out.println("데이터베이스 오류가 발생했습니다. 다시 시도해주세요.");
    }
%>

</body>
</html>