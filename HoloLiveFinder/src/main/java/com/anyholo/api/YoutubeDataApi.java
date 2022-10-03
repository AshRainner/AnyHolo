package com.anyholo.api;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

public class YoutubeDataApi {
	public static String getProfileJSon(String channels_id,String key) throws IOException{
		//member들의 channels_id를 하나의 String으로 모아 검색
		//최대 50개의 채널을 한번에 검색할 수 있어 할당량면에서 이득
		String apiurl = "https://www.googleapis.com/youtube/v3/channels";
		apiurl+="?part=snippet&id="+channels_id;
		apiurl+="&fields=items&key="+key;
		return apiConnection(apiurl);
	}
	public static String getLiveJSon(String videos_id,String key)throws IOException{
		//live중인 채널들의 videos_id만 모아서 한번에 검색
		//search api를 사용할 경우 할당량을 너무 많이 사용하기에 이러한 방법을 사용
		String apiurl = "https://www.googleapis.com/youtube/v3/videos";
		apiurl+="?part=snippet&id="+videos_id;
		apiurl+="&fields=items&key="+key;
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
}
