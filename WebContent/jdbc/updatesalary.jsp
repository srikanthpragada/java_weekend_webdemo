<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	import="java.sql.*" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Update Salary</title>
</head>
<body>
   <h2>
	<%
	try {
		Class.forName("oracle.jdbc.driver.OracleDriver");
		Connection con = DriverManager.getConnection
				 ("jdbc:oracle:thin:@localhost:1521:xe", "hr", "hr");
		PreparedStatement ps = con.prepareStatement
				 ("update employees set salary = ? where employee_id = ?");

		ps.setString(1, request.getParameter("salary"));
		ps.setString(2, request.getParameter("empid"));

		int count = ps.executeUpdate();

		if (count == 1)
			out.println("Update Salary Successfully!");
		else
			out.println("Employee Id Not Found!");
		con.close();
	}
	catch(Exception ex) {
		out.println("Sorry! Could not process updation due to some error!");
	}
	%>
  </h2>
</body>
</html>