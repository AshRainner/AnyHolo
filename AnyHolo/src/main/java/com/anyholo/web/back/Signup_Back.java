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
@WebServlet("/Signup_Back")
public class Signup_Back extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");;
		response.setCharacterEncoding("UTF-8");
		DBController dbc = new DBController();
		//get 방식으로 id pw phone name을 받음
		String id = request.getParameter("inputID");
		String pw = getSHA256(request.getParameter("inputPassword"));
		//받은 pw받은 sha256해시함수로 암호화 한다.
		String phone = request.getParameter("inputTel1")+request.getParameter("inputTel2")+request.getParameter("inputTel3");
		String name = request.getParameter("name");
		PrintWriter out = response.getWriter();
		try {
			dbc.UserInsert(id,pw,phone,name);
			out.println("<script>");
			out.println("alert('회원가입성공'); location.href='/Main';");
			out.println("</script>");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			out.println("<script>");
			out.println("alert('이미 있는 아이디입니다.'); location.href='/Signup';");
			out.println("</script>");
		}
	}
	public static String getSHA256(String data) {
		String SHA = "";
		try {
			MessageDigest sh = MessageDigest.getInstance("SHA-256");//암호화 sha256으로 하기
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
		return SHA;//암호화한 pw를 반환
	}
}
