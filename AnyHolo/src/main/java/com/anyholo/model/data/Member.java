package com.anyholo.model.data;

public class Member implements Comparable<Member> {
	String memberName; // 멤버 이름
    String imageUrl; // 프로필 Url
    String country; // 활동 국가
    String onAir; // 생방송 여부
    String introduceText; // 유튜브 소개글
    String onAirTitle; // 생방송 타이틀
    String onAirthumnailsUrl; // 생방송 썸네일
    String onAirVideoUrl; // 생방송 Url
    String channelId; // 채널 Id
    String twitterUrl; // 트위터 Url
    String hololiveUrl; // 홀로라이브 공식 프로필 Url
    int number;
	public Member(String memberName, String imageUrl, String country, String onAir, String introduceText,
			String onAirTitle, String onAirthumnailsUrl, String onAirVideoUrl, String channelId, String twitterUrl,
			String hololiveUrl,int number) {
		super();
		this.memberName = memberName;
		this.imageUrl = imageUrl;
		this.country = country;
		this.onAir = onAir;
		this.introduceText = introduceText;
		this.onAirTitle = onAirTitle;
		this.onAirthumnailsUrl = onAirthumnailsUrl;
		this.onAirVideoUrl = onAirVideoUrl;
		this.channelId = channelId;
		this.twitterUrl = twitterUrl;
		this.hololiveUrl = hololiveUrl;
		this.number=number;
	}
	
	public int getNumber() {
		return number;
	}

	public void setNumber(int number) {
		this.number = number;
	}

	public String getMemberName() {
		return memberName;
	}
	public void setMemberName(String memberName) {
		this.memberName = memberName;
	}
	public String getImageUrl() {
		return imageUrl;
	}
	public void setImageUrl(String imageUrl) {
		this.imageUrl = imageUrl;
	}
	public String getCountry() {
		return country;
	}
	public void setCountry(String country) {
		this.country = country;
	}
	public String getOnAir() {
		return onAir;
	}
	public void setOnAir(String onAir) {
		this.onAir = onAir;
	}
	public String getIntroduceText() {
		return introduceText;
	}
	public void setIntroduceText(String introduceText) {
		this.introduceText = introduceText;
	}
	public String getOnAirTitle() {
		return onAirTitle;
	}
	public void setOnAirTitle(String onAirTitle) {
		this.onAirTitle = onAirTitle;
	}
	public String getOnAirthumnailsUrl() {
		return onAirthumnailsUrl;
	}
	public void setOnAirthumnailsUrl(String onAirthumnailsUrl) {
		this.onAirthumnailsUrl = onAirthumnailsUrl;
	}
	public String getOnAirVideoUrl() {
		return onAirVideoUrl;
	}
	public void setOnAirVideoUrl(String onAirVideoUrl) {
		this.onAirVideoUrl = onAirVideoUrl;
	}
	public String getChannelId() {
		return channelId;
	}
	public void setChannelId(String channelId) {
		this.channelId = channelId;
	}
	public String getTwitterUrl() {
		return twitterUrl;
	}
	public void setTwitterUrl(String twitterUrl) {
		this.twitterUrl = twitterUrl;
	}
	public String getHololiveUrl() {
		return hololiveUrl;
	}
	public void setHololiveUrl(String hololiveUrl) {
		this.hololiveUrl = hololiveUrl;
	}

	@Override
	public int compareTo(Member o) {
		int compareNumber=o.getNumber();
        return this.number-compareNumber;
	}    
}
