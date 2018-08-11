<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Search Employees</title>
</head>
<body>
	<form action="searchemployees.jsp">
		Name : <input type="text" name="empname" value="${param.empname}" />
		<input type="submit" value="Search" />
	</form>

	<%
		if (request.getParameter("empname") == null)
			return;
	%>

	<sql:setDataSource var="oracle"
		driver="oracle.jdbc.driver.OracleDriver"
		url="jdbc:oracle:thin:@localhost:1521:XE" user="hr" password="hr" />

	<sql:query dataSource="${oracle}" var="emplist">
         select first_name ||  ' ' || last_name fullname,
                job_title, department_name,salary, 
                to_char(hire_date,'dd-mm-yyyy') hire_date
                from employees natural join jobs
                join departments using (department_id) 
                where upper(first_name) like '%' || upper(?) || '%'
         <sql:param value='${param.empname}' />
	</sql:query>
	<p />
	
	<c:if test="${emplist.rowCount == 0}">
	  <h3>Sorry! No Employees Found!</h3>
	</c:if>
	
	<c:if test="${emplist.rowCount > 0}">
		<table width="100%" border="1">
			<tr>
				<th>Name</th>
				<th>Job</th>
				<th>Department</th>
				<th>Salary</th>
				<th>Hire Date</th>
			</tr>

			<c:forEach var="emp" items="${emplist.rows}">
				<tr>
					<td>${emp.fullname}</td>
					<td>${emp.job_title}</td>
					<td>${emp.department_name}</td>
					<td>${emp.salary}</td>
					<td>${emp.hire_date}</td>
				</tr>
			</c:forEach>
		</table>
	</c:if>
</body>
</html>


