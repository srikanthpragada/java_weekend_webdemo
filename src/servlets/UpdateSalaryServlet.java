package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/jdbc/updatesalary")
public class UpdateSalaryServlet extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		PrintWriter out = response.getWriter();
		response.setContentType("text/html");
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "hr", "hr");
			PreparedStatement ps = con.prepareStatement("update employees set salary = ? where employee_id = ?");

			ps.setString(1, request.getParameter("salary"));
			ps.setString(2, request.getParameter("empid"));

			int count = ps.executeUpdate();

			if (count == 1)
				out.println("<h2>Update Salary Successfully!</h2>");
			else
				out.println("<h2>Employee Id Not Found!</h2>");
			con.close();
		} catch (Exception ex) {
			out.println("<h2>Sorry! Could not process updation due to some error!</h2>");
		}

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
