package com.anyholo.web.back;

import java.io.IOException;
import java.io.PrintWriter;
import java.security.MessageDigest;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.anyholo.db.DBController;
@WebServlet("/PWReset_Back")
public class PWReset_Back extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");;
		response.setCharacterEncoding("UTF-8");
		String name = request.getParameter("name");
		String id = request.getParameter("id");
		String phone = request.getParameter("phone");
		String pw = getSHA256(request.getParameter("pw"));
		DBController dbc = new DBController();
		PrintWriter out = response.getWriter();
		try {
			dbc.ResetPW(id, pw, phone, name);
			out.println("<script>");
			out.println("alert('변경 완료 다시 로그인 해주시길 바랍니다.'); location.href='/Main';");
			out.println("</script>");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			out.println("<script>");
			out.println("alert('오류 다시 입력해주세요');");
			out.println("history.back()");
			out.println("</script>");
		}
	}
	public static String getSHA256(String data) {
		String SHA = "";
		try {
			MessageDigest sh = MessageDigest.getInstance("SHA-256");
			sh.update(data.getBytes());
			byte byteData[] = sh.digest();
			StringBuffer sb = new StringBuffer();
			for (int i = 0; i < byteData.length; i++) {
				sb.append(Integer.toString((byteData[i] & 0xff) + 0x100, 16).substring(1));
			}
			SHA = sb.toString();

		} catch (Exception e) {
			e.printStackTrace();
			SHA = null;
		}
		return SHA;
	}
}
