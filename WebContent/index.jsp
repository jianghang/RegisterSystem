<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>报道管理系统</title>
<style type="text/css">
	div#container{
		width: 1000px;
		margin: 0 auto;
	}
	div#header{
		width:800px;
		margin: 0 auto;
		text-align: center;
	}
	div#menu{
		width: 300px;
		height: 800px;
		float: left;
	}
	div#content{
		width:700px;
		height：800px;
		float: left;
	}
</style>

</head>
<!-- <frameset framespacing="0" border="0" frameborder="0" rows="64,*"
	marginwidth="0" marginheight="0">
	<frame name="banner" scrolling="no" noresize target="contents"
		src="banner.html">
	<frameset cols="160,*">
		<frame name="left" target="main" srolling="auto" src="left.jsp"
			marginwidth="10" marginheight="10">
		<frame name="main" scrolling="auto" marginwidth="0" marginheight="10"
			src="basicdata/regstatus.jsp">
	</frameset>
</frameset> -->
<body>
	<div id="container">
		<div id="header"><iframe width="800px" height="80px" src="banner.html" frameborder="0" border="0"></iframe></div>
		<div id="menu"><iframe target="main" width="300px" height="800px" marginheight="0" src="left.jsp" frameborder="0"></iframe></div>
		<div id="content"><iframe name="main" width="700px" height="800px" marginheight="0" src="basicdata/regstatus.jsp" frameborder="0"></iframe></div>
	</div>
</body>
</html>