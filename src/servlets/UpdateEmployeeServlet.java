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

@WebServlet("/updateemployee")
public class UpdateEmployeeServlet extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		PrintWriter out = response.getWriter();
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "hr", "hr");
			PreparedStatement ps = con.prepareStatement
					("update employees set first_name = ? , salary = ? where employee_id = ?");

			ps.setString(1, request.getParameter("name"));
			ps.setString(2, request.getParameter("salary"));
			ps.setString(3, request.getParameter("id"));

			int count = ps.executeUpdate();

			if (count == 1)
				out.println("Update Successfully!");
			else
				out.println("Employee Id Not Found!");
			con.close();
		} catch (Exception ex) {
			out.println("Sorry! Could not process updation due to some error!");
		}
	}
}
