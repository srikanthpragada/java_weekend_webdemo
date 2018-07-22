<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    import="java.util.*"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Add Language</title>
</head>
<body>
<%@include  file="header.html" %>
<h1>Languages</h1>
<form action="addlang.jsp">
Language <input type="text" name="lang"/>
<input type="submit" value="Add Lang" />
</form>
<%
   String lang = request.getParameter("lang");
   if(lang == null)
	   return;
   
   // Get langs from session
   TreeSet<String> langs = (TreeSet<String>) session.getAttribute("langs");
   if (langs == null) {
	   langs = new TreeSet<String>();
	   session.setAttribute("langs", langs);
   }
   langs.add(lang);
   
   // Print all langs
   for(String l : langs)
	    out.println(l + "<br/>");
   
%>
</body>
</html>