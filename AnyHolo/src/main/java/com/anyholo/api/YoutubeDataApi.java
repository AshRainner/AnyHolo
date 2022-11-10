package com.anyholo.api;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

public class YoutubeDataApi {
	private static String API_KEY = null;
	public static void setKey() {
		File youtubeApiPath = new File("/key/YoutubeApiKey.txt");
		try {
			BufferedReader br = new BufferedReader(new FileReader(youtubeApiPath));
			API_KEY=br.readLine();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	public static String getProfileJSon(String channels_id) throws IOException{
		//member들의 channels_id를 하나의 String으로 모아 검색
		//최대 50개의 채널을 한번에 검색할 수 있어 할당량면에서 이득
		String apiurl = "https://www.googleapis.com/youtube/v3/channels";
		apiurl+="?part=snippet&id="+channels_id;
		apiurl+="&fields=items&key="+API_KEY;
		return apiConnection(apiurl);
	}
	public static String getLiveJSon(String videos_id)throws IOException{
		//live중인 채널들의 videos_id만 모아서 한번에 검색
		//search api를 사용할 경우 할당량을 너무 많이 사용하기에 이러한 방법을 사용
		String apiurl = "https://www.googleapis.com/youtube/v3/videos";
		apiurl+="?part=snippet,liveStreamingDetails&id="+videos_id;
		apiurl+="&fields=items&key="+API_KEY;
		URL url = new URL(apiurl);
		return apiConnection(apiurl);	
	}
	private static String apiConnection(String apiurl)throws IOException {
		URL url = new URL(apiurl);
		HttpURLConnection con = (HttpURLConnection) url.openConnection();
		con.setRequestMethod("GET");
		BufferedReader br = new BufferedReader(new InputStreamReader(con.getInputStream(),"UTF-8"));
		String inputLine;
		StringBuffer response = new StringBuffer();
		while((inputLine = br.readLine())!=null) {
			response.append(inputLine);
		}
		return response.toString();
	}
	public static String getKirinukiVideo(String channel_id)throws IOException{
		//playlistid가져와서 playlist로 검색해서 가져오기
		String apiurl = "https://www.googleapis.com/youtube/v3/playlistItems";
		apiurl+="?part=snippet&playlistId="+channel_id;
		apiurl+="&fields=items&key="+API_KEY;
		//UCOPaYsI-TnBk0qxoAy_rjXA
		//UUOPaYsI-TnBk0qxoAy_rjXA
		return apiConnection(apiurl);
	}
	public static String getKirinukiInitialValue(String channel_id)throws IOException{
		String apiurl = "https://www.googleapis.com/youtube/v3/playlistItems";
		channel_id="UU"+channel_id.substring(2,channel_id.length());
		apiurl+="?part=snippet&maxResults=50&playlistId="+channel_id;
		apiurl+="&key="+API_KEY;
		return apiConnection(apiurl);
	}
	public static String getKirinukiInitialValue(String channel_id,String nextPageToken)throws IOException{
		String apiurl = "https://www.googleapis.com/youtube/v3/playlistItems";
		channel_id="UU"+channel_id.substring(2,channel_id.length());
		apiurl+="?part=snippet&maxResults=50&pageToken=+"+nextPageToken+"&playlistId="+channel_id;
		apiurl+="&key="+API_KEY;		
		return apiConnection(apiurl);
	}
}
