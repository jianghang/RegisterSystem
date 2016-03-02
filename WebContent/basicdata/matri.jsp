<%@page import="com.hangjiang.db.DBConn"%>
<%@page import="java.sql.*"%>
<%@page import="java.sql.Statement"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%Connection conn = DBConn.createDBConn(); %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	String action = request.getParameter("action");
	String specialityid = request.getParameter("specialityid");
	String matrino = request.getParameter("matrino");
	String studentname = request.getParameter("studentname");
	String currentpage = request.getParameter("currentpage");
	System.out.println("action:" + action + " currentpage: " + currentpage);
	
	if(studentname != null && !studentname.equals("")){
		studentname = new String(studentname.getBytes("ISO-8859-1"),"UTF-8");
	}
	
	if("add".equals(action)){
		String sql = "select * from student where MatriNo=? and StudentName=? and SpecialityId=?";
		PreparedStatement psSelect = conn.prepareStatement(sql);
		psSelect.setString(1, matrino);
		psSelect.setString(2, studentname);
		psSelect.setString(3, specialityid);
		ResultSet rs = psSelect.executeQuery();
		if(!rs.next()){
			sql = "insert into student(StudentName,SpecialityId,MatriNo) values (?,?,?)";
			PreparedStatement psInsert = conn.prepareStatement(sql);
			psInsert.setString(1, studentname);
			psInsert.setString(2, specialityid);
			psInsert.setString(3, matrino);
			psInsert.executeUpdate();
		}
	}
	
	if("del".equals(action)){
		String sql = "delete from student where MatriNo=?";
		PreparedStatement psdel = conn.prepareStatement(sql);
		psdel.setString(1, matrino);
		psdel.executeUpdate();
	}
	
	ResultSet rscount = null;
	int pagesize = 10;
	int pagecount = 0;
	int recount = 0;
	int currentpageint = 1;
	if(currentpage != null && !currentpage.equals("")){
		currentpageint = Integer.parseInt(currentpage);
	}
	if("select".equals(action)){
		if((studentname == null || studentname.length() == 0) && ((specialityid == null || specialityid.length() == 0))){
			String sqlCount = "select count(*) as recount from student";
			Statement state = conn.createStatement();
			ResultSet rsCount = state.executeQuery(sqlCount);
			rsCount.next();
			recount = rsCount.getInt("recount");
			String sql = "select student.StudentName as studentname,student.MatriNo as matrino,speciality.SpecialityName as specialityname" +
					" from student,speciality where student.SpecialityId=speciality.SpecialityId limit " + pagesize;
			
			if(recount % pagesize == 0){
				pagecount = recount / pagesize;
			}else{
				pagecount = (recount / pagesize) + 1;
			}
			
			if(currentpageint > 1 && pagecount > 1){
				sql = "select student.StudentName as studentname,student.MatriNo as matrino,speciality.SpecialityName as specialityname" +
				" from student,speciality where student.SpecialityId=speciality.SpecialityId limit " + ((currentpageint - 1) * pagesize) + "," 
				+ pagesize;
			}
			Statement st = conn.createStatement();
			rscount = st.executeQuery(sql);
		}else{
			int specialityidInt = 0;
			if(specialityid != null && specialityid.length() > 0){
				specialityidInt = Integer.parseInt(specialityid);
				System.out.println("specialityidInt: " + specialityidInt);
			}
			String sql = "select student.StudentName as studentname,student.MatriNo as matrino,speciality.SpecialityName as specialityname" +
					" from student,speciality";
			String sqlwhere = " where student.SpecialityId=speciality.SpecialityId";
			if(specialityidInt != 0){
				sqlwhere = sqlwhere + " and student.SpecialityId=? " + "and student.StudentName like ? ";
			}else{
				sqlwhere = sqlwhere + " and student.StudentName like ? ";
			}
			String sqlcount = "select count(*) as recount from student,speciality" + sqlwhere;
			PreparedStatement psCount = conn.prepareStatement(sqlcount);
			if(specialityidInt != 0){
				psCount.setInt(1, specialityidInt);
				psCount.setString(2, "%" + studentname + "%");
			}else{
				psCount.setString(1, "%" + studentname + "%");
			}
			ResultSet rs = psCount.executeQuery();
			rs.next();
			recount = rs.getInt("recount");
			if(recount % pagesize == 0){
				pagecount = recount / pagesize;
			}else{
				pagecount = (recount / pagesize) + 1; 
			}
			
			PreparedStatement psSelect = null;
			if(pagecount > 1 && currentpageint > 1){
				String sqlselect = sql + sqlwhere + "limit " + ((currentpageint - 1) * pagesize) + "," + pagesize;
				psSelect = conn.prepareStatement(sqlselect);
				if(specialityidInt != 0){
					psSelect.setInt(1, specialityidInt);
					psSelect.setString(2, "%" + studentname + "%");
				}else{
					psSelect.setString(1, "%" + studentname + "%");
				}
			}else{
				String sqlselect = sql + sqlwhere;
				psSelect = conn.prepareStatement(sqlselect);
				if(specialityidInt != 0){
					psSelect.setInt(1, specialityidInt);
					psSelect.setString(2, "%" + studentname + "%");
				}else{
					psSelect.setString(1, "%" + studentname + "%");
				}
			}
			rscount = psSelect.executeQuery();
		}
	}
%>
	<form action="matri.jsp" method="post">
		<table border="1" cellpadding="0" cellspacing="0"
			style="border-collapse: collapse;" bordercolor="#c0c0c0" width="800">
			<tr>
				<td width="100%" bgcolor="#c0c0c0">
				<font color="#0000ff">录入录取学生名册</font>
				</td>
			</tr>
			<tr>
				<td width="100%" align="left">
				请输入学生姓名：<input type="text" name="studentname">
				请选取录取专业：
				<%
					String sql = "select * from speciality";
					Statement state = conn.createStatement();
					ResultSet rs = state.executeQuery(sql);
				%>
				<select name="specialityid">
					<option value="">==请选择==</option>
					<%while(rs.next()){ %>
					<option value=<%=rs.getInt("SpecialityId") %>><%=rs.getString("SpecialityName") %></option>
					<%} %>
				</select><br/>
				请输入录取通知书号：<input type="text" name="matrino">
				<input type="hidden" name="action" value="add">
				<input type="submit" value="提交">
				</td>
			</tr>
		</table>
	</form>
	<br/>
	
	<form action="matri.jsp" method="post">
		<table border="1" cellspacing="0" cellpadding="0"
			style="border-collapse: collapse;" bordercolor="#c0c0c0" width="800">
			<tr>
				<td width="100%" bgcolor="#c0c0c0" colspan="5">
				<font color="#0000fff">查询已录入的学生名册</font>
				</td>
			</tr>
			<tr>
				<td width="100%" align="left" colspan="5">
				请输入学生姓名：
				<input type="text" name="studentname" >
				请选取录取专业：
				<%
					sql = "select * from speciality";
					rs.beforeFirst();
				%>
				<select name="specialityid">
					<option value="">==请选择==</option>
					<%while(rs.next()){ %>
					<option value="<%=rs.getInt("SpecialityId") %>"><%=rs.getString("SpecialityName") %></option>
					<%} %>
				</select>
				<input type="hidden" name="action" value="select">
				<input type="submit" value="查询">
				</td>
			</tr>
			<tr>
				<td align="center" colspan="5">
				<font color="#0000ff">
					<%if(pagecount > 1 && currentpageint > 1){ %>
						<a href="matri.jsp?currentpage=1&action=<%=action %>&specialityid=<%=specialityid %>&studentname=<%=studentname %>
						">首页</a>&nbsp;
						<a href="matri.jsp?currentpage=<%=currentpageint-1 %>&action=<%=action %>&specialityid=<%=specialityid %>
						&studentname=<%=studentname %>">上一页</a>&nbsp;
					<%}else{ %>
						<font color="#808080">首页</font>
						<font color="#808080">上一页</font>
					<%} %>
					<%if(pagecount > 1 && currentpageint < pagecount){ %>
						<a href="matri.jsp?currentpage=<%=currentpageint+1 %>&action=<%=action %>&specialityid=<%=specialityid %>
						&studentname=<%=studentname %>">下一页</a>&nbsp;
						<a href="matri.jsp?currentpage=<%=pagecount %>&action=<%=action %>&specialityid=<%=specialityid %>
						&studentname=<%=studentname %>">尾页</a>&nbsp;
					<%}else { %>
						<font color="#808080">下一页</font>
						<font color="#808080">尾页</font>
					<%} %>
					共<%=recount %>条记录，共<%=pagecount %>页，当前第<%=currentpageint %>页
				</font>
				</td>
			</tr>
			<tr bgcolor="#c0c0c0">
				<td align="center"><font color="#0000ff">序号</font></td>
				<td align="center"><font color="#0000ff">姓名</font></td>
				<td align="center"><font color="#0000ff">录取专业</font></td>
				<td align="center"><font color="#0000ff">录取通知书号</font></td>
				<td align="center"><font color="#0000ff">操作</font></td>
			</tr>
			<%
				int i = (currentpageint - 1) * pagesize;
				while(rscount != null && rscount.next()){ 
					i++;
			%>
			<tr>
				<td align="center"><%=i %></td>
				<td align="center"><%=rscount.getString("studentname") %></td>
				<td align="center"><%=rscount.getString("specialityname") %></td>
				<td align="center"><%=rscount.getString("matrino") %></td>
				<td align="center"><a href="matri.jsp?action=del&matrino=<%=rscount.getString("matrino") %>">删除</a></td>
			</tr>
			<%} %>
		</table>
	</form>
</body>
<%DBConn.closeDBConn(conn); %>
</html>