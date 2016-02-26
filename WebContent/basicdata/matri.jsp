<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form action="matri.jsp" method="post">
		<table border="1" cellpadding="0" cellspacing="0"
			style="border-collapse: collapse;" bordercolor="#c0c0c0" width="600">
			<tr>
				<td width="100%" bgcolor="#c0c0c0">
				<font color="#0000ff">录入录取学生名册</font>
				</td>
			</tr>
			<tr>
				<td width="100%" align="left">
				请输入学生姓名：<input type="text" name="studentname">
				请选取录取专业：
				<select name="specialityid">
					<option value="">==请选择==</option>
					<option value=""></option>
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
			style="border-collapse: collapse;" bordercolor="#c0c0c0" width="600">
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
				<select name="specialityid">
					<option value="">==请选择==</option>
					<option value=""></option>
				</select>
				<input type="hidden" name="action" value="select">
				<input type="submit" value="提交">
				</td>
			</tr>
			<tr>
				<td align="center" colspan="5">
				<font color="#0000ff">
					<a href="">首页</a>&nbsp;
					<a href="">上一页</a>&nbsp;
					<a href="">下一页</a>&nbsp;
					<a href="">尾页</a>&nbsp;
					共<%=1 %>条记录，共<%=1 %>页，当前第<%=1 %>页
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
			<tr>
				<td align="center">1</td>
				<td align="center">张三</td>
				<td align="center">通信工程</td>
				<td align="center">205612165</td>
				<td align="center"><a href="">删除</a></td>
			</tr>
		</table>
	</form>
</body>
</html>