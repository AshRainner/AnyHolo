package com.anyholo.db;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

@WebServlet("/dbcon")
public class AndroidInitialValue extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");;
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		JSONObject jObject = new JSONObject();
		JSONArray jArray = new JSONArray();
		DBController.DBSelect(jArray,DBController.TWEET_SELECT,1);
		ArrayList<String> nokoriIds = new ArrayList<String>();
		for(int i=0;i<jArray.size();i++) {
			JSONObject j = (JSONObject) jArray.get(i);
			if(j.get("tweetType").equals("DEFAULT")) {
				
			}
			else
				nokoriIds.add(String.valueOf(j.get("nextTweetId")));
		}
		System.out.println(nokoriIds);
		for(int i = 0;i<nokoriIds.size();i++) {
			for(int j=0;j<jArray.size();j++) {
				JSONObject jObj = (JSONObject) jArray.get(j);
				if(nokoriIds.get(i).equals(jObj.get("tweetId"))) {
					nokoriIds.remove(i);
					i--;
					break;
				}
			}
		}
		System.out.println(nokoriIds);
		for(int i = 0;i<jArray.size();i++) {
			JSONObject j=(JSONObject)jArray.get(i);
			if(!(j.get("tweetType").equals("DEFAULT")))
				if(nokoriIds.contains(j.get("nextTweetId")))
					DBController.NextTweetSelect(j,String.valueOf(j.get("nextTweetId")));
		}
		jObject.put("Tweet", jArray);
		jArray = new JSONArray();
		DBController.DBSelect(jArray, DBController.KIRINUKI_SELECT,1);
		jObject.put("Kirinuki", jArray);
		jArray = new JSONArray();
		DBController.DBSelect(jArray,DBController.MEMBER_SELECT,1);
		jObject.put("Member", jArray);
		out.print(jObject);
		out.flush();
	}
}