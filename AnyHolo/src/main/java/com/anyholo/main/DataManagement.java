package com.anyholo.main;

import java.io.IOException;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.ZonedDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.TimeZone;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

import com.anyholo.api.TwitterApi;
import com.anyholo.api.YoutubeDataApi;
import com.anyholo.db.DBController;
import com.anyholo.model.data.KirinukiUser;
import com.anyholo.model.data.KirinukiVideo;
import com.anyholo.model.data.Member;
import com.anyholo.model.data.MemberOnAir;
import com.anyholo.model.data.Tweet;
import com.anyholo.model.kirinuki.KirinukiModel;
import com.anyholo.model.live.LiveModel;
import com.fasterxml.jackson.core.exc.StreamReadException;
import com.fasterxml.jackson.databind.DatabindException;
import com.fasterxml.jackson.databind.ObjectMapper;

import io.github.redouane59.twitter.TwitterClient;
import io.github.redouane59.twitter.dto.endpoints.AdditionalParameters;
import io.github.redouane59.twitter.dto.tweet.TweetList;
import io.github.redouane59.twitter.dto.tweet.TweetType;
import io.github.redouane59.twitter.dto.tweet.TweetV2.TweetData;

public class DataManagement {
	private ArrayList<Member> memberList;
	private ArrayList<KirinukiUser> kirinukiList;
	private ArrayList<MemberOnAir> memberOnAirList;
	private DBController dbc = null;
	public void InitializationValue(){
		dbc = new DBController();
		memberList = new ArrayList<>();
		memberOnAirList = new ArrayList<>();
		try {
			dbc.MemberSelect(memberList);
			dbc.MemberOnAirSelect(memberOnAirList);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}
	public void InitializationKirinukiValue(){
		dbc = new DBController();
		memberList = new ArrayList<>();
		kirinukiList = new ArrayList<>();
		try {
			dbc.MemberSelect(memberList);
			dbc.KirinukiUserSelect(kirinukiList);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}		
	}
	public void LiveConfirm(){
		//web페이지를 파싱해서 live여부를 확인 할당량을 아끼기위해 사용함
		String liveids="";
		for(int i=0;i<memberList.size();i++) {
			Document doc;
			try {
				doc = Jsoup.connect("https://www.youtube.com/channel/"
						+memberList.get(i).getChannelId()+"/live").get();
				Elements links = doc.select("link[rel=\"canonical\"]");
				if(links.attr("href").contains("watch")) {
					liveids+=(links.attr("href").substring(32))+",";
				}
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}		
		}
		boolean[] check = new boolean[55];
		if(liveids!="") {
			liveids = liveids.substring(0,liveids.length()-1);
			String jsonString;
			try {
				jsonString = YoutubeDataApi.getLiveJSon(liveids);
				ObjectMapper mapper = new ObjectMapper();
				String Day2Later = ZonedDateTime.now().plusDays(2).format(DateTimeFormatter.ISO_INSTANT);
				List<com.anyholo.model.live.Item> items = mapper.readValue(jsonString, LiveModel.class).getItems();
				for(int i=0;i<memberOnAirList.size();i++) {
					memberOnAirList.get(i).setOnAir("default");
					memberOnAirList.get(i).setOnAirThumnailsUrl("default");
					memberOnAirList.get(i).setOnAirTitle("default");
					memberOnAirList.get(i).setOnAirVideoUrl("default");
				}
				for(int i=0;i<items.size();i++) {
					int index = getIndex(items.get(i))-1; // number값이 1부터 시작이라 1 빼줘야함
					String thumbnailsUrl = "";
					if(items.get(i).getSnippet().getLiveBroadcastContent().equals("live")||
							items.get(i).getSnippet().getLiveBroadcastContent().equals("upcoming")&&
							items.get(i).getLiveStreamingDetails().getScheduledStartTime().compareTo(Day2Later)<=0) {
						memberOnAirList.get(index).setOnAir(items.get(i).getSnippet().getLiveBroadcastContent());
						if(items.get(i).getSnippet().getThumbnails().getMaxres()!=null) {
							thumbnailsUrl = items.get(i).getSnippet().getThumbnails().getMaxres().getUrl();		
						}else if(items.get(i).getSnippet().getThumbnails().getStandard()!=null) {
							thumbnailsUrl = items.get(i).getSnippet().getThumbnails().getStandard().getUrl();
						}else if(items.get(i).getSnippet().getThumbnails().getHigh()!=null) {
							thumbnailsUrl = items.get(i).getSnippet().getThumbnails().getHigh().getUrl();
						}else if(items.get(i).getSnippet().getThumbnails().getMedium()!=null) {
							thumbnailsUrl = items.get(i).getSnippet().getThumbnails().getMedium().getUrl();
						}else {
							thumbnailsUrl = items.get(i).getSnippet().getThumbnails().getDefault().getUrl();
						}
						memberOnAirList.get(index).setOnAirThumnailsUrl(thumbnailsUrl);
						memberOnAirList.get(index).setOnAirTitle(items.get(i).getSnippet().getTitle());
						memberOnAirList.get(index).setOnAirVideoUrl("https://www.youtube.com/watch?v="+items.get(i).getId());
					}
				}
				dbc.MemberOnAirUpdate(memberOnAirList);
			} catch (IOException | SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

		}	
	}
	private int getIndex(com.anyholo.model.live.Item item) {//api에서 불러온 값이 순서대로가 아니라 순서를 확인해줄 index
		for(Member m : memberList) {
			if(item.getSnippet().getChannelId().equals(m.getChannelId())) {
				return m.getNumber();
			}
		}
		return -1;
	}
	private String returnVideoUrl(String channelId){
		Document doc;
		try {
			doc = Jsoup.connect("https://www.youtube.com/channel/"
					+channelId+"/videos").get();
			Elements links = doc.select("script");
			String jsonString=null;
			for(Element element : links) {
				if(element.data().contains("var ytInitialData")) {
					jsonString = element.data().substring(20,element.data().length()-1);
					break;
				}
			}
			JSONParser parser = new JSONParser();
			JSONObject jsonObject = (JSONObject) parser.parse(jsonString);
			jsonObject = (JSONObject) jsonObject.get("contents");
			jsonObject = (JSONObject) jsonObject.get("twoColumnBrowseResultsRenderer");
			JSONArray jsonArray = (JSONArray) jsonObject.get("tabs");
			for(int i = 0; i<jsonArray.size()-1;i++) {
				JSONObject obj = (JSONObject) jsonArray.get(i);
				//aws에서는 動画 일본어로 나옴 한국은 동영상
				if(((JSONObject)obj.get("tabRenderer")).get("title").equals("動画")) {
					jsonObject = (JSONObject) ((JSONObject)obj.get("tabRenderer")).get("content");
				}
			}
			jsonObject = (JSONObject) jsonObject.get("richGridRenderer");
			jsonArray = (JSONArray) jsonObject.get("contents");
			jsonObject = (JSONObject) jsonArray.get(0);
			jsonObject = (JSONObject) jsonObject.get("richItemRenderer");
			jsonObject = (JSONObject) jsonObject.get("content");
			jsonObject = (JSONObject) jsonObject.get("videoRenderer");
			return jsonObject.get("videoId").toString();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return "";
		} catch (org.json.simple.parser.ParseException e) {
			e.printStackTrace();
			return "";
		} catch (Exception e) {
			e.printStackTrace();
			return "";
		}
	}
	private String returnShortVideoUrl(String channelId) {
		Document doc;
		try {
			doc = Jsoup.connect("https://www.youtube.com/channel/"
					+channelId+"/shorts").get();
			Elements links = doc.select("script");
			String jsonString=null;
			for(Element element : links) {
				if(element.data().contains("var ytInitialData")) {
					jsonString = element.data().substring(20,element.data().length()-1);
					break;
				}
			}
			JSONParser parser = new JSONParser();
			JSONObject jsonObject = (JSONObject) parser.parse(jsonString);
			jsonObject = (JSONObject) jsonObject.get("contents");
			jsonObject = (JSONObject) jsonObject.get("twoColumnBrowseResultsRenderer");
			JSONArray jsonArray = (JSONArray) jsonObject.get("tabs");
			boolean check = false;
			for(int i = 0; i<jsonArray.size()-1;i++) {
				JSONObject obj = (JSONObject) jsonArray.get(i);
				//aws 서버는 ショート로 일본어로나온 한국은 Shorts
				if(((JSONObject)obj.get("tabRenderer")).get("title").equals("ショート")) {
					check=true;
					jsonObject = (JSONObject) ((JSONObject)obj.get("tabRenderer")).get("content");
				}
			}
			if(check) {
				jsonObject = (JSONObject) jsonObject.get("richGridRenderer");		
				jsonArray = (JSONArray) jsonObject.get("contents");	
				jsonObject = (JSONObject) jsonArray.get(0);
				jsonObject = (JSONObject) jsonObject.get("richItemRenderer");
				jsonObject = (JSONObject) jsonObject.get("content");	
				jsonObject = (JSONObject) jsonObject.get("reelItemRenderer");
				return jsonObject.get("videoId").toString();
			}
			return "";
		} catch (IOException e) {
			e.printStackTrace();
			return "";
		} catch (org.json.simple.parser.ParseException e) {
			e.printStackTrace();
			return "";
		} catch (Exception e) {
			e.printStackTrace();
			return "";
		}
	}
	public void getKirinuki() {
		String videoIds="";
		for(int i = 0;i<kirinukiList.size();i++) {
			String videoId = returnVideoUrl(kirinukiList.get(i).getYoutubeUrl());
			String shortVideoId = returnShortVideoUrl(kirinukiList.get(i).getYoutubeUrl());		
			try {
				videoId = dbc.KirinukiVideoCheck(videoId);
				shortVideoId = dbc.KirinukiVideoCheck(shortVideoId);
			} catch (SQLException e) {
				return;
			}
			if(!videoId.equals(""))
				videoIds+=videoId+",";
			if(!shortVideoId.equals(""))
				videoIds+=shortVideoId+",";
		}
		if(!videoIds.equals("")) {
			videoIds=videoIds.substring(0,videoIds.length()-1);
			String jsonString;
			ObjectMapper mapper = new ObjectMapper();
			LiveModel model = null;
			try {
				jsonString = YoutubeDataApi.getKirinukiVideo(videoIds);
				model = mapper.readValue(jsonString, LiveModel.class);
			} catch (IOException e) {
				return;
			}		
			for(com.anyholo.model.live.Item item: model.getItems()) {
				String time = convertTime(item.getSnippet().getPublishedAt());
				KirinukiVideo k;
				Pattern pattern = Pattern.compile("(#)(.*)");
				Matcher matcher = pattern.matcher(item.getSnippet().getDescription());
				String tag="";
				while (matcher.find()) { 
					if(!matcher.group(0).contains("】")) {
						if(matcher.group(0).contains(",")||matcher.group(0).contains(" ")) {
							for(String y : matcher.group(0).replace(",", "").replace(" ","").split("#"))
								if(!y.equals(""))
									tag+=y+";";
						}
						else {
							tag+=(matcher.group(0).replace("#", "").replace(" ", ""))+";";
						}
					}
					if(matcher.group(0) ==  null)
						break;
				}//이걸로 #tag 가져올 수 있음
				if(item.getSnippet().getThumbnails().getMaxres()!=null) {
					k = new KirinukiVideo(item.getId(),
							item.getSnippet().getTitle(),
							item.getSnippet().getThumbnails().getMaxres().getUrl(),
							tag,
							time,
							"",
							item.getSnippet().getChannelId());
				}else if(item.getSnippet().getThumbnails().getStandard()!=null){
					k = new KirinukiVideo(item.getId(),
							item.getSnippet().getTitle(),
							item.getSnippet().getThumbnails().getStandard().getUrl(),
							tag,
							time,
							"",
							item.getSnippet().getChannelId());
				}
				else if(item.getSnippet().getThumbnails().getHigh()!=null){
					k = new KirinukiVideo(item.getId(),
							item.getSnippet().getTitle(),
							item.getSnippet().getThumbnails().getHigh().getUrl(),
							tag,
							time,
							"",
							item.getSnippet().getChannelId());
				}
				else if(item.getSnippet().getThumbnails().getMedium()!=null){
					k = new KirinukiVideo(item.getId(),
							item.getSnippet().getTitle(),
							item.getSnippet().getThumbnails().getMedium().getUrl(),
							tag,
							time,
							"",
							item.getSnippet().getChannelId());
				}
				else {
					k = new KirinukiVideo(item.getId(),
							item.getSnippet().getTitle(),
							item.getSnippet().getThumbnails().getDefault().getUrl(),
							tag,
							time,
							"",
							item.getSnippet().getChannelId());
				}
				if(!tag.equals("")) {
					for(int i=0;i<memberList.size();i++) {
						for(String s : memberList.get(i).getSearchKrName().split(";")) {
							if(tag.contains(s)) {
								k.setTag(k.getTag()+memberList.get(i).getSearchKrName()+";");
								if(!k.getCountry().contains(memberList.get(i).getCountry())) {
									k.setCountry(k.getCountry()+memberList.get(i).getCountry());
									break;
								}
							}
						}
					}
				}
				dbc.KirinukiVideoInsert(k);
			}
		}
	}
	public void getKirinukiInitialization(String url) throws SQLException, IOException {
		String jsonString = YoutubeDataApi.getKirinukiInitialValue(url);
		ObjectMapper mapper = new ObjectMapper();
		KirinukiModel model = mapper.readValue(jsonString, KirinukiModel.class);
		/*if(model.getNextPageToken()!=null) {
			getKirinukiInitialization(url, model.getNextPageToken());
		}*/
		for(com.anyholo.model.kirinuki.Item item: model.getItems()) {
			String time = convertTime(item.getSnippet().getPublishedAt());
			KirinukiVideo k;
			Pattern pattern = Pattern.compile("(#)(.*)");
			Matcher matcher = pattern.matcher(item.getSnippet().getDescription());
			String tag="";
			while (matcher.find()) { 
				if(!matcher.group(0).contains("】")) {
					if(matcher.group(0).contains(",")||matcher.group(0).contains(" ")) {
						for(String y : matcher.group(0).replace(",", "").replace(" ","").split("#"))
							if(!y.equals(""))
								tag+=y+";";
					}
					else {
						tag+=(matcher.group(0).replace("#", "").replace(" ", ""))+";";
					}
				}
				if(matcher.group(0) ==  null)
					break;
			}//이걸로 #tag 가져올 수 있음
			if(item.getSnippet().getThumbnails().getMaxres()!=null) {
				k = new KirinukiVideo(item.getSnippet().getResourceId().getVideoId(),
						item.getSnippet().getTitle(),
						item.getSnippet().getThumbnails().getMaxres().getUrl(),
						tag,
						time,
						"",
						item.getSnippet().getChannelId());
			}else if(item.getSnippet().getThumbnails().getStandard()!=null){
				k = new KirinukiVideo(item.getSnippet().getResourceId().getVideoId(),
						item.getSnippet().getTitle(),
						item.getSnippet().getThumbnails().getStandard().getUrl(),
						tag,
						time,
						"",
						item.getSnippet().getChannelId());
			}
			else if (item.getSnippet().getThumbnails().getHigh()!=null){
				k = new KirinukiVideo(item.getSnippet().getResourceId().getVideoId(),
						item.getSnippet().getTitle(),
						item.getSnippet().getThumbnails().getHigh().getUrl(),
						tag,
						time,
						"",
						item.getSnippet().getChannelId());
			}
			else if(item.getSnippet().getThumbnails().getMedium()!=null){
				k = new KirinukiVideo(item.getId(),
						item.getSnippet().getTitle(),
						item.getSnippet().getThumbnails().getMedium().getUrl(),
						tag,
						time,
						"",
						item.getSnippet().getChannelId());
			}
			else {
				k = new KirinukiVideo(item.getId(),
						item.getSnippet().getTitle(),
						item.getSnippet().getThumbnails().getDefault().getUrl(),
						tag,
						time,
						"",
						item.getSnippet().getChannelId());
			}
			if(!tag.equals("")) {
				for(int i=0;i<memberList.size();i++) {
					for(String s : memberList.get(i).getSearchKrName().split(";")) {
						if(tag.contains(s)) {
							k.setTag(k.getTag()+memberList.get(i).getSearchKrName()+";");
							if(!k.getCountry().contains(memberList.get(i).getCountry())) {
								k.setCountry(k.getCountry()+memberList.get(i).getCountry());
								break;
							}
						}
					}
				}
			}
			dbc.KirinukiVideoInsert(k);
		}
	}
	public void getKirinukiInitialization(String channelId, String nextToken) throws IOException, SQLException {
		String jsonString = YoutubeDataApi.getKirinukiInitialValue(channelId, nextToken);
		ObjectMapper mapper = new ObjectMapper();
		KirinukiModel model = mapper.readValue(jsonString, KirinukiModel.class);
		if(model.getNextPageToken()!=null) {
			getKirinukiInitialization(channelId,model.getNextPageToken());
		}
		for(com.anyholo.model.kirinuki.Item item: model.getItems()) {
			String time = convertTime(item.getSnippet().getPublishedAt());
			KirinukiVideo k;
			Pattern pattern = Pattern.compile("(#)(.*)");
			Matcher matcher = pattern.matcher(item.getSnippet().getDescription());
			String tag="";
			while (matcher.find()) { 
				if(!matcher.group(0).contains("】")) {
					if(matcher.group(0).contains(",")||matcher.group(0).contains(" ")) {
						for(String y : matcher.group(0).replace(",", "").replace(" ","").split("#"))
							if(!y.equals(""))
								tag+=y+";";
					}
					else {
						tag+=(matcher.group(0).replace("#", "").replace(" ", ""))+";";
					}
				}
				if(matcher.group(0) ==  null)
					break;
			}//이걸로 #tag 가져올 수 있음
			if(item.getSnippet().getThumbnails().getMaxres()!=null) {
				k = new KirinukiVideo(item.getSnippet().getResourceId().getVideoId(),
						item.getSnippet().getTitle(),
						item.getSnippet().getThumbnails().getMaxres().getUrl(),
						tag,
						time,
						"",
						item.getSnippet().getChannelId());
			}else if(item.getSnippet().getThumbnails().getStandard()!=null){
				k = new KirinukiVideo(item.getSnippet().getResourceId().getVideoId(),
						item.getSnippet().getTitle(),
						item.getSnippet().getThumbnails().getStandard().getUrl(),
						tag,
						time,
						"",
						item.getSnippet().getChannelId());
			}
			else if (item.getSnippet().getThumbnails().getHigh()!=null){
				k = new KirinukiVideo(item.getSnippet().getResourceId().getVideoId(),
						item.getSnippet().getTitle(),
						item.getSnippet().getThumbnails().getHigh().getUrl(),
						tag,
						time,
						"",
						item.getSnippet().getChannelId());
			}
			else if(item.getSnippet().getThumbnails().getMedium()!=null){
				k = new KirinukiVideo(item.getId(),
						item.getSnippet().getTitle(),
						item.getSnippet().getThumbnails().getMedium().getUrl(),
						tag,
						time,
						"",
						item.getSnippet().getChannelId());
			}
			else {
				k = new KirinukiVideo(item.getId(),
						item.getSnippet().getTitle(),
						item.getSnippet().getThumbnails().getDefault().getUrl(),
						tag,
						time,
						"",
						item.getSnippet().getChannelId());
			}
			if(!tag.equals("")) {
				for(int i=0;i<memberList.size();i++) {
					for(String s : memberList.get(i).getSearchKrName().trim().split(";")) {
						if(tag.contains(s)) {
							k.setTag(k.getTag()+memberList.get(i).getSearchKrName()+";");
							if(!k.getCountry().contains(memberList.get(i).getCountry())) {
								k.setCountry(k.getCountry()+memberList.get(i).getCountry());
								break;
							}
						}
					}
				}
			}
			dbc.KirinukiVideoInsert(k);
		}
	}

	public String convertTime(String time) {
		SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'", Locale.US);
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");			    
		TimeZone utcZone = TimeZone.getTimeZone("UTC");
		sf.setTimeZone(utcZone);
		Date date = null;
		try {
			date = sf.parse(time);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		String converttime = sdf.format(date);
		return converttime;
	}

	public HashMap<String,ArrayList<String>> getMideaURL(TweetList tl) {
		HashMap<String,ArrayList<String>> midea = new HashMap<String,ArrayList<String>>();
		if(tl.getIncludes().getMedia()!=null) {
			for(int i=0;i<tl.getIncludes().getMedia().size();i++) {
				ArrayList<String> type_url = new ArrayList<>();
				type_url.add(tl.getIncludes().getMedia().get(i).getType());
				if(tl.getIncludes().getMedia().get(i).getType().equals("photo"))
					type_url.add(tl.getIncludes().getMedia().get(i).getUrl());
				else if(tl.getIncludes().getMedia().get(i).getType().equals("video"))
					type_url.add(tl.getIncludes().getMedia().get(i).getPreviewImageUrl());
				else if(tl.getIncludes().getMedia().get(i).getType().equals("animated_gif"))
					type_url.add(tl.getIncludes().getMedia().get(i).getPreviewImageUrl());
				midea.put(tl.getIncludes().getMedia().get(i).getKey(),type_url);
			}
		}
		return midea;
	}
	public void getTweet(TweetList Tweets,List<Tweet> tweetList, HashMap<String,ArrayList<String>> midea) {
		if(Tweets!=null) {
			if(Tweets.getIncludes()!=null) {
				if(Tweets.getIncludes().getMedia()!=null) {
					midea.putAll(getMideaURL(Tweets));
				}
			}
			if(Tweets.getData()!=null) {
				for(int i=0;i<Tweets.getData().size();i++) { // 리트윗한 트윗 내용
					TweetData td = Tweets.getData().get(i);
					String time = td.getCreatedAt().plusHours(9).toString();
					time=time.replace("T"," ");
					int number = 0;
					for(Member m : memberList) {
						if(m.getTwitterId().equals(td.getUser().getId())) {
							number = m.getNumber();
							break;
						}
					}
					Tweet t = null;
					if(td.getText().contains("https://t.co/")) {
						t = new Tweet(
								td.getId(),
								td.getUser().getDisplayedName(),
								td.getUser().getProfileImageUrl(),
								td.getText().substring(0,td.getText().indexOf("https://t.co/")),
								td.getTweetType().toString(),
								td.getInReplyToStatusId(),
								null,
								null,
								time, number);
					}else {
						t = new Tweet(
								td.getId(),
								td.getUser().getDisplayedName(),
								td.getUser().getProfileImageUrl(),
								td.getText(),
								td.getTweetType().toString(),
								td.getInReplyToStatusId(),
								null,
								null,
								time, number);
					}
					if(td.getAttachments()!=null) {		
						String url="";
						if(td.getAttachments().getMediaKeys()!=null) {
							for(String key : td.getAttachments().getMediaKeys()){
								if(midea.get(key)!=null)
									url += midea.get(key).get(1)+";";
							}
							if(!url.equals("")) {
								url=url.substring(0,url.length()-1);
								t.setMediaURL(url);
								t.setMediaType(midea.get(td.getAttachments().getMediaKeys()[0]).get(0));
							}
						}
					}
					tweetList.add(t);
				}
			}
		}
	}
	public void get7daysTweet() throws StreamReadException, DatabindException, IOException {
		TwitterClient twitterClient = null;
		twitterClient = TwitterApi.getTwitterClient();
		for(int j = 0; j<memberList.size();j++) {
			TweetList timeline = twitterClient.getUserTimeline(memberList.get(j).getTwitterId(),
					AdditionalParameters.builder().startTime(LocalDateTime.now().minusDays(1).minusHours(9).minusMinutes(1)).endTime(LocalDateTime.now().minusHours(9)).build());
			HashMap<String,ArrayList<String>> midea = new HashMap<String,ArrayList<String>>();
			List<Tweet> tweetList = new ArrayList<>();
			List<String> rtIds = new ArrayList<>(); // 리트윗한 트윗의 아이디들
			List<String> quIds = new ArrayList<>(); // 인용된 트윗의 아이디들(인용 == 공유)
			List<String> reIds = new ArrayList<>(); //리플라이된 트윗의 아이디들
			for(int i=0;i<timeline.getData().size();i++) {
				TweetData td = timeline.getData().get(i);
				if(td.getTweetType().equals(TweetType.RETWEETED)) {
					rtIds.add(td.getInReplyToStatusId());
				}
				else if(td.getTweetType().equals(TweetType.QUOTED)) {
					quIds.add(td.getInReplyToStatusId());
				}
				else if(td.getTweetType().equals(TweetType.REPLIED_TO)) {
					reIds.add(td.getInReplyToStatusId());
				}
			}

			TweetList rtTweet = null; //RT 트윗
			TweetList quTweet = null; //인용 트윗
			TweetList reTweet = null; //replied 트윗
			if(rtIds.size()!=0) {
				rtTweet = twitterClient.getTweets(rtIds);
			}
			if(quIds.size()!=0) {
				quTweet = twitterClient.getTweets(quIds);
			}
			if(reIds.size()!=0) {
				reTweet = twitterClient.getTweets(reIds);
			}
			getTweet(rtTweet,tweetList,midea);
			getTweet(quTweet,tweetList,midea);
			getTweet(reTweet,tweetList,midea);
			getTweet(timeline,tweetList,midea);

			for(int i=0;i<tweetList.size();i++) {
				dbc.TweetDataInsert(tweetList.get(i));
			}
		}
	}
	public void getTweet() throws SQLException, StreamReadException, DatabindException, IOException {
		TwitterClient twitterClient = null;
		twitterClient = TwitterApi.getTwitterClient();
		for(int i = 0; i<memberList.size();i++) {
			TweetList timeline = twitterClient.getUserTimeline(memberList.get(i).getTwitterId(),
					AdditionalParameters.builder().startTime(LocalDateTime.now().minusHours(9).minusMinutes(1)).endTime(LocalDateTime.now().minusHours(9)).build());
			//1133215093246664706페코라1063337246231687169아쿠아1283653858510598144칼리1234752200145899520리스
			//1458498136117489665내꺼
			HashMap<String,ArrayList<String>> midea = new HashMap<String,ArrayList<String>>();
			List<Tweet> tweetList = new ArrayList<>();
			List<String> rtIds = new ArrayList<>(); // 리트윗한 트윗의 아이디들
			List<String> quIds = new ArrayList<>(); // 인용된 트윗의 아이디들(인용 == 공유)
			List<String> reIds = new ArrayList<>(); //리플라이된 트윗의 아이디들
			for(int j=0;j<timeline.getData().size();j++) {
				TweetData td = timeline.getData().get(j);
				if(td.getTweetType().equals(TweetType.RETWEETED)) {
					rtIds.add(td.getInReplyToStatusId());
				}
				else if(td.getTweetType().equals(TweetType.QUOTED)) {
					quIds.add(td.getInReplyToStatusId());
				}
				else if(td.getTweetType().equals(TweetType.REPLIED_TO)) {
					reIds.add(td.getInReplyToStatusId());
				}
			}

			TweetList rtTweet = null; //RT 트윗
			TweetList quTweet = null; //인용 트윗
			TweetList reTweet = null; //replied 트윗
			if(rtIds.size()!=0) {
				rtTweet = twitterClient.getTweets(rtIds);
			}
			if(quIds.size()!=0) {
				quTweet = twitterClient.getTweets(quIds);
			}
			if(reIds.size()!=0) {
				reTweet = twitterClient.getTweets(reIds);
			}
			getTweet(rtTweet,tweetList,midea);
			getTweet(quTweet,tweetList,midea);
			getTweet(reTweet,tweetList,midea);
			getTweet(timeline,tweetList,midea);

			for(int j=0;j<tweetList.size();j++) {
				/*System.out.println("트윗 ID : "+tweetList.get(i).getTweetID());
				System.out.println("닉네임 : "+tweetList.get(i).getWriteUserName());
				System.out.println("유저 프로필 : "+tweetList.get(i).getUserProfileURL());
				System.out.println("number : "+tweetList.get(i).getNumber());
				System.out.println("내용 : "+tweetList.get(i).getTweetContent());
				System.out.println("트윗 타입 : "+tweetList.get(i).getTweetType());
				System.out.println("미디어 타입 : "+tweetList.get(i).getMediaType());
				System.out.println("미디어 URL : "+tweetList.get(i).getMediaURL());
				System.out.println("다음 트윗 ID : "+tweetList.get(i).getPrevTweetID());
				System.out.println("트윗이 언제 써졌나 : "+tweetList.get(i).getWriteDate());
				System.out.println("---------------------------------------");*/
				dbc.TweetDataInsert(tweetList.get(j));
			}			
		}
	}
	public void ResetKirinukiVideo() throws SQLException, IOException {
		for(int i = 0; i< kirinukiList.size();i++)
			getKirinukiInitialization(kirinukiList.get(i).getYoutubeUrl());
	}
	public void InitialMemberData() throws SQLException {
		dbc.MemberDataInsert(new Member(0,"","","","","","",""));//넣고싶은 값 넣으면 됨
	}
	public void InitialMemberOnAir() throws SQLException {
		for(Member m : memberList)
			dbc.MemberOnAirInsert(new MemberOnAir(m.getNumber(), "default", "default", "default", "default"));
	}
}
