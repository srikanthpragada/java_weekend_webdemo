<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@taglib  uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib  uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Update Salary</title>
</head>
<body>

<sql:setDataSource 
  var="oracle" 
  driver="oracle.jdbc.driver.OracleDriver"
  url="jdbc:oracle:thin:@localhost:1521:XE"
  user="hr" 
  password="hr" />

<sql:update  dataSource="${oracle}"  var="count">
      update employees set salary = ?  where employee_id = ? 
      <sql:param value="${param.salary}"></sql:param>
      <sql:param value="${param.empid}"></sql:param>
</sql:update>

<c:if test="${count == 1}">
   Updated Successfully
</c:if>
   



</body>
</html>