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

import com.anyholo.model.data.KirinukiUser;
import com.anyholo.model.data.KirinukiVideo;
import com.anyholo.model.data.Member;
import com.anyholo.model.data.Member;
import com.anyholo.model.data.MemberOnAir;
import com.anyholo.model.data.Tweet;

public class DBController {
	public static final int MEMBER_SELECT = 1;
	public static final int KIRINUKI_SELECT = 2; 
	public static final int TWEET_SELECT = 3;
	public static final int UPDATE_SELECT = 4;
	private static String url = "jdbc:oracle:thin:@52.193.142.22:1521:xe";
	private static String userid = "AnyHolo";
	private static String pwd ="8778";
	private static final int MAXITEM=10;
	public Connection DBConnect(Connection con) {
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			con = DriverManager.getConnection(url, userid, pwd);
			return con;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}
	public void DBClose(PreparedStatement pstmt, Connection con) {
		try {
			if(pstmt!=null)
				pstmt.close();
			if(con!=null)
				con.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	public void DBSelect(JSONArray jArray,int Num,String country,String keyword,int Page) {
		if(Num==MEMBER_SELECT)
			MemberViewSelect(jArray);
		else if(Num==KIRINUKI_SELECT)
			KirinukiViewSelect(jArray,country,keyword,(Page-1)*MAXITEM+1,Page*MAXITEM);
		else if(Num==TWEET_SELECT)
			TweetViewSelect(jArray,country,keyword,(Page-1)*MAXITEM+1,Page*MAXITEM);
		else if(Num==UPDATE_SELECT)
			UpdateLogSelect(jArray);
	}
	public void DBSelect(JSONArray jArray,int Num,String country,String keyword,int Page,int web) {
		if(Num==MEMBER_SELECT)
			MemberViewSelect(jArray);
		else if(Num==KIRINUKI_SELECT)
			KirinukiViewSelect(jArray,country,keyword,(Page-1)*16+1,Page*16);
		else if(Num==TWEET_SELECT)
			TweetViewSelect(jArray,country,keyword,(Page-1)*16+1,Page*16);
	}
	public void RepliedTweetSelect(ArrayList<JSONObject> temp,JSONObject obj) {
		temp.add(obj);
		RepliedPrevTweetSelect(temp,obj);
		RepliedNextTweetSelect(temp,obj);
	}
	private void RepliedPrevTweetSelect(ArrayList<JSONObject> temp,JSONObject obj) {//맨 앞에 있는 트윗 찾는거 replied에서
		try {	
			Connection con = null;
			PreparedStatement pstmt = null;
			con = DBConnect(con);
			String sql = "SELECT * FROM TWEETVIEW t WHERE TweetId = ?";
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
			rs.close();
			DBClose(pstmt,con);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	private void RepliedNextTweetSelect(ArrayList<JSONObject> temp,JSONObject obj) {
		try {
			Connection con = null;
			PreparedStatement pstmt = null;
			con = DBConnect(con);
			String sql = "SELECT * FROM TWEETVIEW t WHERE prevTweetId = ?";
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
			rs.close();
			DBClose(pstmt,con);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	public void PrevTweetSelect(JSONObject obj,String tweetId){
		Connection con = null;
		PreparedStatement pstmt = null;
		con = DBConnect(con);
		String sql = "SELECT * from TWEETVIEW t WHERE TWEETID = ?";
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
			rs.close();
			DBClose(pstmt,con);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	private static void KirinukiPut(JSONArray jArray,ResultSet rs) throws SQLException {
		while(rs.next()) {
			JSONObject sObject = new JSONObject();
			sObject.put("userUrl", rs.getString("youtubeUrl"));
			sObject.put("youtubeUrl", rs.getString("videoUrl"));
			sObject.put("channelName", rs.getString("userName"));
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
		sObject.put("twitterId", rs.getString("twitterId"));
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
		sObject.put("twitterId", rs.getString("twitterId"));
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
	private void UpdateLogSelect(JSONArray jArray) {
		Connection con = null;
		PreparedStatement pstmt = null;
		con = DBConnect(con);
		String sql = "SELECT * FROM UPDATE_LOG ORDER BY VERSION desc";
		try {
			pstmt = con.prepareStatement(sql);
			ResultSet rs = pstmt.executeQuery();
			String updateString="";
			String recentVersion="";
			int i = 0;
			while(rs.next()) {
				if(i==0) {
					i++;
					recentVersion=rs.getString("VERSION");
				}
				updateString+=rs.getString("VERSION")+"\n";
				updateString+=rs.getString("CONTENT")+"\n";
			}
			updateString=updateString.substring(0, updateString.length()-1);
			updateString=updateString.replace("<br>","\n");
			jArray.add(recentVersion);
			jArray.add(updateString);
			System.out.println(jArray);
			/*System.out.println("최신 버전 : "+recentVersion);
			System.out.println(updateString);*/
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	private void MemberViewSelect(JSONArray jArray) {
		try {		
			Connection con = null;
			PreparedStatement pstmt = null;
			con = DBConnect(con);
			for(int i=0;i<3;i++) {
				String sql = "SELECT * FROM MEMBERVIEW WHERE COUNTRY = ?";
				pstmt = con.prepareStatement(sql);
				switch(i) {
				case 0:
					pstmt.setString(1, "JP");
					break;
				case 1:
					pstmt.setString(1, "EN");
					break;
				case 2:
					pstmt.setString(1, "ID");
					break;
				}
				ResultSet rs=pstmt.executeQuery();
				while(rs.next()) {
					JSONObject sObject = new JSONObject();
					sObject.put("memberName", rs.getString("krName"));
					sObject.put("searchName", rs.getString("searchKrName"));
					sObject.put("profileUrl", rs.getString("profileUrl"));
					sObject.put("country", rs.getString("country"));
					sObject.put("channelId", rs.getString("channelId"));
					sObject.put("twitterUrl", rs.getString("twitterUrl"));
					sObject.put("hololiveUrl", rs.getString("hololiveUrl"));
					sObject.put("onAir", rs.getString("onAir"));
					sObject.put("onAirTitle", rs.getString("onAirTitle"));
					sObject.put("onAirThumnailsUrl", rs.getString("onAirThumnailsUrl"));
					sObject.put("onAirVideoUrl", rs.getString("onAirVideoUrl"));
					sObject.put("enName", rs.getString("enName"));
					jArray.add(sObject);
				}
				rs.close();
				pstmt.close();
			}			
			DBClose(pstmt,con);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	public void MemberSelect(ArrayList<Member> list) throws SQLException {
		Connection con = null;
		PreparedStatement pstmt = null;
		con = DBConnect(con);
		String sql = "SELECT * FROM ANYHOLO.MEMBER_USER m WHERE \"NUMBER\" > 0 ORDER BY \"NUMBER\"";
		pstmt = con.prepareStatement(sql);
		ResultSet rs = pstmt.executeQuery();
		while(rs.next()) {
			list.add(new Member(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5), rs.getString(6), rs.getString(7),rs.getString(8)));
		}
		rs.close();
		DBClose(pstmt,con);
	}
	public void MemberDataInsert(Member m) throws SQLException {
		Connection con = null;
		PreparedStatement pstmt = null;
		con = DBConnect(con);
		String sql = "INSERT INTO ANYHOLO.MEMBER_DATA m values(?,?,?,?,?,?,?,?)";
		pstmt = con.prepareStatement(sql);
		pstmt.setInt(1, m.getNumber());
		pstmt.setString(2, m.getChannelId());
		pstmt.setString(3, m.getTwitterUrl());
		pstmt.setString(4, m.getHololiveUrl());
		pstmt.setString(5, m.getCountry());
		pstmt.setString(6, m.getSearchKrName());
		pstmt.setString(7, m.getKrName());
		pstmt.setString(8, m.getTwitterId());
		pstmt.executeUpdate();
		DBClose(pstmt,con);
	}
	public void MemberOnAirSelect(ArrayList<MemberOnAir> list) throws SQLException {
		Connection con = null;
		PreparedStatement pstmt = null;
		con = DBConnect(con);
		String sql = "SELECT * FROM ANYHOLO.MEMBER_ONAIR m ORDER BY m.\"NUMBER\" ASC";
		pstmt = con.prepareStatement(sql);
		ResultSet rs = pstmt.executeQuery();
		while(rs.next())
			list.add(new MemberOnAir(rs.getInt(5),rs.getString(1),rs.getString(2),rs.getString(3),rs.getString(4)));
		rs.close();
		DBClose(pstmt,con);
	}
	public void MemberOnAirInsert(MemberOnAir m) throws SQLException {
		Connection con = null;
		PreparedStatement pstmt = null;
		con = DBConnect(con);
		String sql = "INSERT INTO ANYHOLO.MEMBER_ONAIR values(?,?,?,?,?)";
		pstmt = con.prepareStatement(sql);
		pstmt.setString(1, m.getOnAir());
		pstmt.setString(2, m.getOnAirTitle());
		pstmt.setString(3, m.getOnAirThumnailsUrl());
		pstmt.setString(4, m.getOnAirVideoUrl());
		pstmt.setInt(5, m.getNumber());
		pstmt.executeUpdate();
		DBClose(pstmt,con);
	}
	public void KirinukiUserInsert(KirinukiUser k) throws SQLException {
		Connection con = null;
		PreparedStatement pstmt = null;
		con = DBConnect(con);
		String sql = "INSERT INTO ANYHOLO.KIRINUKI_USER values(?,?)";
		pstmt = con.prepareStatement(sql);
		pstmt.setString(1, k.getYoutubeUrl());
		pstmt.setString(2, k.getUserName());
		pstmt.executeUpdate();
		DBClose(pstmt,con);
	}
	public void KirinukiVideoInsert(KirinukiVideo k){
		Connection con = null;
		PreparedStatement pstmt = null;
		con = DBConnect(con);
		String sql = "SELECT * FROM ANYHOLO.KIRINUKI_VIDEO WHERE VIDEOURL = ?";
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, k.getVideoUrl());
			ResultSet rs = pstmt.executeQuery();	
			if(rs.next()==false) {
				sql = "INSERT INTO ANYHOLO.KIRINUKI_VIDEO values(?,?,?,TO_DATE(?,'yyyy-MM-dd hh24:mi'),?,?,?)";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, k.getThumnailUrl());
				pstmt.setString(2, k.getVideoTitle());
				pstmt.setString(3, k.getTag());
				pstmt.setString(4, k.getUpLoadTime());
				pstmt.setString(5, k.getCountry());
				pstmt.setString(6, k.getVideoUrl());
				pstmt.setString(7,k.getYoutubeUrl());
				pstmt.executeUpdate();			
			}
			rs.close();
			DBClose(pstmt,con);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}	
}
	public String KirinukiVideoCheck(String videoUrl) throws SQLException {
		Connection con = null;
		PreparedStatement pstmt = null;
		con = DBConnect(con);
		String sql = "SELECT * FROM ANYHOLO.KIRINUKI_VIDEO WHERE VIDEOURL = ?";
		pstmt = con.prepareStatement(sql);
		pstmt.setString(1, videoUrl);
		ResultSet rs = pstmt.executeQuery();	
		if(rs.next()==false) {
			rs.close();
			DBClose(pstmt,con);
			return videoUrl;	
		}
		rs.close();
		DBClose(pstmt,con);
		return "";

	}
	public void KirinukiUserSelect(ArrayList<KirinukiUser> k) throws SQLException {
		Connection con = null;
		PreparedStatement pstmt = null;
		con = DBConnect(con);
		String sql = "SELECT * FROM ANYHOLO.KIRINUKI_USER";
		pstmt = con.prepareStatement(sql);
		ResultSet rs = pstmt.executeQuery();
		while(rs.next())
			k.add(new KirinukiUser(rs.getString(1),rs.getString(2)));
		DBClose(pstmt,con);
	}
	public void MemberOnAirUpdate(ArrayList<MemberOnAir> onAirList) throws SQLException {	
		String sql = "UPDATE ANYHOLO.MEMBER_ONAIR m SET ONAIR = ?, ONAIRTITLE = ?, ONAIRTHUMNAILSURL = ?, ONAIRVIDEOURL = ? where m.\"NUMBER\" = ?";	
		for(MemberOnAir m : onAirList) {
			Connection con = null;
			PreparedStatement pstmt = null;
			con = DBConnect(con);
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, m.getOnAir());
			pstmt.setString(2, m.getOnAirTitle());
			pstmt.setString(3, m.getOnAirThumnailsUrl());
			pstmt.setString(4, m.getOnAirVideoUrl());
			pstmt.setInt(5, m.getNumber());
			pstmt.executeUpdate();
			DBClose(pstmt,con);
		}		
	}
	public void TweetDataInsert(Tweet t) {
		Connection con = null;
		PreparedStatement pstmt = null;
		con = DBConnect(con);
		String sql = "INSERT INTO TWEET_DATA VALUES(?,?,?,?,?,?,?,?,TO_DATE(?,'yyyy-MM-dd hh24:mi:ss'),?)";
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, t.getTweetID());
			pstmt.setString(2, t.getWriteUserName());
			pstmt.setString(3, t.getUserProfileURL());
			pstmt.setString(4, t.getTweetContent());
			pstmt.setString(5, t.getTweetType());
			pstmt.setString(6, t.getPrevTweetID());
			pstmt.setString(7, t.getMediaType());
			pstmt.setString(8, t.getMediaURL());
			pstmt.setString(9, t.getWriteDate());
			pstmt.setInt(10, t.getNumber());
			pstmt.executeUpdate();
			DBClose(pstmt,con);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	private void KirinukiViewSelect(JSONArray jArray,String country,String keyword,int startNum,int EndNum){	
		try {
			Connection con = null;
			PreparedStatement pstmt = null;
			con = DBConnect(con);
			String sql=
					"SELECT * FROM (SELECT rownum AS num,k.* FROM KIRINUKIVIEW k where country is not null)k WHERE num BETWEEN ? AND ?";
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
				if(countryCheck==1)
					plusSql+="and tag like ? ";
				else {
					plusSql+="and tag like ? ";
					for(;keywordCheck<keywordSplit.length;keywordCheck++)
						plusSql+="or tag like ? ";
				}
			}
			if(!plusSql.equals(""))
				sql=sql.replace("not null","not null "+plusSql);
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
			rs.close();
			DBClose(pstmt,con);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}		

	}
	
	private void TweetViewSelect(JSONArray jArray,String country,String keyword,int startNum,int EndNum) {
		try {
			Connection con = null;
			PreparedStatement pstmt = null;
			con = DBConnect(con);
			String sql = "SELECT * FROM (SELECT rownum AS num,t.* FROM TWEETVIEW t where t.\"NUMBER\" > 0)t WHERE num BETWEEN ? AND ? ";
			//String sql ="SELECT * FROM (SELECT rownum AS num, t.* FROM (SELECT * FROM ANYHOLO.TWEET t where holo = 1 ORDER BY WRITEDATE DESC)t) WHERE num BETWEEN ? AND ?";
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
				plusSql+="and Searchkrname like ? ";

				for(;keywordCheck<keywordSplit.length;keywordCheck++)
					plusSql+="or Searchkrname like ? ";

			}
			if(!plusSql.equals(""))
				sql=sql.replace("> 0","> 0 "+plusSql);
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
			rs.close();
			DBClose(pstmt,con);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	//-----------------------------------------------------------
	public void UserInsert(String id, String pw, String phone,String name) throws SQLException {
		Connection con = null;
		PreparedStatement pstmt = null;
		con = DBConnect(con);
		String sql = "Insert into \"USER\" values(?,?,?,?)";
		pstmt = con.prepareStatement(sql);
		pstmt.setString(1, id);
		pstmt.setString(2, pw);
		pstmt.setString(3, phone);
		pstmt.setString(4, name);
		pstmt.executeUpdate();
		sql = "Insert into \"FAVORITE\" values(?,'null')";
		pstmt = con.prepareStatement(sql);
		pstmt.setString(1, id);
		pstmt.executeUpdate();
		DBClose(pstmt,con);
	}
	public boolean UserSelect(String id,String pw) throws SQLException {
		Connection con = null;
		PreparedStatement pstmt = null;
		con = DBConnect(con);
		String sql = "Select * from \"USER\" where id = ? and pw = ?";
		pstmt = con.prepareStatement(sql);
		pstmt.setString(1, id);
		pstmt.setString(2, pw);
		ResultSet rs = pstmt.executeQuery();
		boolean result = rs.next();
		rs.close();
		DBClose(pstmt, con);
		return result;
	}
	public String FindID(String phone,String name) throws SQLException {
		Connection con = null;
		PreparedStatement pstmt = null;
		con = DBConnect(con);
		String sql = "Select * from \"USER\" where phone = ? and name = ?";
		pstmt = con.prepareStatement(sql);
		pstmt.setString(1, phone);
		pstmt.setString(2, name);
		ResultSet rs = pstmt.executeQuery();
		rs.next();
		String result=rs.getString("id");
		rs.close();
		DBClose(pstmt, con);
		return result;
	}
	public String FindPW(String id,String phone,String name) throws SQLException {
		Connection con = null;
		PreparedStatement pstmt = null;
		con = DBConnect(con);
		String sql = "Select * from \"USER\" where id = ? and phone = ? and name = ?";
		pstmt = con.prepareStatement(sql);
		pstmt.setString(1, id);
		pstmt.setString(2, phone);
		pstmt.setString(3, name);
		ResultSet rs = pstmt.executeQuery();
		rs.next();
		String result=rs.getString("id");
		rs.close();
		DBClose(pstmt, con);
		return result;
	}
	public void ResetPW(String id,String pw,String phone,String name) throws SQLException {
		Connection con = null;
		PreparedStatement pstmt = null;
		con = DBConnect(con);
		String sql = "UPDATE \"USER\" SET pw = ? where id = ? and phone = ? and name = ?";
		pstmt = con.prepareStatement(sql);
		pstmt.setString(1, pw);
		pstmt.setString(2, id);
		pstmt.setString(3, phone);
		pstmt.setString(4, name);
		pstmt.executeUpdate();
		DBClose(pstmt, con);
	}
	public void FavoriteUpdate(String id,String name) throws SQLException {
		Connection con = null;
		PreparedStatement pstmt = null;
		con = DBConnect(con);
		String sql = "select * from \"FAVORITE\" where id = ?";
		pstmt = con.prepareStatement(sql);
		pstmt.setString(1, id);
		ResultSet rs = pstmt.executeQuery();
		rs.next();
		name+=";"+rs.getString("favorite");
		sql = "UPDATE \"FAVORITE\" SET favorite = ? where id = ?";
		pstmt = con.prepareStatement(sql);
		pstmt.setString(1, name);
		pstmt.setString(2, id);
		pstmt.executeUpdate();
		rs.close();
		DBClose(pstmt, con);
	}
	public void FavoriteUpdate_Del(String id,String Delname) throws SQLException {
		Connection con = null;
		PreparedStatement pstmt = null;
		con = DBConnect(con);
		String sql = "select * from \"FAVORITE\" where id = ?";
		pstmt = con.prepareStatement(sql);
		pstmt.setString(1, id);
		ResultSet rs = pstmt.executeQuery();
		rs.next();
		String name=rs.getString("favorite").replace(Delname+";", "");
		sql = "UPDATE \"FAVORITE\" SET favorite = ? where id = ?";
		pstmt = con.prepareStatement(sql);
		pstmt.setString(1, name);
		pstmt.setString(2, id);
		pstmt.executeUpdate();
		rs.close();
		DBClose(pstmt, con);
	}
	public String SeletctFavorite(String id) throws SQLException {
		Connection con = null;
		PreparedStatement pstmt = null;
		con = DBConnect(con);
		String sql = "Select * from \"FAVORITE\" where id = ?";
		pstmt = con.prepareStatement(sql);
		pstmt.setString(1, id);
		ResultSet rs = pstmt.executeQuery();
		rs.next();
		String favorite=rs.getString("favorite");
		rs.close();
		DBClose(pstmt, con);
		return favorite;
	}
}
