package com.anyholo.db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import com.anyholo.model.data.Kirinuki;
import com.anyholo.model.data.Member;
import com.anyholo.model.data.Tweet;

public class DBController {
	public static final int MEMBER_SELECT = 1;
	public static final int KIRINUKI_SELECT = 2; 
	public static final int TWEET_SELECT = 3;
	public static final int TWEET_SELECT_TWEETID = 4;
	private static String url = "jdbc:oracle:thin:@222.237.255.159:1521:xe";
	private static String userid = "HololiveFinder";
	private static String pwd ="8778";
	private static Connection con =null;
	private static PreparedStatement pstmt = null;
	private static final int MAXITEM=6;
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
	public static int TweetSelect(String twid) {
		DBConnect();
		String sql = "select * from tweet where twitid like ?";
		try {
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, twid);
			pstmt.executeQuery();
			return 1;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return 0;
		}
	}
	public static void TweetInsert(Tweet t) {
		DBConnect();
		String sql = "insert into Tweet values(?,?,?,?,?,?,?,?,?,TO_DATE(?,'yyyy-MM-dd hh24:mi:ss'))";
		//TwitID, WriteUserName, UserID, UserProfileURL, TwitContent, TwitType, NextTwitID, MediaType, MediaURL, WriteDate
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, t.getTweetID());
			pstmt.setString(2, t.getWriteUserName());
			pstmt.setString(3, t.getUserID());
			pstmt.setString(4, t.getUserProfileURL());
			pstmt.setString(5, t.getTweetContent());
			pstmt.setString(6, t.getTweetType());
			pstmt.setString(7, t.getNextTweetID());
			pstmt.setString(8, t.getMediaType());
			pstmt.setString(9, t.getMediaURL());
			pstmt.setString(10, t.getWriteDate());
			pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		DBClose();
	}
	public static void KirinukiInsert(Kirinuki k) {
		DBConnect();
		String sql = "insert into Kirinuki values(?,?,?,?,?,TO_DATE(?,'yyyy-MM-dd hh24:mi'))";		
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, k.getYoutubeURL());
			pstmt.setString(2, k.getChannelName());
			pstmt.setString(3, k.getThumnailsURL());
			pstmt.setString(4, k.getVideoTitle());
			pstmt.setString(5, k.getTag());
			pstmt.setString(6, k.getUploadTime());
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
	public static void DBSelect(JSONArray jArray,int Num,int Page) {
		if(Num==MEMBER_SELECT)
			MemberSelect(jArray);
		else if(Num==KIRINUKI_SELECT)
			//KirinukiSelect(jArray,(Page-1)*5+1,Page*5);
		KirinukiSelect(jArray,(Page-1)*MAXITEM+1,Page*MAXITEM);
			//KirinukiSelect(jArray);
		else if(Num==TWEET_SELECT)
			TweetSelect(jArray,(Page-1)*MAXITEM+1,Page*MAXITEM);
			//TweetSelect(jArray);
		else
			TweetSelect(jArray,Page);
	}
	private static void TweetSelect(JSONArray jArray,int TweetId) {
		try {
			DBConnect();
			String sql ="SELECT * FROM HOLOLIVEFINDER.TWEET WHERE TWEETID = '?'";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, String.valueOf(TweetId));
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				JSONObject sObject = new JSONObject();
				sObject.put("tweetId", rs.getString("tweetId"));
				sObject.put("writeUserName", rs.getString("writeUserName"));
				sObject.put("userId", rs.getString("userId"));
				sObject.put("userProfileUrl", rs.getString("userProfileUrl"));
				sObject.put("tweetContent", rs.getString("tweetContent"));
				sObject.put("tweetType", rs.getString("tweetType"));
				sObject.put("nextTweetId", rs.getString("nextTweetId"));
				sObject.put("mediaType", rs.getString("mediaType"));
				sObject.put("mediaUrl", rs.getString("mediaUrl"));
				Timestamp time = rs.getTimestamp("writedate");
				SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm");		
				//System.out.println(format.format(time));
				sObject.put("writeDate",format.format(time));
				jArray.add(sObject);
			}
			DBClose();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	private static void TweetSelect(JSONArray jArray,int startNum,int EndNum) {
		try {
			DBConnect();
			//String sql = "SELECT * FROM Tweet order by writedate asc";
			String sql ="SELECT * FROM (SELECT rownum AS num, t.* FROM (SELECT * FROM HOLOLIVEFINDER.TWEET t ORDER BY WRITEDATE DESC)t) WHERE num BETWEEN ? AND ?";
			//700 750
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, startNum);
			pstmt.setInt(2, EndNum);
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				JSONObject sObject = new JSONObject();
				sObject.put("tweetId", rs.getString("tweetId"));
				sObject.put("writeUserName", rs.getString("writeUserName"));
				sObject.put("userId", rs.getString("userId"));
				sObject.put("userProfileUrl", rs.getString("userProfileUrl"));
				sObject.put("tweetContent", rs.getString("tweetContent"));
				sObject.put("tweetType", rs.getString("tweetType"));
				sObject.put("nextTweetId", rs.getString("nextTweetId"));
				sObject.put("mediaType", rs.getString("mediaType"));
				sObject.put("mediaUrl", rs.getString("mediaUrl"));
				Timestamp time = rs.getTimestamp("writedate");
				SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm");
				sObject.put("writeDate",format.format(time));
				jArray.add(sObject);
			}
			DBClose();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	private static void TweetSelect(JSONArray jArray) {
		try {
			DBConnect();
			//String sql = "SELECT * FROM Tweet order by writedate asc";
			String sql ="SELECT * FROM (SELECT rownum AS num, t.* FROM (SELECT * FROM HOLOLIVEFINDER.TWEET t ORDER BY WRITEDATE DESC)t)";
			//700 750
			pstmt = con.prepareStatement(sql);
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				JSONObject sObject = new JSONObject();
				sObject.put("tweetId", rs.getString("tweetId"));
				sObject.put("writeUserName", rs.getString("writeUserName"));
				sObject.put("userId", rs.getString("userId"));
				sObject.put("userProfileUrl", rs.getString("userProfileUrl"));
				sObject.put("tweetContent", rs.getString("tweetContent"));
				sObject.put("tweetType", rs.getString("tweetType"));
				sObject.put("nextTweetId", rs.getString("nextTweetId"));
				sObject.put("mediaType", rs.getString("mediaType"));
				sObject.put("mediaUrl", rs.getString("mediaUrl"));
				Timestamp time = rs.getTimestamp("writedate");
				SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm");		
				//System.out.println(format.format(time));
				sObject.put("writeDate",format.format(time));
				jArray.add(sObject);
			}
			DBClose();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	private static void KirinukiSelect(JSONArray jArray) {

		try {
			DBConnect();
			//String sql = "SELECT * FROM kirinuki order by uploadtime desc";			
			String sql="SELECT * FROM (SELECT rownum AS num, k.* FROM (SELECT * FROM HOLOLIVEFINDER.KIRINUKI k ORDER BY k.uploadtime desc)k)";
			pstmt = con.prepareStatement(sql);
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				JSONObject sObject = new JSONObject();
				sObject.put("youtubeUrl", rs.getString("youtubeUrl"));
				sObject.put("channelName", rs.getString("channelName"));
				sObject.put("thumnailUrl", rs.getString("thumnailUrl"));
				sObject.put("videoTitle", rs.getString("videoTitle"));
				sObject.put("tag", rs.getString("tag"));
				Timestamp time = rs.getTimestamp("uploadtime");
				SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm");		
				//System.out.println(format.format(time));
				sObject.put("uploadTime",format.format(time));
				jArray.add(sObject);

			}
			DBClose();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	private static void KirinukiSelect(JSONArray jArray,int startNum,int EndNum) {

		try {
			DBConnect();
			//String sql = "SELECT * FROM kirinuki order by uploadtime desc";			
			String sql="SELECT * FROM (SELECT rownum AS num, k.* FROM (SELECT * FROM HOLOLIVEFINDER.KIRINUKI k ORDER BY k.uploadtime desc)k) WHERE num BETWEEN ? AND ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, startNum);
			pstmt.setInt(2, EndNum);
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				JSONObject sObject = new JSONObject();
				sObject.put("youtubeUrl", rs.getString("youtubeUrl"));
				sObject.put("channelName", rs.getString("channelName"));
				sObject.put("thumnailUrl", rs.getString("thumnailUrl"));
				sObject.put("videoTitle", rs.getString("videoTitle"));
				sObject.put("tag", rs.getString("tag"));
				Timestamp time = rs.getTimestamp("uploadtime");
				SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm");		
				//System.out.println(format.format(time));
				sObject.put("uploadTime",format.format(time));
				jArray.add(sObject);

			}
			DBClose();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
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
