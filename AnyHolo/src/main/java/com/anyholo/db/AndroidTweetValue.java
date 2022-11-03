package com.anyholo.db;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;

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
		PrintWriter out = response.getWriter();
		JSONObject jObject = new JSONObject();
		JSONArray jArray = new JSONArray();
		DBController.DBSelect(jArray,DBController.TWEET_SELECT,Tpage);
		ArrayList<String> prevTweetIds = new ArrayList<String>();
		ArrayList<String> repliedTweetIds = new ArrayList<String>();
		for(int i=0;i<jArray.size();i++) {
			JSONObject j = (JSONObject) jArray.get(i);
			if(j.get("tweetType").equals("DEFAULT")) {

			}
			else if(j.get("tweetType").equals("REPLIED_TO")) {
				repliedTweetIds.add(String.valueOf(j.get("prevTweetId"))); // 자기 자신
			}
			else
				prevTweetIds.add(String.valueOf(j.get("prevTweetId")));
		}
		for(int i = 0;i<prevTweetIds.size();i++) {//이미 뽑은 결과 중 다음 트윗이 있다면 2번 질의할 필요없이 있는 자료를 사용하기 위해 삭제
			for(int j=0;j<jArray.size();j++) {
				JSONObject jObj = (JSONObject) jArray.get(j);
				if(prevTweetIds.get(i).equals(jObj.get("tweetId"))) {
					prevTweetIds.remove(i);
					i--;
					break;
				}
			}
		}
		for(int i = 0;i<repliedTweetIds.size();i++) {
			for(int j=0;j<jArray.size();j++) {
				JSONObject jObj = (JSONObject) jArray.get(j);
				if(repliedTweetIds.get(i).equals(jObj.get("tweetId"))) {
					repliedTweetIds.remove(i);
					i--;
					break;
				}
			}
		}
		for(int i = 0;i<jArray.size();i++) {
			JSONObject jObj=(JSONObject)jArray.get(i);
			if(jObj.get("tweetType").equals("REPLIED_TO")) {
				if(repliedTweetIds.contains(jObj.get("prevTweetId"))) {
					ArrayList<JSONObject> temp = new ArrayList<JSONObject>();
					DBController.RepliedTweetSelect(temp,jObj);
					Collections.sort(temp, new Comparator<JSONObject>() {
						private static final String KEY_NUM = "Number";             //JSON key 변수 선언 생성
						@Override
						public int compare(JSONObject a, JSONObject b) {
							String valA = "";
							String valB = "";
							valA = (String) a.get("tweetId");
							valB = (String) b.get("tweetId");
					        return valA.compareTo(valB);
						}
					});//위에서부터 순서대로 넣기 위한 정렬
					jArray.remove(i);
					for(int j=0;j<temp.size();j++)
						jArray.add(i++,temp.get(j));
				}
			}
			else if(!(jObj.get("tweetType").equals("DEFAULT"))) {
				if(prevTweetIds.contains(jObj.get("prevTweetId"))) {
					DBController.PrevTweetSelect(jObj,String.valueOf(jObj.get("prevTweetId")));
				}
			}
		}
		jObject.put("Tweet", jArray);
		out.print(jObject);
		out.flush();
	}
}
