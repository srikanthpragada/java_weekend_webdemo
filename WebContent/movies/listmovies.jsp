<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>List Of Movies</title>
</head>
<body>
	<h1>List Of Movies</h1>
	<%
		// find out city of client through cookie
		String city = null;
		Cookie[] cookies = request.getCookies();
		if (cookies != null) {
			for (Cookie c : cookies) {
				if (c.getName().equals("city")) {
					city = c.getValue();
					break;
				}
			}
		}

		if (city == null)
			response.sendRedirect("selectcity.html");
	%>

	<h2>
		Movies in City [<%=city%>]
	</h2>
	
	<a href="selectcity.html">Change City</a>

</body>
</html>