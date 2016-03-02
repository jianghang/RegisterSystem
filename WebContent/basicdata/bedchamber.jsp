<%@page import="com.sun.org.apache.regexp.internal.REUtil"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="com.hangjiang.db.DBConn"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%Connection conn = DBConn.createDBConn(); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		String action = request.getParameter("action");
		String bedchambername = request.getParameter("bedchambername");
		if(bedchambername != null && bedchambername.length() > 0){
			bedchambername = new String(bedchambername.getBytes("ISO-8859-1"),"UTF-8");
			
			if("add".equals(action)){
				String sqlSelect = "select * from bedchamber where BedchamberName=?";
				PreparedStatement psSelect = conn.prepareStatement(sqlSelect);
				psSelect.setString(1, bedchambername);
				ResultSet rs = psSelect.executeQuery();
				if(!rs.next()){
					String sqlInsert = "insert into bedchamber(BedchamberName) values (?)";
					PreparedStatement psInsert = conn.prepareStatement(sqlInsert);
					psInsert.setString(1, bedchambername);
					psInsert.executeUpdate();
				}
			}
		}
			
		String bedchamberid = request.getParameter("bedchamberid");
		if(bedchamberid != null && bedchamberid.length() > 0){
			bedchamberid = new String(bedchamberid.getBytes("ISO-8859-1"),"UTF-8");
			int bedchamberidInt = Integer.parseInt(bedchamberid);
			
			if("del".equals(action)){
				String sqlDel = "delete from bedchamber where BedchamberId=?";
				PreparedStatement psDel = conn.prepareStatement(sqlDel);
				psDel.setInt(1, bedchamberidInt);
				psDel.executeUpdate();
			}
		}
	%>
	<form action="bedchamber.jsp" method="post">
		<table border="1" cellpadding="0" cellspacing="0"
			style="border-collapse: collapse;" bordercolor="#C0C0C0" width="800">
			<tr align="center">
				<td width="100%" bgcolor="#c0c0c0"><font color="#0000ff">录入宿舍数据</font>
				</td>
			</tr>
			<tr align="center">
				<td width="100%">请输入宿舍名称： 
				<input type="text" name="bedchambername"> 
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
				color="#0000ff">已有宿舍数据</font></td>
		</tr>
		<tr>
			<td width="20%" align="center">序号</td>
			<td width="60%" align="center">宿舍名称</td>
			<td width="20%" align="center">操作</td>
		</tr>
		
		<%
			String sqlSelect = "select * from bedchamber";
			Statement st = conn.createStatement();
			ResultSet rs = st.executeQuery(sqlSelect);
			int i = 0;
			while(rs.next()){
				i++;
		%>
		<tr>
			<td width="20%" align="center"><%=i %></td>
			<td width="60%" align="center"><%=rs.getString("BedchamberName") %></td>
			<td width="20%" align="center">
			<a href="bedchamber.jsp?action=del&bedchamberid=<%=rs.getInt("BedchamberId")%>">删除</a></td>
		</t>
		<%} %>
	</table>
</body>
<%DBConn.closeDBConn(conn); %>
</html>