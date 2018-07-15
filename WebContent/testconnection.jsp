<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         import="java.sql.*"
         pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Test Oracle Connection</title>
</head>
<body>

<%
   Class.forName("oracle.jdbc.driver.OracleDriver");
   Connection con = DriverManager.getConnection
		    ("jdbc:oracle:thin:@localhost:1521:xe","hr","hr");
   out.println("<h2>Connected To Oracle</h2>");   
%>

</body>
</html>