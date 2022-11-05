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
		int kPage = 1;
		String country=null;
		if(request.getParameter("KPage")!=null)
			kPage=Integer.parseInt(request.getParameter("KPage"));
		if(request.getParameter("Country")!=null)	
			country=request.getParameter("Country");
		String keyword="";
		if(request.getParameter("Keyword")!=null)
			keyword = request.getParameter("Keyword");
		PrintWriter out = response.getWriter();	
		JSONObject jObject = new JSONObject();
		JSONArray jArray = new JSONArray();
		System.out.println("country : "+country+" | 키워드 : "+keyword);
		
		DBController.DBSelect(jArray,DBController.KIRINUKI_SELECT,country,keyword,kPage);
		
		jObject.put("Kirinuki", jArray);
		out.print(jObject);
		out.flush();
	}
}
