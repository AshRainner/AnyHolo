package com.anyholo.db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

import com.anyholo.model.data.Kirinuki;
import com.anyholo.model.data.Member;
import com.anyholo.model.data.Tweet;

public class DBController {
	public static final int MEMBER_SELECT = 1;
	public static final int KIRINUKI_SELECT = 2; 
	public static final int TWEET_SELECT = 3;
	private static String url = "jdbc:oracle:thin:@52.193.142.22:1521:xe";
	private static String userid = "AnyHolo";
	private static String pwd ="8778";
	private static Connection con =null;
	private static PreparedStatement pstmt = null;
	private static final int MAXITEM=10;
	public static void DBConnect() {
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			con = DriverManager.getConnection(url, userid, pwd);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	public static void InitialValueInsert(Member m,String KRName) {
		DBConnect();
		String sql = "insert into member values(?,?,?,?,?,?,?,?,?,?,?,?)";
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, KRName);
			pstmt.setString(2, m.getImageUrl());
			pstmt.setString(3, m.getCountry());
			pstmt.setString(4, m.getOnAir());
			pstmt.setString(5, m.getIntroduceText());
			pstmt.setString(6, m.getOnAirTitle());
			pstmt.setString(7, m.getOnAirthumnailsUrl());
			pstmt.setString(8, m.getChannelId());
			pstmt.setString(9, m.getTwitterUrl());
			pstmt.setString(10, m.getHololiveUrl());
			pstmt.setInt(11, m.getNumber());
			pstmt.setString(12, m.getOnAirVideoUrl());
			pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		DBClose();
	}
	public static void DBClose() {
		try {
			pstmt.close();
			con.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	public static void TweetInsert(Tweet t) {
		DBConnect();
		String sql = "insert into Tweet values(?,?,?,?,?,?,?,?,?,TO_DATE(?,'yyyy-MM-dd hh24:mi:ss'),?,?,?)";
		//TwitID, WriteUserName, UserID, UserProfileURL, TwitContent, TwitType, prevTweetId, MediaType, MediaURL, WriteDate
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, t.getTweetID());
			pstmt.setString(2, t.getWriteUserName());
			pstmt.setString(3, t.getUserID());
			pstmt.setString(4, t.getUserProfileURL());
			pstmt.setString(5, t.getTweetContent());
			pstmt.setString(6, t.getTweetType());
			pstmt.setString(7, t.getPrevTweetID());
			pstmt.setString(8, t.getMediaType());
			pstmt.setString(9, t.getMediaURL());
			pstmt.setString(10, t.getWriteDate());
			pstmt.setString(11, t.getCountry());
			pstmt.setString(12, t.getHolo());
			pstmt.setString(13, t.getName());
			pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		DBClose();
	}
	public static void KirinukiInsert(Kirinuki k) {
		DBConnect();
		String sql = "insert into Kirinuki values(?,?,?,?,?,TO_DATE(?,'yyyy-MM-dd hh24:mi'),?)";		
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, k.getYoutubeURL());
			pstmt.setString(2, k.getChannelName());
			pstmt.setString(3, k.getThumnailsURL());
			pstmt.setString(4, k.getVideoTitle());
			pstmt.setString(5, k.getTag());
			pstmt.setString(6, k.getUploadTime());
			pstmt.setString(7, k.getCountry());
			pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		DBClose();

	}
	public static void DBUpdate(Member m) {
		DBConnect();
		String sql = "update member set ONAIR = ?, ONAIRTITLE = ?, ONAIRTHUMNAILSURL = ?, ONAIRVIDEOURL = ?"
				+ ", INTRODUCETEXT = ? where channelid like ?";
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, m.getOnAir());
			pstmt.setString(2, m.getOnAirTitle());
			pstmt.setString(3, m.getOnAirthumnailsUrl());
			pstmt.setString(4, m.getOnAirVideoUrl());
			pstmt.setString(5, m.getIntroduceText());
			pstmt.setString(6, m.getChannelId());
			pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		DBClose();
	}
	public static void DBSelect(JSONArray jArray,int Num,String country,String keyword,int Page) {
		if(Num==MEMBER_SELECT)
			MemberSelect(jArray);
		else if(Num==KIRINUKI_SELECT)
			KirinukiSelect(jArray,country,keyword,(Page-1)*MAXITEM+1,Page*MAXITEM);
		else if(Num==TWEET_SELECT)
			TweetSelect(jArray,country,keyword,(Page-1)*MAXITEM+1,Page*MAXITEM);
	}
	public static void RepliedTweetSelect(ArrayList<JSONObject> temp,JSONObject obj) {
		DBConnect();
		temp.add(obj);
		RepliedPrevTweetSelect(temp,obj);
		RepliedNextTweetSelect(temp,obj);
		DBClose();
	}
	private static void RepliedPrevTweetSelect(ArrayList<JSONObject> temp,JSONObject obj) {//맨 앞에 있는 트윗 찾는거 replied에서
		try {	
			String sql ="SELECT * FROM ANYHOLO.TWEET WHERE TweetId = ?";
			pstmt = con.prepareStatement(sql);
			String prevTweetId = (String) obj.get("prevTweetId");
			pstmt.setString(1, String.valueOf(prevTweetId));
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				JSONObject prevObject = new JSONObject();
				TweetPut(prevObject,rs);		
				temp.add(prevObject);
				RepliedPrevTweetSelect(temp, prevObject);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	private static void RepliedNextTweetSelect(ArrayList<JSONObject> temp,JSONObject obj) {
		try {
			String sql ="SELECT * FROM ANYHOLO.TWEET WHERE prevTweetId = ?";
			pstmt = con.prepareStatement(sql);
			String tweetId = (String) obj.get("tweetId");//앞쪽에 있는걸 검색하기 위해서는 prev아이디가 현재 트윗인걸 검색해야함
			pstmt.setString(1, String.valueOf(tweetId));
			ResultSet rs = pstmt.executeQuery();			
			int check=0;
			while(rs.next()) {
				JSONObject nextObject = new JSONObject();
				TweetPut(nextObject,rs);
				temp.add(nextObject);
				RepliedNextTweetSelect(temp,nextObject);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	public static void PrevTweetSelect(JSONObject obj,String tweetId){
		DBConnect();
		String sql = "SELECT * from ANYHOLO.TWEET t WHERE TWEETID = ?";
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, tweetId);
			ResultSet rs = pstmt.executeQuery();
			rs.next();
			JSONObject nextObject = new JSONObject();
			TweetPut(nextObject,rs);
			if(rs.getString("prevTweetId")!=null) {							
				PrevTweetSelect(nextObject,rs.getString("prevTweetId"));
			}
			obj.put("prevTweet", nextObject);
			DBClose();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	private static void TweetSelect(JSONArray jArray,String country,String keyword,int startNum,int EndNum) {
		try {
			DBConnect();
			String sql ="SELECT * FROM (SELECT rownum AS num, t.* FROM (SELECT * FROM ANYHOLO.TWEET t where holo = 1 ORDER BY WRITEDATE DESC)t) WHERE num BETWEEN ? AND ?";
			String plusSql="";
			int countryCheck=0;
			int keywordCheck=0;
			String []keywordSplit = keyword.split(",");
			if(!(country.equals("")||country.equals("전체")||country.equals("즐겨찾기"))) {
				plusSql+="and country like ? ";
				countryCheck=1;
			}	
			if(!keyword.equals("")){
				keywordCheck=1;
				plusSql+="and name like ? ";

				for(;keywordCheck<keywordSplit.length;keywordCheck++)
					plusSql+="or name like ? ";

			}
			if(!plusSql.equals(""))
				sql=sql.replace("holo = 1","holo = 1 "+plusSql);
			pstmt = con.prepareStatement(sql);
			if(countryCheck==1)
				pstmt.setString(countryCheck, country);
			if(keywordCheck>=1)
				for(int i=1;i<=keywordSplit.length;i++) {
					pstmt.setString(i+countryCheck, "%"+keywordSplit[i-1]+"%");
				}
			pstmt.setInt(1+keywordCheck+countryCheck, startNum);
			pstmt.setInt(2+keywordCheck+countryCheck, EndNum);
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				JSONObject sObject = new JSONObject();			
				TweetPut(jArray,sObject,rs);
				jArray.add(sObject);
			}
			DBClose();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	private static void KirinukiSelect(JSONArray jArray,String country,String keyword,int startNum,int EndNum) {

		try {
			DBConnect();
			//String sql = "SELECT * FROM kirinuki order by uploadtime desc";			
			String sql=
					"SELECT * FROM (SELECT rownum AS num, k.* FROM (SELECT * FROM ANYHOLO.KIRINUKI k ORDER BY k.uploadtime desc)k) WHERE num BETWEEN ? AND ?";
			String plusSql="";
			int countryCheck=0;
			int keywordCheck=0;
			String []keywordSplit = keyword.split(",");
			if(!(country.equals("")||country.equals("전체")||country.equals("즐겨찾기"))) {
				plusSql+="country like ? ";
				countryCheck=1;
			}	
			if(!keyword.equals("")){
				keywordCheck=1;
				if(countryCheck==1)
					plusSql+="and tag like ? ";
				else {
					plusSql+="tag like ? ";
					for(;keywordCheck<keywordSplit.length;keywordCheck++)
						plusSql+="or tag like ? ";
				}
			}
			if(!plusSql.equals(""))
				sql=sql.replace("KIRINUKI k ","KIRINUKI k where "+plusSql);
			pstmt = con.prepareStatement(sql);		
			if(countryCheck==1)
				pstmt.setString(countryCheck, "%"+country+"%");
			if(keywordCheck>=1)
				for(int i=1;i<=keywordSplit.length;i++) {
					pstmt.setString(i+countryCheck, "%"+keywordSplit[i-1]+"%");
				}
			pstmt.setInt(1+keywordCheck+countryCheck, startNum);
			pstmt.setInt(2+keywordCheck+countryCheck, EndNum);
			ResultSet rs = pstmt.executeQuery();
			KirinukiPut(jArray,rs);
			DBClose();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	private static void KirinukiPut(JSONArray jArray,ResultSet rs) throws SQLException {
		while(rs.next()) {
			JSONObject sObject = new JSONObject();
			sObject.put("youtubeUrl", rs.getString("youtubeUrl"));
			sObject.put("channelName", rs.getString("channelName"));
			sObject.put("thumnailUrl", rs.getString("thumnailUrl"));
			sObject.put("videoTitle", rs.getString("videoTitle"));
			sObject.put("tag", rs.getString("tag"));
			Timestamp time = rs.getTimestamp("uploadtime");
			SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm");		
			sObject.put("uploadTime",format.format(time));
			sObject.put("country", rs.getString("country"));
			jArray.add(sObject);
		}
	}
	private static void TweetPut(JSONArray jArray,JSONObject sObject, ResultSet rs) throws SQLException {
		sObject.put("tweetId", rs.getString("tweetId"));
		sObject.put("writeUserName", rs.getString("writeUserName"));
		sObject.put("userId", rs.getString("userId"));
		sObject.put("userProfileUrl", rs.getString("userProfileUrl"));
		sObject.put("tweetContent", rs.getString("tweetContent"));
		sObject.put("tweetType", rs.getString("tweetType"));
		sObject.put("prevTweetId", rs.getString("prevTweetId"));
		sObject.put("mediaType", rs.getString("mediaType"));
		sObject.put("mediaUrl", rs.getString("mediaUrl"));
		Timestamp time = rs.getTimestamp("writedate");
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		sObject.put("writeDate",format.format(time));
	}
	private static void TweetPut(JSONObject sObject,ResultSet rs)throws SQLException{
		sObject.put("tweetId", rs.getString("tweetId"));
		sObject.put("writeUserName", rs.getString("writeUserName"));
		sObject.put("userId", rs.getString("userId"));
		sObject.put("userProfileUrl", rs.getString("userProfileUrl"));
		sObject.put("tweetContent", rs.getString("tweetContent"));
		sObject.put("tweetType", rs.getString("tweetType"));
		sObject.put("prevTweetId", rs.getString("prevTweetId"));
		sObject.put("mediaType", rs.getString("mediaType"));
		sObject.put("mediaUrl", rs.getString("mediaUrl"));
		Timestamp time = rs.getTimestamp("writedate");
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		sObject.put("writeDate",format.format(time));
	}
	private static void MemberSelect(JSONArray jArray) {
		try {		
			DBConnect();
			String sql = "SELECT * FROM member order by num";
			pstmt = con.prepareStatement(sql);
			ResultSet rs=pstmt.executeQuery();
			while(rs.next()) {
				JSONObject sObject = new JSONObject();
				sObject.put("memberName", rs.getString("memberName"));
				sObject.put("imageUrl", rs.getString("imageUrl"));
				sObject.put("country", rs.getString("country"));
				sObject.put("onAir", rs.getString("onair"));
				sObject.put("introduceText", rs.getString("introducetext"));
				sObject.put("onairTitle", rs.getString("onairtitle"));
				sObject.put("onAirThumnailsUrl", rs.getString("onairthumnailsurl"));
				sObject.put("onAirViedoUrl", rs.getString("onairvideourl"));
				sObject.put("channelId", rs.getString("channelid"));
				sObject.put("twitterurl", rs.getString("twitterurl"));
				sObject.put("hololiveUrl", rs.getString("hololiveurl"));
				sObject.put("num", rs.getInt("num"));
				jArray.add(sObject);
			}
			DBClose();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
