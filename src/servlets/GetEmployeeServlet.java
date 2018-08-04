package servlets;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.rowset.CachedRowSet;

import oracle.jdbc.rowset.OracleCachedRowSet;

@WebServlet("/getemployee")
public class GetEmployeeServlet extends HttpServlet {
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String id = request.getParameter("empid");
		PrintWriter out = response.getWriter();
		response.setContentType("application/json");
		try {
			CachedRowSet crs = new OracleCachedRowSet();
			crs.setUsername("hr");
			crs.setPassword("hr");
			crs.setUrl("jdbc:oracle:thin:@localhost:1521:xe");
			crs.setCommand("select first_name, salary from employees where employee_id = ?");
			crs.setString(1, id);
			crs.execute();
			if (crs.next())
				  out.println(String.format("{\"name\":\"%s\",\"salary\":%d}",
						    crs.getString("first_name"), 
						    crs.getInt("salary")));
			else
				  out.println("{\"error\":\"Employee Not Found\"}");
			
		} catch (Exception ex) {
			out.println("{\"error\":\"Couldn't get details due to error!\"}");
		}
	}

}
