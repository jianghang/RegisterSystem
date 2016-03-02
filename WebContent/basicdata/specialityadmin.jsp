<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.hangjiang.db.DBConn"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	Connection conn = DBConn.createDBConn();
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		String action = request.getParameter("action");
		String specialityname = request.getParameter("specialityname");
		String specialityid = request.getParameter("specialityid");

		if (specialityname != null && !specialityname.equals("")) {
			specialityname = new String(specialityname.getBytes("ISO-8859-1"),"UTF-8");
			System.out.println("specialityname:" + specialityname);
			if ("add".equals(action)) {
				String sql = "select * from speciality where SpecialityName=?";
				PreparedStatement psSelect = conn.prepareStatement(sql);
				psSelect.setString(1, specialityname);
				ResultSet rs = psSelect.executeQuery();
				if (!rs.next()) {
					sql = "insert into Speciality(SpecialityName) values (?)";
					PreparedStatement psInsert = conn.prepareStatement(sql);
					psInsert.setString(1, specialityname);
					psInsert.executeUpdate();
				}
			}

		}
		if ("del".equals(action)) {
			String sql = "delete from Speciality where SpecialityId=?";
			PreparedStatement psDelete = conn.prepareStatement(sql);
			if (specialityid != null && specialityid.length() > 0) {
				int idInt = Integer.parseInt(specialityid);
				psDelete.setInt(1, idInt);
				psDelete.executeUpdate();
			}
		}
	%>
	<form action="specialityadmin.jsp" method="post">
		<table border="1" cellpadding="0" cellspacing="0"
			style="border-collapse: collapse;" bordercolor="#C0C0C0" width="800">
			<tr align="center">
				<td width="100%" bgcolor="#c0c0c0"><font color="#0000ff">录入专业数据</font>
				</td>
			</tr>
			<tr align="center">
				<td width="100%">请输入专业名称： <input type="text"
					name="specialityname"> <input type="hidden" name="action"
					value="add"> <input type="submit" value="提交">
				</td>
			</tr>
		</table>
	</form>

	<table border="1" cellpadding="0" cellspacing="0"
		style="border-collapse: collapse;" bordercolor="#c0c0c0" width="800px">
		<tr>
			<td width="100%" bgcolor="#c0c0c0" align="center" colspan="3"><font
				color="#0000ff">已有专业数据</font></td>
		</tr>
		<tr>
			<td width="20%" align="center">序号</td>
			<td width="60%" align="center">专业名称</td>
			<td width="20%" align="center">操作</td>
		</tr>
		<%
			String sql = "select * from Speciality";
			Statement state = conn.createStatement();
			ResultSet rs = state.executeQuery(sql);
			int i = 0;
			while (rs.next()) {
				i++;
		%>
		<tr>
			<td width="20%" align="center"><%=i%></td>
			<td width="60%" align="center"><%=rs.getString("SpecialityName")%></td>
			<td width="20%" align="center"><a
				href="specialityadmin.jsp?action=del&specialityid=<%=rs.getInt("SpecialityId")%>">删除</a></td>
		</tr>
		<%
			}
		%>
	</table>
</body>
</html>
<%
	DBConn.closeDBConn(conn);
%>