<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>방명록 작성</title>
</head>
<body>
    <h1>방명록 작성</h1>
    <form action="addMessage.jsp" method="post">
        <br>
        <label for="message">작성</label>
        <textarea id="message" name="방명록" required></textarea>
        <br>
        <input type="submit" value="작성완료">
    </form>
    <%
        if ("POST".equalsIgnoreCase(request.getMethod())) {
            String name = request.getParameter("id");
            String message = request.getParameter("pw");

            if (name != null && message != null && !name.isEmpty() && !message.isEmpty()) {
                String jdbcUrl = "jdbc:mysql://localhost:3307/jyp";
                String jdbcUser = "root";
                String jdbcPassword = "dongyang";
                Connection connection = null;
                PreparedStatement statement = null;

                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    connection = DriverManager.getConnection(jdbcUrl, jdbcUser, jdbcPassword);
                    String sql = "INSERT INTO guestbook (name, message) VALUES (?, ?)";
                    statement = connection.prepareStatement(sql);
                    statement.setString(1, name);
                    statement.setString(2, message);
                    statement.executeUpdate();
                    response.sendRedirect("index.jsp");
                } catch (Exception e) {
                    out.println("<p>Error: " + e.getMessage() + "</p>");
                } finally {
                    try { if (statement != null) statement.close(); } catch (SQLException e) { }
                    try { if (connection != null) connection.close(); } catch (SQLException e) { }
                }
            } else {
                out.println("<p>방명록이 작성되지 않았습니다</p>");
            }
        }
    %>
</body>
</html>
