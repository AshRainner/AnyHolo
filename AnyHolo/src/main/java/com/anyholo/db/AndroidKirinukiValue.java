package com.anyholo.db;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

@WebServlet("/dbcon/Kirinuki")
public class AndroidKirinukiValue extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");;
		response.setCharacterEncoding("UTF-8");
		int Kpage = 1;
		if(request.getParameter("KPage")!=null)
			Kpage=Integer.parseInt(request.getParameter("KPage"));
		PrintWriter out = response.getWriter();	
		JSONObject jObject = new JSONObject();
		JSONArray jArray = new JSONArray();
		DBController.DBSelect(jArray,DBController.KIRINUKI_SELECT,Kpage);
		jObject.put("Kirinuki", jArray);
		out.print(jObject);
		out.flush();
	}
}
