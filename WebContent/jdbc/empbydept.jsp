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
	<h1>Employees By Department</h1>
	<form action="empbydept.jsp">
		Department Id <input type="number" required name="deptid"
			value="${param.deptid}" /> <input type="submit" value="Employees" />
	</form>

	<%
		// read parameter and if not found stop
		String deptid = request.getParameter("deptid");
		if (deptid == null)
			return; // stop JSP here

		CachedRowSet crs = new OracleCachedRowSet();
		crs.setUsername("hr");
		crs.setPassword("hr");
		crs.setUrl("jdbc:oracle:thin:@localhost:1521:xe");
		crs.setCommand("select * from employees where department_id = ?");
		crs.setString(1, deptid);
		crs.execute();
		if (!crs.next()) {
			out.println("<h2>Sorry! No employees found in department!</h2>");
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
			<th>Job</th>
			<th>Hire Date</th>
		</tr>
		<%
			while (crs.next()) {
		%>
		<tr>
			<td><%=crs.getString("employee_id")%></td>
			<td><%=crs.getString("first_name")%></td>
			<td style="text-align: right"><%=crs.getString("salary")%></td>
			<td><%=crs.getString("job_id")%></td>
			<td><%=crs.getString("hire_date")%></td>
		</tr>
		<%
			}
			crs.close();
		%>
		</table>
	
</body>
</html>