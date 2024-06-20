<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.io.*, jakarta.servlet.http.*, jakarta.servlet.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>앨범 페이지</title>
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
    <!-- 사진 업로드 폼 -->
    <form id="uploadForm" action="Album_page.jsp" method="post" enctype="multipart/form-data">
        <input type="file" name="photo" accept="image/*">
        <button type="submit">사진 업로드</button>
    </form>
    <br><br>
<%
    // 업로드 폼이 제출된 경우
    if (request.getMethod().equalsIgnoreCase("POST")) {
        // 업로드된 파일을 받아옴
        Part filePart = request.getPart("photo");
        String fileName = filePart.getSubmittedFileName();
        // 업로드 경로 설정
        String uploadPath = getServletContext().getRealPath("") + File.separator + "uploads";
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) uploadDir.mkdir();

        // 파일을 업로드 경로에 저장
        String filePath = uploadPath + File.separator + fileName;
        filePart.write(filePath);

        // 데이터베이스에 파일 경로를 저장
        conn = DriverManager.getConnection(url, username, password);
        String insertSql = "INSERT INTO photos (path) VALUES (?)";
        PreparedStatement insertStmt = conn.prepareStatement(insertSql);
        insertStmt.setString(1, "uploads/" + fileName);
        insertStmt.executeUpdate();
        insertStmt.close();
        conn.close();

        out.println("<h2>사진이 성공적으로 업로드되었습니다.</h2>");
    }
%>
<% } else { %>
    <!-- 관리자가 아니면 앨범 보기 페이지로 리다이렉트 -->
    <script>
        window.location.href = 'Album_list.jsp';
    </script>
<% } %>

<!-- 업로드된 사진 표시 -->
<div id="photoDisplay">
    <%
        // 데이터베이스에서 업로드된 사진 경로를 조회
        String photoSql = "SELECT * FROM photos";
        Connection photoConn = DriverManager.getConnection(url, username, password);
        Statement photoStmt = photoConn.createStatement();
        ResultSet photoRs = photoStmt.executeQuery(photoSql);
        
        // 조회된 사진 경로를 통해 사진을 표시
        while (photoRs.next()) {
            String photoPath = photoRs.getString("path");
            out.println("<img src='" + photoPath + "' style='max-width: 300px;'><br>");
        }
        
        photoRs.close();
        photoStmt.close();
        photoConn.close();
    %>
    <!-- 앨범 보기 페이지로 이동하는 링크 -->
    <a href="Album_list.jsp">앨범 페이지로 이동</a>
</div>
</body>
</html>
