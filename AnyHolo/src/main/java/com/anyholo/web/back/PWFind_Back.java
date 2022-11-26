package com.anyholo.web.back;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.anyholo.db.DBController;
@WebServlet("/PWFind_Back")
public class PWFind_Back extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");;
		response.setCharacterEncoding("UTF-8");
		DBController dbc = new DBController();
		String id = request.getParameter("inputID");
		String phone = request.getParameter("inputTel")+request.getParameter("inputTel2")+request.getParameter("inputTel3");
		String name = request.getParameter("name");
		PrintWriter out = response.getWriter();
		try {
			dbc.FindPW(id,phone, name);
			out.println("<script>");
			out.println("location.href='/PWReset?id="+id+"&phone="+phone+"&name="+name+"';");
			out.println("</script>");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			out.println("<script>");
			out.println("alert('존재하지 않는 사용자입니다.');");
			out.println("history.back()");
			out.println("</script>");
		}
	}
}
