<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="com.hangjiang.db.DBConn"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%Connection conn = DBConn.createDBConn();%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		String action = request.getParameter("action");
		String classid = request.getParameter("classid");
		String classname = request.getParameter("classname");
		if(classname != null && classname.length() > 0){
			classname = new String(classname.getBytes("ISO-8859-1"),"UTF-8");
			if("add".equals(action)){
				String sqlSelect = "select * from classta where ClassName=?";
				PreparedStatement psSelect = conn.prepareStatement(sqlSelect);
				psSelect.setString(1, classname);
				ResultSet rsSelect = psSelect.executeQuery();
				if(!rsSelect.next()){
					String sqlInsert = "insert into classta(ClassName) values (?)";
					PreparedStatement psInsert = conn.prepareStatement(sqlInsert);
					psInsert.setString(1, classname);
					psInsert.executeUpdate();
				}
			}
		}
		
		if(classid != null && classid.length() > 0){
			classid = new String(classid.getBytes("ISO-8859-1"),"UTF-8");
			int classidInt = Integer.parseInt(classid);
			if("del".equals(action)){
				String sqlDel = "delete from classta where ClassId=?";
				PreparedStatement psDel = conn.prepareStatement(sqlDel);
				psDel.setInt(1, classidInt);
				psDel.executeUpdate();
			}
		}
		
	%>
	<form action="class.jsp" method="post">
		<table border="1" cellpadding="0" cellspacing="0"
			style="border-collapse: collapse;" bordercolor="#C0C0C0" width="800">
			<tr align="center">
				<td width="100%" bgcolor="#c0c0c0"><font color="#0000ff">录入班级数据</font>
				</td>
			</tr>
			<tr align="center">
				<td width="100%">请输入班级名称： 
				<input type="text" name="classname"> 
				<input type="hidden" name="action" value="add"> 
				<input type="submit" value="提交">
				</td>
			</tr>
		</table>
	</form>
	
	<table border="1" cellpadding="0" cellspacing="0"
		style="border-collapse: collapse;" bordercolor="#c0c0c0" width="800px">
		<tr>
			<td width="100%" bgcolor="#c0c0c0" align="center" colspan="3"><font
				color="#0000ff">已有班级数据</font></td>
		</tr>
		<tr>
			<td width="20%" align="center">序号</td>
			<td width="60%" align="center">班级名称</td>
			<td width="20%" align="center">操作</td>
		</tr>
		
		<%
			String sqlSelect = "select * from classta";
			Statement st = conn.createStatement();
			ResultSet rs = st.executeQuery(sqlSelect);
			int i = 0;
			while(rs.next()){
				i++;
		%>
		<tr>
			<td width="20%" align="center"><%=i %></td>
			<td width="60%" align="center"><%=rs.getString("ClassName") %></td>
			<td width="20%" align="center">
			<a href="class.jsp?action=del&classid=<%=rs.getInt("ClassId") %>">删除</a></td>
		</tr>
		<%} %>
	</table>
</body>
<%DBConn.closeDBConn(conn); %>
</html>