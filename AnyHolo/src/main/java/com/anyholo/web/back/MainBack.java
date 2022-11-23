package com.anyholo.web.back;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.LinkedHashSet;
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
import com.anyholo.model.data.Member;
import com.anyholo.model.data.MemberOnAir;
import com.anyholo.model.data.MemberView;

@WebServlet("/Main")
public class MainBack extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");;
		response.setCharacterEncoding("UTF-8");
		DBController dbc = new DBController();
		PrintWriter out = response.getWriter();	
		JSONObject jObject = new JSONObject();
		JSONArray jArray = new JSONArray();
		dbc.DBSelect(jArray,DBController.MEMBER_SELECT,"","",1,1);
		List<MemberView> memberList = new ArrayList<MemberView>();
		for(int i=0;i<jArray.size();i++) {
			JSONObject obj = (JSONObject) jArray.get(i);
			memberList.add(new MemberView(new Member(0, obj.get("channelId").toString(), null, null, obj.get("country").toString(), obj.get("searchName").toString(), obj.get("memberName").toString(), null),
					new MemberOnAir(0, obj.get("onAir").toString(), obj.get("onAirTitle").toString(), obj.get("onAirThumnailsUrl").toString(), obj.get("onAirVideoUrl").toString())));
		}
		request.setAttribute("MemberList", memberList);
		request.getRequestDispatcher("/WEB-INF/Main.jsp").forward(request, response);
	}
}