<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>USD</title>
</head>
<body> 

<%
   // java code 
   String amount = request.getParameter("amount");
   double inr = Double.parseDouble(amount);
   double usd = inr / 68;
   out.println("<h2> USD = " + usd  + "</h2>");
%>

</body>
</html>