package com.hololivefinder.api;
import io.github.redouane59.twitter.TwitterClient;
import io.github.redouane59.twitter.dto.user.User;
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
		/*TweetList timeline = twitterClient.getUserTimeline("1133215093246664706",
				AdditionalParameters.builder().startTime(LocalDateTime.now().minusDays(3)).endTime(LocalDateTime.now()).build());
		System.out.println("!");
		for(int i = 0; i<timeline.getIncludes().getMedia().size();i++) {
			System.out.println(timeline.getIncludes().getMedia().get(i).getMediaUrl());
			System.out.println(timeline.getIncludes().getMedia().get(i).getKey());//어디 트윗에 있는 것인가
			System.out.println(timeline.getIncludes().getMedia().get(i).getId());
			System.out.println("------------------------------------------------");
			
		}
		System.out.println(timeline.getData().size());
		for(int i =0;i<timeline.getData().size();i++) {
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
	/*Tweet tweet = twitterClient.getTweet("1576181857900601344");
		System.out.println(tweet.getText());
		System.out.println("------------------------");
		System.out.println(tweet.getCreatedAt());//트윗 올린 시간
		System.out.println("------------------------");
		System.out.println(tweet.getLang());//트윗 언어(일본어 == ja같은)
		System.out.println("------------------------");
		System.out.println(tweet.getLikeCount()); // 좋아요 수
		System.out.println("------------------------");
		System.out.println(tweet.getRetweetCount()); // 리트윗 수
		System.out.println("------------------------");
		System.out.println(tweet.getReplyCount()); // 
		System.out.println("------------------------");
		System.out.println(tweet.getUser().getName()); //누구인지
		System.out.println("------------------------");*/
		User user = twitterClient.getUserFromUserName("usadapekora");
		System.out.println(user.getName()); //누구인지
		System.out.println("------------------------");
		System.out.println(user.getDisplayedName());//화면에 표시되는 이름
		System.out.println("------------------------");
		System.out.println(user.getDateOfCreation());//가입일
		System.out.println("------------------------");
		System.out.println(user.getDescription());//소개글
		System.out.println("------------------------");
		System.out.println(user.getTweetCount());//몇개의 트윗을 햇는가
		System.out.println("------------------------");
		System.out.println(user.getFollowersCount());//팔로워 수
		System.out.println("------------------------");
		System.out.println(user.getFollowingCount());//팔로우 수
		System.out.println("------------------------");
		System.out.println(user.getPinnedTweet().getText());
		System.out.println("------------------------");
		System.out.println(user.getPinnedTweet().getMedia());
		System.out.println("------------------------");
		System.out.println(user.getLocation());//위치
		System.out.println("------------------------");
		System.out.println(user.getId());//user id값
		System.out.println("------------------------");
		System.out.println(user.getUrl());//링크 걸려있는거
		/*List<String> member = new ArrayList();
		for(int i=0;i<DataManagement.twitterUrl.length;i++)
		member.add(DataManagement.twitterUrl[i]);
		System.out.println(member);
		List<User> users = twitterClient.getUsersFromUserNames(member);
		for(int i=0;i<users.size();i++)
			System.out.println(users.get(i).getId()+" : "+DataManagement.KRName[i]);*/
	}
}
