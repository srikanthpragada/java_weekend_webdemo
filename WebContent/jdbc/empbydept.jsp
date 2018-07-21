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
	<%
	String deptid = request.getParameter("deptid");
	%>
	<form action="empbydept.jsp">
		Department Id 
		<select name="deptid" onchange="submit()">
		  <%
		    CachedRowSet crs = new OracleCachedRowSet();
			crs.setUsername("hr");
			crs.setPassword("hr");
			crs.setUrl("jdbc:oracle:thin:@localhost:1521:xe");
			crs.setCommand("select department_id, department_name from departments order by 2");
			crs.execute();
			while(crs.next()) {
				if (deptid != null && deptid.equals(crs.getString(1)))
					out.println(String.format("<option selected value=%d>%s</option>", 
							  crs.getInt(1), crs.getString(2)));
				else
				    out.println(String.format("<option value=%d>%s</option>", 
						  crs.getInt(1), crs.getString(2)));
			}
            crs.close();		  
		  %>
		</select> 
 	    <input type="submit" value="Employees" />
	</form>

	<%
		// read parameter and if not found stop
		if (deptid == null)
			return; // stop JSP here

		crs = new OracleCachedRowSet();
		crs.setUsername("hr");
		crs.setPassword("hr");
		crs.setUrl("jdbc:oracle:thin:@localhost:1521:xe");
		crs.setCommand("select employee_id, first_name,salary, job_title, to_char(hire_date,'dd-mon-yyyy') hire_date from employees join jobs using(job_id) where department_id = ?");
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
			<td><%=crs.getString("job_title")%></td>
			<td><%=crs.getString("hire_date")%></td>
		</tr>
		<%
			}
			crs.close();
		%>
		</table>
	
</body>
</html>