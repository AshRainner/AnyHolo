package com.anyholo.web.back;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import com.anyholo.db.DBController;
import com.anyholo.model.data.KirinukiUser;
import com.anyholo.model.data.KirinukiVideo;
import com.anyholo.model.data.KirinukiView;

@WebServlet("/Clip")
public class ClipBack extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");;
		response.setCharacterEncoding("UTF-8");
		DBController dbc = new DBController();
		int page = 1;
		String country="";
		if(request.getParameter("Page")!=null)
			page=Integer.parseInt(request.getParameter("Page"));
		if(request.getParameter("Country")!=null)	
			country=request.getParameter("Country");
		String keyword="";
		if(request.getParameter("Keyword")!=null)
			keyword = request.getParameter("Keyword");
		PrintWriter out = response.getWriter();	
		JSONArray jArray = new JSONArray();
		dbc.DBSelect(jArray,DBController.KIRINUKI_SELECT,country,keyword,page,1);
		List<KirinukiView> kirinuki = new ArrayList<KirinukiView>();
		for(int i=0;i<jArray.size();i++) {
			JSONObject obj = (JSONObject) jArray.get(i);
			kirinuki.add(new KirinukiView(
					new KirinukiUser(obj.get("userUrl").toString(),obj.get("channelName").toString()),
					new KirinukiVideo(obj.get("youtubeUrl").toString(),obj.get("videoTitle").toString(),
							obj.get("thumnailUrl").toString(),"",obj.get("uploadTime").toString(),"","")));
		}
		request.setAttribute("kirinukiList", kirinuki);
		request.setAttribute("Keyword", keyword);
		request.getRequestDispatcher("/WEB-INF/Clip.jsp").forward(request, response);
	}
}