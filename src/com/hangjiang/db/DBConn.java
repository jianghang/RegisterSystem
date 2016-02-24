package com.hangjiang.db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
public class DBConn {
	
	private static final String URL="jdbc:mysql://127.0.0.1:3306/registersystem";
	private static final String USER="root";
	private static final String PASSWORD="root";
	
	public static Connection createDBConn(){
		try {
			Class.forName("com.mysql.jdbc.Driver");
			Connection conn = DriverManager.getConnection(URL,USER,PASSWORD);
			
			return conn;
		} catch (Exception e) {
			e.printStackTrace();
			
			return null;
		}
	}
	
	public static void closeDBConn(Connection conn){
		try {
			conn.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
}
