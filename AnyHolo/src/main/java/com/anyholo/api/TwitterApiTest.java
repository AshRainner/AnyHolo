package com.anyholo.api;
import java.sql.ResultSet;
import java.time.LocalDateTime;

import com.anyholo.db.DBController;

import io.github.redouane59.twitter.TwitterClient;
import io.github.redouane59.twitter.dto.endpoints.AdditionalParameters;
import io.github.redouane59.twitter.dto.tweet.Tweet;
import io.github.redouane59.twitter.dto.tweet.TweetList;
import io.github.redouane59.twitter.dto.tweet.TweetV2.MediaEntityV2;
import io.github.redouane59.twitter.dto.tweet.TweetV2.TweetData;
import io.github.redouane59.twitter.signature.TwitterCredentials;
/*
880317891249188864 : 소라
960340787782299648 : 로보코
1062499145267605504 : 아즈키
979891380616019968 : 미코
975275878673408001 : 스이세이
985703615758123008 : 멜
996643748862836736 : 아키로젠탈
998336069992001537 : 하아토
997786053124616192 : 후부키
996645451045617664 : 마츠리
1024528894940987392 : 아쿠아
1024533638879166464 : 시온
1024532356554608640 : 아야메
1024970912859189248 : 쵸코
1027853566780698624 : 스바루
1063337246231687169 : 미오
1109751762733301760 : 오카유
1109748792721432577 : 코로네
1133215093246664706 : 페코라
1154304634569150464 : 후레아
1153195295573856256 : 노엘
1153192638645821440 : 마린
1200396304360206337 : 카나타
1200397643479805957 : 와타메
1200357161747939328 : 토와
1200396798281445376 : 루나
1255013740799356929 : 라미
1255017971363090432 : 네네
1255015814979186689 : 보탄
1270551806993547265 : 폴카
1433657158067896325 : 라플라스
1433660866063339527 : 루이
1433667543806267393 : 코요리
1433669866406375432 : 클로에
1434755250049589252 : 이로하
1283653858510598144 : 칼리오페
1283646922406760448 : 키아라
1283650008835743744 : 이나니스
1283657064410017793 : 구라
1283656034305769472 : 아멜리아
1363705980261855232 : 아이리스
1409819816194576394 : 사나
1409784760805650436 : 파우나
1409817096523968513 : 크로니
1409817941705515015 : 무메이
1409783149211443200 : 벨즈
1234752200145899520 : 리스
1234753886520393729 : 무나
1235180878449397764 : 이오피프틴
1328277233492844544 : 올리
1328277750000492545 : 아냐
1328275136575799297 : 레이네
1486633489101307907 : 제타
1486636197908602880 : 카엘라
1486629076005634049 : 코보
멤버들 트위터 id
808300835000094721 : 내꺼 테스트용
 */
public class TwitterApiTest {
	final static String ACCESS_TOKEN = "808300835000094721-qxnXYKulsArpmrnd8uTn1eVhF4cNyfU";
	final static String ACCESS_TOKEN_SECRET = "LjKFqRS1RuuZWo97Q7hSi7dj8KXBZD1vjgWoiSuNMw5km";
	final static String API_KEY = "4hnZ9ldS375R0DBGtaHQggjTR";
	final static String API_KEY_SECRET = "AWMFuB1jzFbNgwbWjBgXEIB1lISBB43irhnY69P2Awz9QDrfUi";
	public static void main(String[] args) {
		TwitterClient twitterClient = new TwitterClient(TwitterCredentials.builder()
				.accessToken(ACCESS_TOKEN)
				.accessTokenSecret(ACCESS_TOKEN_SECRET)
				.apiKey(API_KEY)
				.apiSecretKey(API_KEY_SECRET)
				.build());
		//리트윗한건 get media로 안가져와짐
		/*TweetList timeline = twitterClient.getUserTimeline("1133215093246664706",
				AdditionalParameters.builder().startTime(LocalDateTime.now().minusDays(1)).endTime(LocalDateTime.now()).build());
//		 TweetList timeline = twitterClient.getUserTimeline("1062499145267605504",
//				 AdditionalParameters.builder().startTime(LocalDateTime.now().minusDays(1)).endTime(LocalDateTime.now()).build());
//		 System.out.println("!");
//		 HashMap<String,ArrayList<String>> midea = new HashMap<String,ArrayList<String>>();
//		 HashMap<String,Tweet> rt = new HashMap<String,Tweet>();
//		 if(timeline.getIncludes().getMedia()!=null) {
//			 for(int i=0;i<timeline.getIncludes().getMedia().size();i++) {
//				 ArrayList<String> type_url = new ArrayList<>();
//				 type_url.add(timeline.getIncludes().getMedia().get(i).getType());
//				 if(timeline.getIncludes().getMedia().get(i).getType().equals("photo"))
//					 type_url.add(timeline.getIncludes().getMedia().get(i).getUrl());
//				 else
//					 type_url.add(timeline.getIncludes().getMedia().get(i).getVariants().get(0).getUrl());	
//				 //System.out.println(timeline.getIncludes().getMedia().get(i).getVariants().get(0).getUrl()); // 비디오 URL
//				 midea.put(timeline.getIncludes().getMedia().get(i).getKey(),type_url);
//			 }
//		 }
//		 System.out.println("---------------------------------------");
//		 List<String> rtids = new ArrayList<>();
//		 for(int i=0;i<timeline.getData().size();i++) {
//			 TweetData td = timeline.getData().get(i);
//			 if(td.getTweetType().equals(TweetType.RETWEETED)) {
//				 rtids.add(td.getInReplyToStatusId());
//				 /*System.out.println("리트윗 트윗 ID : "+rt.getId());
//				System.out.println("리트윗 User ID : "+ rt.getUser().getId());
//				System.out.println("리트윗 TwitType : "+rt.getTweetType());
//				System.out.println("리트윗 TwitProfile : "+ rt.getUser().getProfileImageUrl());
//				System.out.println("리트윗 TwitContent : "+rt.getText());*/
		//			 }
		//
		//		 }
		//		 List<Twit> twits = new ArrayList<Twit>();
		//		 TweetList rts = twitterClient.getTweets(rtids);
		//		 /*Tweet testTwit = twitterClient.getTweet("1579426521269342210");//사진 여러개
		//		System.out.println("TwitID : "+testTwit.getId());
		//		System.out.println("WriteUserName : "+testTwit.getUser().getDisplayedName());
		//		System.out.println("UserID : "+testTwit.getUser().getName());
		//		System.out.println("TwitType : "+testTwit.getTweetType());
		//		System.out.println("TwitContent : "+testTwit.getText());
		//		System.out.println("NextTwitID : "+testTwit.getInReplyToStatusId());
		//		for(int i=0;i<testTwit.getMedia().size();i++) {
		//			System.out.println(testTwit.getMedia().get(i).getUrl());
		//		}
		//		System.out.println("size : "+testTwit.getMedia().size());*/
		//
		//		 for(int i=0;i<rts.getData().size();i++) {
		//			 TweetData td = rts.getData().get(i);
		//			 String time = td.getCreatedAt().toString();
		//			 time=time.replace("T"," ");
		//			 Twit t = new Twit(
		//					 td.getId(),
		//					 td.getUser().getDisplayedName(),
		//					 td.getUser().getProfileImageUrl(),
		//					 td.getUser().getId(),
		//					 td.getText(),
		//					 null,
		//					 td.getTweetType().toString(),
		//					 time,
		//					 td.getInReplyToStatusId(),
		//					 null);
		//			 System.out.println("TwitID : "+td.getId());
		//			 System.out.println("WriteUserName : "+td.getUser().getDisplayedName());
		//			 System.out.println("UserID : "+td.getUser().getName());
		//			 System.out.println("TwitType : "+td.getTweetType());
		//			 System.out.println("TwitContent : "+td.getText());
		//			 System.out.println("NextTwitID : "+td.getInReplyToStatusId());
		//			 System.out.println("WRITEDATE : "+time);
		//			 if(td.getAttachments()!=null) {
		//				 System.out.println("Media Type : "+midea.get(td.getAttachments().getMediaKeys()[0]).get(0));
		//				 System.out.println("TwitImage : "+midea.get(td.getAttachments().getMediaKeys()[0]).get(1));
		//				 t.setMediaURL(midea.get(td.getAttachments().getMediaKeys()[0]).get(1));
		//				 t.setMediaType(midea.get(td.getAttachments().getMediaKeys()[0]).get(0));
		//			 }
		//			 //DBController.TweetInsert(t);
		//			 System.out.println("---------------------------------------");
		//		 }
		//		 for(int i=0;i<timeline.getData().size();i++) {
		//			 TweetData td = timeline.getData().get(i);
		//			 System.out.println("TwitID : "+td.getId());
		//			 System.out.println("WriteUserName : "+td.getUser().getDisplayedName());
		//			 System.out.println("UserID : "+td.getUser().getName());
		//			 System.out.println("TwitType : "+td.getTweetType());
		//			 System.out.println("TwitContent : "+td.getText());
		//			 System.out.println("NextTwitID : "+td.getInReplyToStatusId());
		//			 System.out.println("WRITEDATE : "+td.getCreatedAt());
		//			 if(td.getAttachments()!=null) {
		//				 System.out.println("TwitImage"+midea.get(td.getAttachments().getMediaKeys()[0]));
		//			 }
		//			 System.out.println("---------------------------------------");
		//		 }
		//		 System.out.println(timeline.getData().size());
		//		 //System.out.println(rts.getData().size());
		TweetList timeline = twitterClient.getUserTimeline("808300835000094721",
				AdditionalParameters.builder().startTime(LocalDateTime.now().minusDays(1)).endTime(LocalDateTime.now()).build());
		for(int i=0;i<timeline.getData().size();i++) {
			TweetData td = timeline.getData().get(i);
			String time = td.getCreatedAt().toString();
			time=time.replace("T"," ");
			com.anyholo.model.data.Tweet t = new com.anyholo.model.data.Tweet(
					td.getId(),
					td.getUser().getDisplayedName(),
					td.getUser().getId(),
					td.getUser().getProfileImageUrl(),
					td.getText(),
					td.getTweetType().toString(),
					td.getInReplyToStatusId(),
					null,
					null,
					time,
					null,
					null);
			System.out.println("---------------------------------------");
		}
	}
	/*for(int i = 0; i<timeline.getIncludes().getMedia().size();i++) {
			System.out.println(timeline.getIncludes().getMedia().get(i).getMediaUrl());
			System.out.println(timeline.getIncludes().getMedia().get(i).getKey());//어디 트윗에 있는 것인가
			System.out.println(timeline.getIncludes().getMedia().get(i).getId());
			System.out.println("------------------------------------------------");
		}*/
	/*testlist.add("1578320231076069377");
		testlist.add("1577718845774901249");
		testlist.add("1579399409573691393");
		TweetList test = twitterClient.getTweets(testlist);
		for(int i = 0;i<test.getData().size();i++) {
			TweetData td = test.getData().get(i);
			System.out.println(td.getUser().getDisplayedName()+" : "+td.getUser().getName());
			System.out.println("내용 : "+td.getText());
			//System.out.println(test.getIncludes().getMedia().get(i).getUrl());url 가져오기
		}*/
	/*for(int i =0; i<timeline.getData().size();i++) {
			TweetData td = timeline.getData().get(i);
			System.out.println(td.getUser().getDisplayedName()+" : "+td.getUser().getName());
			System.out.println("내용 : "+td.getText());
			System.out.println("Type : "+td.getTweetType());
			System.out.println("Tweet URL : "+td.getId());
			System.out.println("다음 Tweet : "+td.getInReplyToStatusId());
			System.out.println("다음 Tweet 쓴 사람 id : "+td.getInReplyToUserId());
			System.out.println();
			if(td.getMedia().size()>0) {
				for(int j=0;j<td.getMedia().size();j++)
					System.out.println(td.getMedia().get(j));
			}
			if(td.getAttachments()!=null) {
				System.out.println("get meida key : "+td.getAttachments().getMediaKeys());
				System.out.println(td.getMedia().size());
			}
			if(td.getTweetType().toString().equals("QUOTED")||
					td.getTweetType().toString().equals("REPLIED_TO")) {
				System.out.println("test들감");
				test(td.getInReplyToStatusId(),twitterClient);
			}
			System.out.println("----------------------------------");
		}*/
	/*for(int i =0;i<timeline.getData().size();i++) {
			TweetData td = timeline.getData().get(i);
			if(td.getTweetType().toString().equals("DEFAULT")||
					td.getTweetType().toString().equals("QUOTED")) {
			System.out.println(td.getText());
			System.out.println(td.getId());//게시글 아이디
			System.out.println(td.getInReplyToStatusId());//리트윗한 게시글의 아이디
			System.out.println(td.getSource());//어떤 기기로 작성하였는가
			if(td.getAttachments()!=null)
				System.out.println(td.getAttachments().getMediaKeys().length);//트윗의 키
			//System.out.println(td.getAttachments().getMediaKeys().length); 여러개 있을 시 length가 2이상임
			//이걸로 db넣을때 ,이거나 ; 이걸로 구분하면됨
			System.out.println("-------------------------------------------------");
			}
		}*/
	/*List<String> member = new ArrayList();
		for(int i=0;i<DataManagement.twitterUrl.length;i++)
		member.add(DataManagement.twitterUrl[i]);
		System.out.println(member);
		List<User> users = twitterClient.getUsersFromUserNames(member);
		for(int i=0;i<users.size();i++)
			System.out.println(users.get(i).getId()+" : "+DataManagement.KRName[i]);*/
	public static void test(String twid,TwitterClient twitterClient) {
		Tweet tweet = twitterClient.getTweet(twid);
		System.out.println("------------------------");
		System.out.println("!!");
		System.out.println("트윈 쓴 사람/리트윗 쓴 사람 : "+tweet.getUser().getDisplayedName()+" : "+tweet.getUser().getName());
		System.out.println("리트윗 내용 : "+tweet.getText());
		if(tweet.getMedia()!=null) {
			for(int i=0; i<tweet.getMedia().size();i++) {
				MediaEntityV2 m = (MediaEntityV2) tweet.getMedia().get(i);
				if(m.getType().toString().equals("video"))
					System.out.println("미디어 url : "+m.getPreviewImageUrl());
				else
					System.out.println("이미지 url :"+m.getMediaUrl());

			}
		}
		if(tweet.getTweetType().toString().equals("QUOTED")||
				tweet.getTweetType().toString().equals("REPLIED_TO")) {
			test(tweet.getInReplyToStatusId(),twitterClient);
		}
	}
}