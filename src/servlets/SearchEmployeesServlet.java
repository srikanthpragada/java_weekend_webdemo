package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.rowset.CachedRowSet;

import com.google.gson.Gson;

import hr.Employee;
import oracle.jdbc.rowset.OracleCachedRowSet;

@WebServlet("/searchemployee")
public class SearchEmployeesServlet extends HttpServlet {
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String name = request.getParameter("name");
		PrintWriter out = response.getWriter();
		response.setContentType("application/json");
		try {
			CachedRowSet crs = new OracleCachedRowSet();
			crs.setUsername("hr");
			crs.setPassword("hr");
			crs.setUrl("jdbc:oracle:thin:@localhost:1521:xe");
			crs.setCommand("select employee_id, first_name, job_title, salary from employees natural join jobs where upper(first_name) like ?");
			crs.setString(1, "%" + name.toUpperCase() + "%");
			crs.execute();
			ArrayList<Employee> emps = new ArrayList<>();
			while(crs.next()) {
				Employee e = new Employee();
				e.setId( crs.getInt("employee_id"));
				e.setSalary( crs.getInt("salary"));
				e.setName( crs.getString("first_name"));
				e.setJob( crs.getString("job_title"));
				emps.add(e);
			}
			
			Gson gson = new Gson();
			out.println(gson.toJson(emps));
			
		} catch (Exception ex) {
			out.println("{\"error\":\"Couldn't get details due to error!\"}");
		}
	}

}
