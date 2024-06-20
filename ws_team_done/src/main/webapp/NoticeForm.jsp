<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.io.*, jakarta.servlet.http.*, jakarta.servlet.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>공지 작성</title>
</head>
<body>
<%
    // 현재 로그인한 사용자의 ID를 세션에서 가져옴
    String loggedInUser = (String) session.getAttribute("id");

    // jypuser 테이블에서 사용자 정보를 조회하는 SQL 쿼리
    String sql = "SELECT * FROM jypuser WHERE id = ?";
    
    String driverName = "com.mysql.cj.jdbc.Driver";
    String url = "jdbc:mysql://localhost:3306/jyp";
    String username = "root";
    String password = "dongyang";
    Connection conn = null;
    
    // JDBC 드라이버를 로드
    Class.forName(driverName);
    // 데이터베이스 연결
    conn = DriverManager.getConnection(url, username, password);
    
    // SQL 쿼리를 준비하고 파라미터로 사용자의 ID를 설정
    PreparedStatement sm = conn.prepareStatement(sql);
    sm.setString(1, loggedInUser);

    // SQL 쿼리 실행
    ResultSet rs = sm.executeQuery();
    
    boolean isAdmin = false; // 관리자 여부를 저장하는 변수
    if (rs.next()) {
        // 조회된 결과에서 ID를 가져와 관리자 여부를 확인
        String username_result = rs.getString("id");
        if ("admin".equals(username_result)) {
            isAdmin = true;
        }
    }

    rs.close();
    sm.close();
    conn.close();
%>

<% if (isAdmin) { %>
<%-- 공지 작성 폼 --%>
<form action="PostNotice.jsp" method="post">
    <table>
        <tr>
            <td><label for="author">작성자:</label></td>
            <%-- 작성자 입력 필드 (고정값) --%>
            <td><input type="text" id="author" name="author" value="젭삐마스터" readonly></td>
        </tr>
        <tr>
            <td><label for="noticeTitle">제목:</label></td>
            <%-- 제목 입력 필드 --%>
            <td><input type="text" id="noticeTitle" name="noticeTitle" required></td>
        </tr>
        <tr>
            <td><label for="noticeContent">내용:</label></td>
            <%-- 내용 입력 필드 --%>
            <td><textarea id="noticeContent" name="noticeContent" rows="4" cols="50" required></textarea></td>
        </tr>
    </table>
    <%-- 작성 및 취소 버튼 --%>
    <button type="submit">작성</button>
    <button type="reset">취소</button>
</form>

<%-- 관리자가 Notice.jsp로 이동할 수 있는 버튼 추가 --%>
<button onclick="location.href='Notice.jsp'">공지 목록</button>

<% } else { %>
    <!-- 관리자가 아니면 목록 창으로 이동 -->
    <script>
        window.location.href = 'Notice.jsp';
    </script>
<% } %>

</body>
</html>
