<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="com.hangjiang.db.DBConn"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Statement"%>
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
		ResultSet rsCount = null;
		int recount = 0;
		int pagesize = 10;
		int pagecount = 1;
		int currentpageInt = 1;
		String action = request.getParameter("action");
		if(action == null){
			action = "";
		}
		
		String studentname = request.getParameter("studentname");
		if(studentname != null && studentname.length() > 0){
			studentname = new String(studentname.getBytes("ISO-8859-1"),"UTF-8");
		}else{
			action = "";
		}
		
		String currentpage = request.getParameter("currentpage");
		if(currentpage != null && currentpage.length() > 0){
			currentpageInt = Integer.parseInt(currentpage);
		}
		
		System.out.println("action: " + action);
		
		if(action == null || action.equals("")){
			System.out.println("action: " + action + " currentpageInt: " + currentpageInt);
			
			String sqlCount = "select count(*) as recount from student";
			
			String sqlSelect = "select student.StudentName as studentname,speciality.SpecialityName as specialityname,classta.ClassName as classname," +
				"bedchamber.BedchamberName as bedchambername,student.MatriNo as matrino,student.PayAmount as payamount,student.PayOk as payok" +
				" from student,speciality,classta,bedchamber where student.SpecialityId=speciality.SpecialityId and student.ClassId=classta.ClassId" +
				" and student.BedchamberId=bedchamber.BedchamberId limit " + (currentpageInt - 1) * pagesize + "," + pagesize;
			
			sqlSelect = "select student.StudentName as studentname,student.MatriNo as matrino,speciality.SpecialityName as specialityname," +
				"classta.ClassName as classname,student.PayOk as payok,student.PayAmount as payamount,bedchamber.BedchamberName as bedchambername" +
				" from student left join speciality on student.SpecialityId=speciality.SpecialityId " +
				"left join classta on student.ClassId=classta.ClassId " +
				"left join bedchamber on student.BedchamberId=bedchamber.BedchamberId limit " + (currentpageInt - 1) * pagesize + "," + pagesize;
			
			Statement st = conn.createStatement();
			ResultSet rs = st.executeQuery(sqlCount);
			rs.next();
			recount = rs.getInt("recount");
			if(recount % pagesize == 0){
				pagecount = recount / pagesize;
			}else{
				pagecount = (recount / pagesize) + 1;
			}
			
			Statement stSelect = conn.createStatement();
			rsCount = stSelect.executeQuery(sqlSelect);
		}
		
		if("select".equals(action)){
			String sqlCount = "select count(*) as recount from student where StudentName like ?";
			PreparedStatement psCount = conn.prepareStatement(sqlCount);
			psCount.setString(1, "%" + studentname + "%");
			ResultSet rs = psCount.executeQuery();
			rs.next();
			recount = rs.getInt("recount");
			
			String sqlSelect = "select student.StudentName as studentname,student.MatriNo as matrino,speciality.SpecialityName as specialityname," +
					"classta.ClassName as classname,student.PayOk as payok,student.PayAmount as payamount,bedchamber.BedchamberName as bedchambername" +
					" from student left join speciality on student.SpecialityId=speciality.SpecialityId " +
					"left join classta on student.ClassId=classta.ClassId " +
					"left join bedchamber on student.BedchamberId=bedchamber.BedchamberId where student.StudentName like ? ";
			PreparedStatement psSelect = conn.prepareStatement(sqlSelect);
			psSelect.setString(1, "%" + studentname + "%");
			rsCount = psSelect.executeQuery();
		}
	%>
	<form action="regstatus.jsp" method="post">
		<table border="1" cellpadding="0" cellspacing="0"
			style="border-collapse: collapse;" bordercolor="#C0C0C0" width="800">
			<tr>
				<td width="100%" bgcolor="#c0c0c0"><font color="#0000ff">输入要查询状态的条件</font>
				</td>
			</tr>
			<tr align="center">
				<td width="100%">请输入姓名： 
				<input type="text" name="studentname"> 
				<input type="hidden" name="action" value="select"> 
				<input type="submit" value="查询">&nbsp;
				</td>
			</tr>
		</table>
	</form>
	
	<table border="1" cellspacing="0" cellpadding="0"
			style="border-collapse: collapse;" bordercolor="#c0c0c0" width="800">
			<tr>
				<td width="100%" bgcolor="#c0c0c0" colspan="8">
				<font color="#0000fff">已有的学生报到数据</font>
				</td>
			</tr>
			<tr>
				<td align="center" colspan="8">
				<font color="#0000ff">
					<%if(pagecount > 1 && currentpageInt > 1){ %>
						<a href="regstatus.jsp?action=<%=action %>&currentpage=<%=1 %>">首页</a>&nbsp;
						<a href="regstatus.jsp?action=<%=action %>&currentpage=<%=currentpageInt - 1%>">上一页</a>&nbsp;
					<%}else{ %>
						<font color="#808080">首页</font>
						<font color="#808080">上一页</font>
					<%} %>
					<%if(pagecount > 1 && currentpageInt < pagecount){ %>
						<a href="regstatus.jsp?action=<%=action %>&currentpage=<%=currentpageInt + 1%>">下一页</a>&nbsp;
						<a href="regstatus.jsp?action=<%=action %>&currentpage=<%=pagecount %>">尾页</a>&nbsp;
					<%}else { %>
						<font color="#808080">下一页</font>
						<font color="#808080">尾页</font>
					<%} %>
					共<%=recount %>条记录，共<%=pagecount %>页，当前第<%=currentpageInt %>页
				</font>
				</td>
			</tr>
			<tr bgcolor="#c0c0c0">
				<td align="center"><font color="#0000ff">序号</font></td>
				<td align="center"><font color="#0000ff">姓名</font></td>
				<td align="center"><font color="#0000ff">录取通知书号</font></td>
				<td align="center"><font color="#0000ff">录取专业</font></td>
				<td align="center"><font color="#0000ff">所在班级</font></td>
				<td align="center"><font color="#0000ff">是否缴费</font>
				<td align="center"><font color="#0000ff">已交学费</font>
				<td align="center"><font color="#0000ff">所在宿舍</font>
			</tr>
			<%
				int i = (currentpageInt - 1) * pagesize;
				while(rsCount != null && rsCount.next()){
					i++;
					String classname = rsCount.getString("classname");
					classname = (classname == null ? "尚未分班" : classname);
					
					String payok = rsCount.getString("payok");
					int payokInt = Integer.parseInt(payok);
					payok = (payokInt == 0 ? "未交清" : "已交清");
					
					String bedchambername = rsCount.getString("bedchambername");
					bedchambername = (bedchambername == null ? "尚未分配宿舍" : bedchambername);
			%>
			<tr>
				<td align="center"><%=i %></td>
				<td align="center"><%=rsCount.getString("studentname") %></td>
				<td align="center"><%=rsCount.getString("matrino") %></td>
				<td align="center"><%=rsCount.getString("specialityname") %></td>
				<td align="center"><%=classname %></td>
				<td align="center"><%=payok %></td>
				<td align="center"><%=rsCount.getString("payamount") %></td>
				<td align="center"><%=bedchambername %></td>
			</tr>
			<%}%>
		</table>
</body>
<%DBConn.closeDBConn(conn); %>
</html>