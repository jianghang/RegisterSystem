<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>登录</title>
</head>
<body>
<br/><br/><br/><br/>
<div align="center">
	<form action="login.jsp" method="post">
		<table border="1" cellpadding="0" cellspacing="0" 
			style="border-collapse: collapse;" bordercolor="#c0c0c0" width="300">
			<tr>
				<td width="100%" bgcolor="#c0c0c0" align="center">
				<font color="#0000ff">用户登录</font>
				</td>
			</tr>
			<tr>
				<td align="center">
				</td>
			</tr>
			<tr>
				<td>
					<table boder="1" align="center">
						<tr>
							<td>用户名：</td>
							<td><input type="text" name="adminusername"></td>
						</tr>
						<tr>
							<td>密码:</td>
							<td><input type="password" name="adminuserpassword"></td>
						</tr>
						<tr>
							<td colspan="2" align="right"><input type="submit" value="登录"></td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
	</form>
</div>
</body>
</html>