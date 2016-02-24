package com.hangjiang.tests;

import java.sql.Connection;

import org.junit.Test;

import com.hangjiang.db.DBConn;

public class TestDBConn {
	
	@Test
	public void TestConn(){
		Connection conn = DBConn.createDBConn();
		DBConn.closeDBConn(conn);
	}
}
