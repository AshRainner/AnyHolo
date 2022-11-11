package com.anyholo.model.data;

public class Member {
	int number; // 번호
	String channelId; // 채널 url
	String twitterUrl; // 트위터 url
	String hololiveUrl; // 홀로라이브 url
	String country; // 나라권
	String searchKrName; // 검색용 이름
	String krName; // 보여줄 이름
	String twitterId;
	
	

	public Member(int number, String channelId, String twitterUrl, String hololiveUrl, String country,
			String searchKrName, String krName, String twitterId) {
		super();
		this.number = number;
		this.channelId = channelId;
		this.twitterUrl = twitterUrl;
		this.hololiveUrl = hololiveUrl;
		this.country = country;
		this.searchKrName = searchKrName;
		this.krName = krName;
		this.twitterId = twitterId;
	}

	public String getTwitterId() {
		return twitterId;
	}

	public void setTwitterId(String twitterId) {
		this.twitterId = twitterId;
	}

	public String getCountry() {
		return country;
	}

	public void setCountry(String country) {
		this.country = country;
	}

	public int getNumber() {
		return number;
	}
	public void setNumber(int number) {
		this.number = number;
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
	public String getSearchKrName() {
		return searchKrName;
	}
	public void setSearchKrName(String searchKrName) {
		this.searchKrName = searchKrName;
	}
	public String getKrName() {
		return krName;
	}
	public void setKrName(String krName) {
		this.krName = krName;
	}
	
}
