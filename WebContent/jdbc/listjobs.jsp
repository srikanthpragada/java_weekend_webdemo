<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	import="java.sql.*,javax.sql.rowset.*,oracle.jdbc.rowset.*"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>List Of Jobs</title>
<style>
body {
	font-family: verdana;
	font-size: 12pt
}
</style>
</head>
<body>
	<h2>List Of Jobs</h2>
	<table width="100%" border="1">
		<tr style="background-color: red; color: white">
			<th>Job Id</th>
			<th>Job Title</th>
			<th>Min Salary</th>
			<th>Max Salary</th>
			<th></th>
		</tr> 
		<%
			CachedRowSet crs = new OracleCachedRowSet();
			crs.setUsername("hr");
			crs.setPassword("hr");
			crs.setUrl("jdbc:oracle:thin:@localhost:1521:xe");
			crs.setCommand("select * from jobs order by job_id");
			crs.execute();
			while (crs.next()) {
		%>
		<tr>
			<td><%=crs.getString(1)%></td>
			<td><%=crs.getString(2)%></td>
			<td style="text-align:right"><%=crs.getString(3)%></td>
			<td style="text-align:right"><%=crs.getString(4)%></td>
			<td>
			   <a href="empbyjob.jsp?jobid=<%=crs.getString(1)%>">Employees</a>
			</td>
		</tr>
		<%
			}
			crs.close();
		%>
	</table>
</body>
</html>