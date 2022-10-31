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

@WebServlet("/dbcon/Tweet")
public class AndroidTweetValue extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");;
		response.setCharacterEncoding("UTF-8");
		int Tpage = 1;
		if(request.getParameter("TPage")!=null)
			Tpage=Integer.parseInt(request.getParameter("TPage"));
		int TweetId = 0;
		if(request.getParameter("TweetID")!=null) {
			TweetId = Integer.parseInt(request.getParameter("TweetID"));
		}
		PrintWriter out = response.getWriter();
		JSONObject jObject = new JSONObject();
		JSONArray jArray = new JSONArray();
		if(TweetId==0)
			DBController.DBSelect(jArray,DBController.TWEET_SELECT,Tpage);
		else
			DBController.DBSelect(jArray, DBController.TWEET_SELECT_TWEETID, TweetId);
		ArrayList<String> quotedIds = new ArrayList<String>();
		ArrayList<String> rePliedIds = new ArrayList<String>();
		ArrayList<String> reTweetIds = new ArrayList<String>();
		for(int i=0;i<jArray.size();i++) {
			JSONObject j = (JSONObject) jArray.get(i);
			if(j.get("tweetType")==null)
				return;
			else if(j.get("tweetType").equals("QUOTED")) {
				quotedIds.add(String.valueOf(j.get("nextTweetId")));
			}
			else if(j.get("tweetType").equals("RETWEETED"))
				reTweetIds.add(String.valueOf(j.get("nextTweetId")));
			else if(j.get("tweetType").equals("REPLIED_TO"))
				rePliedIds.add(String.valueOf(j.get("nextTweetId")));
		}
		for(int i = 0;i<quotedIds.size();i++) {
			for(int j=0;j<jArray.size();j+++) {
				
			}
		}
		System.out.println(quotedIds);
		System.out.println(reTweetIds);
		System.out.println(rePliedIds);
		jObject.put("Tweet", jArray);
		
		out.print(jObject);
		out.flush();
	}
}
