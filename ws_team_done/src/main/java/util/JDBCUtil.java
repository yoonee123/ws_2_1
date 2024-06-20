package util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class JDBCUtil {		//JDBC 연결을 위한 자바 코드
	
	public Connection getConnection () throws Exception {	//MySQL 데이터베이스에 대한 연결을 설정
		final String driverName = "com.mysql.jdbc.Driver";
		final String url = "jdbc:mysql://localhost:3306/jyp";
		final String username = "root";
		final String password = "dongyang";
		
		Class.forName(driverName);
		
		final Connection connection = DriverManager.getConnection(url, username, password);
		
		return connection;
	}	
	
	public void closeConnection (ResultSet resultSet, PreparedStatement preparedStatement, Connection connection) throws Exception {	//각 객체를 닫는 매서드
		if (resultSet != null) {
			resultSet.close();
		}
		
		if (preparedStatement != null) {
			preparedStatement.close();
		}
		
		if (connection != null) {
			connection.close();
		}
		// 각각 null이 아닌지 확인
	}
		// getConnection에서 연결된걸 closeConnection로 닫음
}
