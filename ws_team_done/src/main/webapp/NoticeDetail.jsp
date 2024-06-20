<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.text.SimpleDateFormat" %>

<!DOCTYPE html>
<html>
<head>
    <title>공지사항 상세</title>
</head>
<body>
<%-- Main.jsp로 이동할 수 있는 버튼 --%>
<button onclick="location.href='Main.jsp'">처음으로 돌아가기</button>
<%
    // 데이터베이스 연결 정보 설정
    String driverName = "com.mysql.cj.jdbc.Driver";
    String url = "jdbc:mysql://localhost:3306/jyp";
    String username = "root";
    String password = "dongyang";
    Connection conn = null;

    // 공지사항 ID를 요청 매개변수에서 가져옴
    String idParam = request.getParameter("id");
    if (idParam == null || idParam.isEmpty()) {
        out.println("공지사항 ID가 전달되지 않았습니다.");
        return;
    }

    int noticeId;
    try {
        noticeId = Integer.parseInt(idParam);
    } catch (NumberFormatException e) {
        out.println("잘못된 공지사항 ID 형식입니다.");
        return;
    }

    String noticeTitle = "";
    String noticeContent = "";
    String noticeDate = "";

    try {
        // JDBC 드라이버 로드 및 데이터베이스 연결
        Class.forName(driverName);
        conn = DriverManager.getConnection(url, username, password);

        // 공지사항 상세 정보 가져오기
        String sql = "SELECT * FROM notices WHERE id = ?";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setInt(1, noticeId);
        ResultSet rs = stmt.executeQuery();

        // 공지사항 정보 설정
        if (rs.next()) {
            noticeTitle = rs.getString("title");
            noticeContent = rs.getString("content");
            
            // created_at 필드를 날짜, 시, 분 형식으로 변환
            Timestamp timestamp = rs.getTimestamp("created_at");
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
            noticeDate = dateFormat.format(timestamp);
        } else {
            out.println("해당 ID의 공지사항을 찾을 수 없습니다.");
            rs.close();
            stmt.close();
            conn.close();
            return;
        }

        // 댓글 목록 가져오기
        String commentSql = "SELECT * FROM noticecomments WHERE notice_id = ? ORDER BY created_at DESC";
        PreparedStatement commentStmt = conn.prepareStatement(commentSql);
        commentStmt.setInt(1, noticeId);
        ResultSet commentRs = commentStmt.executeQuery();
%>

<!-- 공지사항 제목 및 내용 표시 -->
<h1><%= noticeTitle %></h1>
<p><%= noticeContent %></p>
<!-- 작성자 정보 -->
<p><i>작성자: 젭삐마스터</i></p>
<p><i>작성일: <%= noticeDate %></i></p>
<hr>
<!-- 댓글 목록 표시 -->
<h2>댓글</h2>
<% while (commentRs.next()) { %>
    <p><strong><%= commentRs.getString("username") %></strong>: <%= commentRs.getString("content") %></p>
<% } %>
<hr>
<%
    // 리소스 해제
    rs.close();
    stmt.close();
    commentRs.close();
    commentStmt.close();
    conn.close();

} catch (Exception e) {
    e.printStackTrace();
    out.println("데이터베이스 오류가 발생했습니다: " + e.getMessage());
}
%>

<!-- 댓글 작성 폼 -->
<form action="PostComment.jsp" method="post">
    <input type="hidden" name="noticeId" value="<%= noticeId %>">
    <input type="hidden" name="username" value="<%= (String) session.getAttribute("id") %>">
    <label for="commentContent">댓글:</label><br>
    <textarea id="commentContent" name="commentContent" rows="4" cols="50" required></textarea><br><br>
    <button type="submit">댓글 작성</button>
</form>
</body>
</html>
