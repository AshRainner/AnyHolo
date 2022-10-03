package com.anyholo.main;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.select.Elements;

import com.anyholo.api.YoutubeDataApi;
import com.anyholo.db.DBController;
import com.anyholo.model.data.Member;
import com.anyholo.model.live.LiveModel;
import com.anyholo.model.profile.Item;
import com.anyholo.model.profile.ProfileModel;
import com.fasterxml.jackson.databind.ObjectMapper;

public class DataManagement {
	private final static String API_KEY = "AIzaSyADYWApy4Z5VvjrCc2j5BCtRX2VjX2zIvs";//발급받은 API 키값
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
			"UCsUj0dszADCGbF3gNrQEuSQ","UCO_aKKYxn4tvrqPjcTzZ6EQ","UCmbs8T6MWqUHP1tIQvSgKrg","UC3n5uGu18FoCy23ggWWp8tA","UCgmPnx-EEeOrZSg5Tiw7ZRQ",//EN2기
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
			"Sana","Fauna","Kronii","Mumei","Baelz",//EN2기생
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
			"tsukumosana","ceresfauna","ourokronii","nanashimumei_en","hakosbaelz",
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
			"tsukumo-sana","ceres-fauna","ouro-kronii","nanashi-mumei","hakos-baelz",
			"ayunda-risu","moona-hoshinova","airani-iofifteen",
			"kureiji-ollie","anya-melfissa","pavolia-reine",
			"vestia-zeta","kaela-kovalskia","kobo-kanaeru"
	};
	private String[] KRName={//멤버들의 한국식 이름
			"소라","로보코","아즈키","미코","스이세이",
			"멜","아키로젠탈","하아토","후부키","마츠리",
			"아쿠아","시온","아야메","쵸코","스바루",
			"미오","오카유","코로네",
			"페코라","후레아","노엘","마린",
			"카나타","와타메","토와","루나",
			"라미","네네","보탄","폴카",
			"라플라스","루이","코요리","클로에","이로하",
			"칼리오페","키아라","이나니스","구라","아멜리아",
			"아이리스",
			"사나","파우나","크로니","무메이","벨즈",
			"리스","무나","이오피프틴",
			"올리","아냐","레이네",
			"제타","카엘라","코보"
	};
	private List<Member> list = new ArrayList<Member>();
	public void InitialValue() {//초기값 설정
		try {
			String channelIds="";
			for(int i=0;i<50;i++)
				channelIds+=channelId[i]+",";
			channelIds=channelIds.substring(0,channelIds.length()-1);
			//채널 아이디 50개를 한번에 검색하기 위해 합치기
			// 50개인 이유는 api에서 한번에 검색가능한 수가 50개라서
			String jsonString =	YoutubeDataApi.getProfileJSon
					(channelIds,API_KEY);
			//System.out.println(jsonObject.toJSONString());
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
				list.add(new Member(KRName[index],
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
			jsonString = YoutubeDataApi.getProfileJSon(channelIds, API_KEY);
			items = mapper.readValue(jsonString, ProfileModel.class).getItems();
			for(int i=50;i<channelId.length;i++) {
				int index = getIndex(items.get(i-50));
				String country="ID";
				Item temp = items.get(i-50);
				list.add(new Member(KRName[index],
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
				String jsonString = YoutubeDataApi.getLiveJSon(liveids, API_KEY);
				ObjectMapper mapper = new ObjectMapper();
				List<com.anyholo.model.live.Item> items = mapper.readValue(jsonString, LiveModel.class).getItems();
				for(int i=0;i<items.size();i++) {
					int index = getIndex(items.get(i));
					if(items.get(i).getSnippet().getLiveBroadcastContent().equals("live")) {
						list.get(index).setOnAir("live");
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
					/*else {
						System.out.println(list.get(i).getMemberName()+"\n");
					}*/
					check[i]=false;
				}
			}
			for(int i=0;i<channelId.length;i++) {
					/*System.out.println(list.get(i).getMemberName());
					System.out.println(list.get(i).getImageUrl());
					System.out.println(list.get(i).getOnAirVideoUrl());*/
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
}
