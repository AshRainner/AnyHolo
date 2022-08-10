package com.hololivefinder.db;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

@WebServlet("/dbcon")
public class AndroidConnection extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");;
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		JSONObject jObject = new JSONObject();
		JSONArray jArray = new JSONArray();
		JSONObject nameObject = new JSONObject();
		String jsonData=null;
		DBController.DBSelect(nameObject);
		jObject.put("Member", nameObject);
		jsonData = jObject.toString();
		out.print(jsonData);
	}
}