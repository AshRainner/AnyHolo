package com.anyholo.main;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.ZonedDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.TimeZone;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.select.Elements;

import com.anyholo.api.TwitterApi;
import com.anyholo.api.YoutubeDataApi;
import com.anyholo.db.DBController;
import com.anyholo.model.data.Kirinuki;
import com.anyholo.model.data.Member;
import com.anyholo.model.data.Tweet;
import com.anyholo.model.kirinuki.KirinukiModel;
import com.anyholo.model.live.LiveModel;
import com.anyholo.model.profile.Item;
import com.anyholo.model.profile.ProfileModel;
import com.fasterxml.jackson.core.exc.StreamReadException;
import com.fasterxml.jackson.databind.DatabindException;
import com.fasterxml.jackson.databind.ObjectMapper;

import io.github.redouane59.twitter.TwitterClient;
import io.github.redouane59.twitter.dto.endpoints.AdditionalParameters;
import io.github.redouane59.twitter.dto.tweet.TweetList;
import io.github.redouane59.twitter.dto.tweet.TweetType;
import io.github.redouane59.twitter.dto.tweet.TweetV2.TweetData;

public class DataManagement {
	private String[] channelId = { // 멤버들의 유튜브 채널 ID
			"UCp6993wxpyDPHUpavwDFqgg","UCDqI2jOz0weumE8s7paEk6g","UC0TXe_LYZ4scaW2XMyi5_kw","UC-hM6YJuNYVAmUWxeIr9FeA","UC5CwaMl1eIgY8h02uZw7u8A",//0기생
			"UCD8HOxPs4Xvsm8H0ZxXGiBw","UCFTLzh12_nrtzqBPsTCqenA","UC1CfXB_kRs3C-zaeTG3oGyg","UCdn5BQ06XqgXoAxIhbqw5Rg","UCQ0UDLQCjY0rmuxCDE38FGg",//1기생
			"UC1opHUrw8rvnsadT-iGp7Cg","UCXTpFs_3PqI41qX2d9tL2Rw","UC7fk0CB07ly8oSl0aqKkqFg","UC1suqwovbL1kzsoaZgFZLKg","UCvzGlP9oQwU--Y0r9id_jnA",//2기생
			"UCp-5t9SrOQwXMU7iIjQfARg","UCvaTdHTWBGv3MKj3KVqJVCw","UChAnqc_AY5_I3Px5dig3X1Q",//게이머즈
			"UC1DCedRgGHBdm81E1llLhOQ","UCvInZx9h3jC2JzsIzoOebWg","UCdyqAaZDKHXg4Ahi7VENThQ","UCCzUftO8KOVkV4wQG1vkUvg",//3기생
			"UCZlDXzGoo7d44bwdNObFacg","UCqm3BQLlJfvkTsX_hvm0UmA","UC1uv2Oq6kNxgATlCiez59hw","UCa9Y57gfeY0Zro_noHRVrnw",//4기생
			"UCFKOVgVbGmX65RxO3EtH3iw","UCAWSyEs_Io8MtpY3m-zqILA","UCUKD-uaobj9jiqB-VXt71mA","UCK9V2B22uJYu3N7eR_BT9QA",//5기생
			"UCENwRMx5Yh42zWpzURebzTw","UCs9_O1tRPMQTHQ-N_L6FU2g","UC6eWCld0KwmyHFbAqK3V-Rw","UCIBY1ollUsauvVi4hW4cumw","UC_vMYWcDjmfdpH6r4TTn1MQ",//6기생
			"UCL_qhgtOy0dy1Agp8vkySQg","UCHsx4Hqa-1ORjQTh9TYDhww","UCMwGHR0BTZuLsmjY_NT5Pwg","UCoSrY_IQQVpmIRZ9Xf-y93g","UCyl1z3jo3XHR1riLFKG5UAg",//EN1기생
			"UC8rcEBzJSleTkf_-agPM20g",//EN 프로젝트 HOPE
			"UCO_aKKYxn4tvrqPjcTzZ6EQ","UCmbs8T6MWqUHP1tIQvSgKrg","UC3n5uGu18FoCy23ggWWp8tA","UCgmPnx-EEeOrZSg5Tiw7ZRQ",//EN2기
			"UCOyYb1c43VlX9rc_lT6NKQw","UCP0BspO_AMEe3aQqqpo89Dg","UCAoy6rzhSf4ydcYjJw3WoVg",//ID1기생
			"UCYz_5n-uDuChHtLo7My1HnQ","UC727SQYUvx5pDDGQpTICNWg","UChgTyjG-pdNvxxhdsXfHQ5Q",//ID2기생
			"UCTvHWSfBZgtxE4sILOaurIQ","UCZLZ8Jjx_RN2CXloOmgTHVg","UCjLEmnpCNeisMxy134KPwWw"//ID3기생
	};
	private String[] memberNameT={//멤버들의 채널 제목에 있는 이름
			"Sora","Roboco","AZKi","Miko","Suisei",//0기생
			"夜空","アキロゼ","HAACHAMA","フブキ","Matsuri",//1기생
			"Aqua","Shion","Ayame","Choco","Subaru",//2기생
			"Mio","Okayu","Korone",//게이머즈
			"Pekora","Flare","Noel","Marine",//3기생
			"Kanata","Watame","Towa","Luna",//4기생
			"Lamy","Nene","Botan","Polka",//5기생
			"Laplus","Lui","Koyori","Chloe","Iroha",//6기생
			"Calliope","Kiara","Ina'nis","Gura","Amelia",//EN1기생
			"IRyS",//EN 프로젝트 HOPE
			"Fauna","Kronii","Mumei","Baelz",//EN2기생
			"Risu","Moona","Iofifteen",//ID1기생
			"Ollie","Anya","Reine",//ID2기생
			"Zeta","Kaela","Kobo"//ID3기생
	};
	private String[] twitterUrl = {//각 멤버들의 트위터 아이디
			"tokino_sora","robocosan","AZKi_VDiVA","sakuramiko35","suisei_hosimati",
			"yozoramel","akirosenthal","akaihaato","shirakamifubuki","natsuiromatsuri",
			"minatoaqua","murasakishionch","nakiriayame","yuzukichococh","oozorasubaru",
			"ookamimio","nekomataokayu","inugamikorone",
			"usadapekora","shiranuiflare","shiroganenoel","houshoumarine",
			"amanekanatach","tsunomakiwatame","tokoyamitowa","himemoriluna",
			"yukihanalamy","momosuzunene","shishirobotan","omarupolka",
			"LaplusDarknesss","takanelui","hakuikoyori","sakamatachloe","kazamairohach",
			"moricalliope","takanashikiara","ninomaeinanis","gawrgura","watsonameliaEN",
			"irys_en",
			"ceresfauna","ourokronii","nanashimumei_en","hakosbaelz",
			"ayunda_risu","moonahoshinova","airaniiofifteen",
			"kureijiollie","anyamelfissa","pavoliareine",
			"vestiazeta","kaelakovalskia","kobokanaeru"
	};
	private String[] hololiveUrl = {//멤버들의 홀로라이브 사이트 소개 url
			"tokino-sora","roboco-san","azki","sakuramiko","hoshimachi-suisei",
			"yozora-mel","aki-rosenthal","akai-haato","shirakami-fubuki","natsuiro-matsuri",
			"minato-aqua","murasaki-shion","nakiri-ayame","yuzuki-choco","oozora-subaru",
			"ookami-mio","nekomata-okayu","inugami-korone",
			"usada-pekora","shiranui-flare","shirogane-noel","houshou-marine",
			"amane-kanata","tsunomaki-watame","tokoyami-towa","himemori-luna",
			"yukihana-lamy","momosuzu-nene","shishiro-botan","omaru-polka",
			"la-darknesss","takane-lui","hakui-koyori","sakamata-chloe","kazama-iroha",
			"mori-calliope","takanashi-kiara","ninomae-inanis","gawr-gura","watson-amelia",
			"irys",
			"ceres-fauna","ouro-kronii","nanashi-mumei","hakos-baelz",
			"ayunda-risu","moona-hoshinova","airani-iofifteen",
			"kureiji-ollie","anya-melfissa","pavolia-reine",
			"vestia-zeta","kaela-kovalskia","kobo-kanaeru"
	};
	private String[] Init_KRName={//멤버들의 한국식 이름
			"소라","로보코","아즈키","미코","스이세이",
			"요조라","아키","하아토","후부키","마츠리",
			"아쿠아","시온","아야메","쵸코","스바루",
			"미오","오카유","코로네",
			"페코라","후레아","노엘","마린",
			"카나타","와타메","토와","루나",
			"라미","네네","보탄","폴카",
			"라플라스","루이","코요리","클로에","이로하",
			"칼리오페","키아라","이나니스","구라","아멜리아",
			"아이리스",
			"파우나","크로니","무메이","벨즈",
			"리스","무나","이오피프틴",
			"쿠레이지","아냐","레이네",
			"제타","카엘라","코보"
	};
	private String[] KRName= {
			"토키노소라","로보코","아즈키Azki","사쿠라미코","호시마치스이세이",
			"요조라멜","아키로젠탈","아카이하아토하쨔마","시라카미후부키","나츠이로마츠리",
			"미나토아쿠아","무라사키시온","나키리아야메","유즈키쵸코","오오조라스바루",
			"오오카미미오","네코마타오카유","이누가미코로네",
			"우사다페코라","시라누이후레아","시로가네노엘","호쇼마린",
			"아마네카나타","츠노마키와타메","토코야미토와","히메모리루나",
			"유키하나라미","모모스즈네네","시시로보탄","오마루폴카",		
			"라플라스다크네스","타카네루이","하쿠이코요리","사카마타클로에","카자마이로하",
			"모리칼리오페","타카나시키아라","니노마에이나니스","가우르구라","아멜리아왓슨",
			"아이리스",
			"세레스파우나","오로크로니","나나시무메이","하코스벨즈",
			"아윤다리스","무나호시노바","이오피프틴",
			"쿠레이지올리","아냐멜핏사","아이라니이오피프틴",
			"베스티아제타","코발스키아카엘라","코보카나에루"
	};
	private String[] TwitterId= {
			"880317891249188864", "960340787782299648", "1062499145267605504", "979891380616019968", "97527587867340800",
			"985703615758123008", "996643748862836736", "998336069992001537", "997786053124616192", "996645451045617664",
			"1024528894940987392", "1024533638879166464", "1024532356554608640", "1024970912859189248", "1027853566780698624",
			"1063337246231687169", "1109751762733301760", "1109748792721432577",
			"1133215093246664706", "1154304634569150464", "1153195295573856256", "1153192638645821440",
			"1200396304360206337", "1200397643479805957", "1200357161747939328", "1200396798281445376",
			"1255013740799356929", "1255017971363090432", "1255015814979186689", "1270551806993547265",
			"1433657158067896325", "1433660866063339527", "1433667543806267393", "1433669866406375432", "1434755250049589252",//JP6
			"1283653858510598144", "1283646922406760448", "1283650008835743744", "1283657064410017793", "1283656034305769472",
			"1363705980261855232",
			"1409784760805650436", "1409817096523968513", "1409817941705515015", "1409783149211443200",
			"1234752200145899520", "1234753886520393729", "1235180878449397764",
			"1328277233492844544", "1328277750000492545", "1328275136575799297",
			"1486633489101307907", "1486636197908602880", "1486629076005634049"			
	};
	private List<Member> list = new ArrayList<Member>();
	public void InitialValue() {//초기값 설정
		try {
			YoutubeDataApi.setKey();
			String channelIds="";
			for(int i=0;i<50;i++)
				channelIds+=channelId[i]+",";
			channelIds=channelIds.substring(0,channelIds.length()-1);
			//채널 아이디 50개를 한번에 검색하기 위해 합치기
			// 50개인 이유는 api에서 한번에 검색가능한 수가 50개라서
			String jsonString =	YoutubeDataApi.getProfileJSon
					(channelIds);
			ObjectMapper mapper = new ObjectMapper();
			List<Item> items = mapper.readValue(jsonString, ProfileModel.class).getItems();
			for(int i=0;i<50;i++) {
				int index = getIndex(items.get(i));
				String country;
				if(index<35)
					country="JP";
				else if(index<46)
					country="EN";
				else
					country="ID";
				Item temp = items.get(i);
				list.add(new Member(Init_KRName[index],
						temp.getSnippet().getThumbnails().getHigh().getUrl(),
						country,
						"default",
						temp.getSnippet().getDescription(),
						"default","default","default",
						temp.getId(),
						twitterUrl[index],
						hololiveUrl[index],
						index));
			}
			channelIds="";
			for(int i=50;i<channelId.length;i++)
				channelIds+=channelId[i]+",";
			channelIds=channelIds.substring(0,channelIds.length()-1);
			//50개를 넘어간 나머지
			jsonString = YoutubeDataApi.getProfileJSon(channelIds);
			items = mapper.readValue(jsonString, ProfileModel.class).getItems();
			for(int i=50;i<channelId.length;i++) {
				int index = getIndex(items.get(i-50));
				String country="ID";
				Item temp = items.get(i-50);
				list.add(new Member(Init_KRName[index],
						temp.getSnippet().getThumbnails().getHigh().getUrl(),
						country,
						"default",
						temp.getSnippet().getDescription(),
						"default","default","default",
						temp.getId(),
						twitterUrl[index],
						hololiveUrl[index],
						index));
			}
			/*
			for(int i=0;i<channelId.length;i++) {
				DBController.InitialValueInsert(list.get(i), KRName[list.get(i).getNumber()]);
			}
			//db처음에 넣을때 사용한거*/
			Collections.sort(list);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	public void LiveConfirm() {
		boolean[] check = new boolean[55];
		try {//web페이지를 파싱해서 live여부를 확인 할당량을 아끼기위해 사용함
			String liveids="";
			for(int i=0;i<channelId.length;i++) {
				Document doc = Jsoup.connect("https://www.youtube.com/channel/"
						+channelId[i]+"/live").get();
				String temp="";
				Elements links = doc.select("link[rel=\"canonical\"]");
				if(links.attr("href").contains("watch")) {
					liveids+=(links.attr("href").substring(32))+",";
				}
			}
			if(liveids!="") {
				liveids=liveids.substring(0,liveids.length()-1);
				String jsonString = YoutubeDataApi.getLiveJSon(liveids);
				ObjectMapper mapper = new ObjectMapper();
				String Day2Later = ZonedDateTime.now().plusDays(2).format(DateTimeFormatter.ISO_INSTANT);
				List<com.anyholo.model.live.Item> items = mapper.readValue(jsonString, LiveModel.class).getItems();
				for(int i=0;i<items.size();i++) {
					int index = getIndex(items.get(i));
					if(items.get(i).getSnippet().getLiveBroadcastContent().equals("live")||
							items.get(i).getSnippet().getLiveBroadcastContent().equals("upcoming")&&
							items.get(i).getLiveStreamingDetails().getScheduledStartTime().compareTo(Day2Later)<=0) {
						list.get(index).setOnAir(items.get(i).getSnippet().getLiveBroadcastContent());
						list.get(index).setOnAirthumnailsUrl(items.get(i).getSnippet().getThumbnails().getMedium().getUrl());
						list.get(index).setOnAirTitle(items.get(i).getSnippet().getTitle());
						list.get(index).setOnAirVideoUrl("https://www.youtube.com/watch?v="+items.get(i).getId());
						check[index]=true;
					}
				}
				for(int i=0;i<channelId.length;i++) {
					if(!check[i]) {
						list.get(i).setOnAir("default");
						list.get(i).setOnAirthumnailsUrl("default");
						list.get(i).setOnAirTitle("default");
						list.get(i).setOnAirVideoUrl("default");
					}
					check[i]=false;
				}
			}
			for(int i=0;i<channelId.length;i++) {
				DBController.DBUpdate(list.get(i));
			}
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	private int getIndex(Item item) {//api에서 불러온 값이 순서대로가 아니라 순서를 확인해줄 index
		for(int i=0;i<memberNameT.length;i++) {
			if(item.getSnippet().getTitle().contains(memberNameT[i])) {
				return i;
			}
		}
		return 0;
	}
	private int getIndex(com.anyholo.model.live.Item item) {//api에서 불러온 값이 순서대로가 아니라 순서를 확인해줄 index
		for(int i=0;i<memberNameT.length;i++) {
			if(item.getSnippet().getChannelTitle().contains(memberNameT[i])) {
				return i;
			}
		}
		return 0;
	}
	public void getKirinuki(String channel_id) {
		try {
			String jsonString = YoutubeDataApi.getKirinukiInitialValue(channel_id);
			ObjectMapper mapper = new ObjectMapper();
			KirinukiModel model = mapper.readValue(jsonString, KirinukiModel.class);
			if(model.getNextPageToken()!=null) {
				getKirinuki(channel_id,model.getNextPageToken());
			}
			for(com.anyholo.model.kirinuki.Item item: model.getItems()) {
				String time = convertTime(item.getSnippet().getPublishedAt());
				Kirinuki k;
				String country; // jp,en,id
				if(item.getSnippet().getThumbnails().getMaxres()!=null) {
					k = new Kirinuki(item.getSnippet().getResourceId().getVideoId(),
							item.getSnippet().getChannelTitle(),
							item.getSnippet().getThumbnails().getMaxres().getUrl(),
							item.getSnippet().getTitle(),
							item.getSnippet().getDescription(),
							"",
							time);
				}else {
					k = new Kirinuki(item.getSnippet().getResourceId().getVideoId(),
							item.getSnippet().getChannelTitle(),
							item.getSnippet().getThumbnails().getHigh().getUrl(),
							item.getSnippet().getTitle(),
							item.getSnippet().getDescription(),
							"",
							time);
				}
				for(int i=0;i<KRName.length;i++) {
					if(i<35&&k.getTag().contains(KRName[i])) {
						k.setCountry("JP");
						i=35;
					}else if(i<45&&k.getTag().contains(KRName[i])) {
						k.setCountry(k.getCountry()+"EN");
						i=45;
					}else if(i<KRName.length&&k.getTag().contains(KRName[i])) {
						k.setCountry(k.getCountry()+"ID");
						break;
					}
				}
				DBController.KirinukiInsert(k);
			}
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	public void getLength() {
		System.out.println("채널 아디 : "+channelId.length);
		System.out.println("멤버 네임 t : "+memberNameT.length);
		System.out.println("twitterUrl : "+twitterUrl.length);
		System.out.println("hololive Url : "+hololiveUrl.length);
		System.out.println("KRName : "+KRName.length);
		System.out.println("TwitterId : "+TwitterId.length);
	}
	public void getKirinuki(String channel_id,String nextToken) {
		try {
			String jsonString = YoutubeDataApi.getKirinukiInitialValue(channel_id,nextToken);
			ObjectMapper mapper = new ObjectMapper();
			KirinukiModel model = mapper.readValue(jsonString, KirinukiModel.class);
			if(model.getNextPageToken()!=null) {
				getKirinuki(channel_id,model.getNextPageToken());
			}
			for(com.anyholo.model.kirinuki.Item item: model.getItems()) {
				String time = convertTime(item.getSnippet().getPublishedAt());
				Kirinuki k;
				if(item.getSnippet().getThumbnails().getMaxres()!=null) {
					k = new Kirinuki(item.getSnippet().getResourceId().getVideoId(),
							item.getSnippet().getChannelTitle(),
							item.getSnippet().getThumbnails().getMaxres().getUrl(),
							item.getSnippet().getTitle(),
							item.getSnippet().getDescription(),
							"",
							time);
				}else {
					k = new Kirinuki(item.getSnippet().getResourceId().getVideoId(),
							item.getSnippet().getChannelTitle(),
							item.getSnippet().getThumbnails().getHigh().getUrl(),
							item.getSnippet().getTitle(),
							item.getSnippet().getDescription(),
							"",
							time);
				}
				for(int i=0;i<KRName.length;i++) {
					if(i<35&&k.getTag().contains(KRName[i])) {
						k.setCountry("JP");
						i=35;
					}else if(i<45&&k.getTag().contains(KRName[i])) {
						k.setCountry(k.getCountry()+"EN");
						i=45;
					}else if(i<KRName.length&&k.getTag().contains(KRName[i])) {
						System.out.println(KRName[i]);
						k.setCountry(k.getCountry()+"ID");
						break;
					}
				}
				DBController.KirinukiInsert(k);
			}
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
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
			String country=null;
			String holo = null;
			for(int i=0;i<Tweets.getData().size();i++) { // 리트윗한 트윗 내용
				TweetData td = Tweets.getData().get(i);
				String time = td.getCreatedAt().plusHours(9).toString();
				time=time.replace("T"," ");
				if(Arrays.asList(TwitterId).contains(td.getUser().getId())) {
					if(Arrays.asList(TwitterId).indexOf(td.getUser().getId())<35) {
						country = "JP";
						holo = "1";
					}
					else if(Arrays.asList(TwitterId).indexOf(td.getUser().getId())<45) {
						country = "EN";
						holo = "1";
					}
					else {
						country = "ID";
						holo = "1";
					}	
				}
				String name = null;
				if(Arrays.asList(TwitterId).indexOf(td.getUser().getId())>=0)
					name = KRName[Arrays.asList(TwitterId).indexOf(td.getUser().getId())];
				Tweet t;
				if(td.getText().contains("https://t.co/")) {
					t = new Tweet(
							td.getId(),
							td.getUser().getDisplayedName(),
							td.getUser().getId(),
							td.getUser().getProfileImageUrl(),
							td.getText().substring(0,td.getText().indexOf("https://t.co/")),//뒤에 붙은 보기 안좋은 url떼서 넣기
							td.getTweetType().toString(),
							td.getInReplyToStatusId(),
							null,
							null,
							time,
							country,
							holo,
							name);
				}else {
					t = new Tweet(
							td.getId(),
							td.getUser().getDisplayedName(),
							td.getUser().getId(),
							td.getUser().getProfileImageUrl(),
							td.getText(),//뒤에 붙은 보기 안좋은 url떼서 넣기td.getText().substring(0,td.getText().indexOf("https://t.co/"))
							td.getTweetType().toString(),
							td.getInReplyToStatusId(),
							null,
							null,
							time,
							country,
							holo,
							name);
				}
				if(td.getAttachments()!=null) {		
					String url="";
					for(String key : td.getAttachments().getMediaKeys()){
						url += midea.get(key).get(1)+";";
					}
					url=url.substring(0,url.length()-1);
					t.setMediaURL(url);
					t.setMediaType(midea.get(td.getAttachments().getMediaKeys()[0]).get(0));
				}
				tweetList.add(t);
			}
		}
	}
	public void getTweet() {
		TwitterClient twitterClient = null;
		try {
			twitterClient = TwitterApi.getTwitterClient();
		} catch (StreamReadException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (DatabindException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}	
		for(int j = 0; j<TwitterId.length;j++) {
			TweetList timeline = twitterClient.getUserTimeline(TwitterId[j],
					AdditionalParameters.builder().startTime(LocalDateTime.now().minusHours(9).minusMinutes(1)).endTime(LocalDateTime.now().minusHours(9)).build());			//1133215093246664706페코라1063337246231687169아쿠아1283653858510598144칼리1234752200145899520리스
			//1458498136117489665내꺼
			/*TweetList timeline = twitterClient.getUserTimeline("1133215093246664706",
				AdditionalParameters.builder().startTime(LocalDateTime.now().minusHours(9).minusDays(1)).endTime(LocalDateTime.now().minusHours(9)).build());*/
			HashMap<String,ArrayList<String>> midea = new HashMap<String,ArrayList<String>>();
			List<Tweet> tweetList = new ArrayList<>();
			/*if(timeline.getIncludes()!=null) {
			midea.putAll(getMideaURL(timeline));
		}*/
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
				/*System.out.println("트윗 ID : "+tweetList.get(i).getTweetID());
				System.out.println("닉네임 : "+tweetList.get(i).getWriteUserName());
				System.out.println("유저 프로필 : "+tweetList.get(i).getUserProfileURL());
				System.out.println("유저 ID : "+tweetList.get(i).getUserID());
				System.out.println("내용 : "+tweetList.get(i).getTweetContent());
				System.out.println("트윗 타입 : "+tweetList.get(i).getTweetType());
				System.out.println("미디어 타입 : "+tweetList.get(i).getMediaType());
				System.out.println("미디어 URL : "+tweetList.get(i).getMediaURL());
				System.out.println("다음 트윗 ID : "+tweetList.get(i).getPrevTweetID());
				System.out.println("트윗이 언제 써졌나 : "+tweetList.get(i).getWriteDate());
				System.out.println("---------------------------------------");*/
				DBController.TweetInsert(tweetList.get(i));
			}			
		}
	
	}
}
