<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"
	import="java.sql.*,javax.sql.rowset.*,oracle.jdbc.rowset.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Employees By Dept</title>
</head>
<body>
     <% 
      String jobid = request.getParameter("jobid");
     %>
	<h1>Employees By Job [<%=jobid%>]</h1>

	<%

		OracleCachedRowSet crs = new OracleCachedRowSet();
		crs.setUsername("hr");
		crs.setPassword("hr");
		crs.setUrl("jdbc:oracle:thin:@localhost:1521:xe");
		crs.setCommand("select * from employees where job_id = ?");
		crs.setString(1, jobid);
		crs.execute();
		if (!crs.next()) {
			out.println("<h2>Sorry! No employees found in Job!</h2>");
			crs.close();
			return;
		}
		crs.beforeFirst(); // take pointer to before first row
	%>
	<p />
	<table width="100%" border="1">
		<tr style="background-color: red; color: white">
			<th>Employee Id</th>
			<th>First Name</th>
			<th>Salary</th>
			<th>Department</th>
			<th>Hire Date</th>
		</tr>
		<%
			while (crs.next()) {
		%>
		<tr>
			<td><%=crs.getString("employee_id")%></td>
			<td><%=crs.getString("first_name")%></td>
			<td style="text-align: right"><%=crs.getString("salary")%></td>
			<td><%=crs.getString("department_id")%></td>
			<td><%=crs.getString("hire_date")%></td>
		</tr>
		<%
			}
			crs.close();
		%>
		</table>
	
</body>
</html>