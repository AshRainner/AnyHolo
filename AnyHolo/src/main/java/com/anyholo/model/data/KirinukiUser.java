package com.anyholo.model.data;

public class KirinukiUser {
	String youtubeUrl;
	String userName;
	
	public KirinukiUser(String youtubeUrl, String userName) {
		super();
		this.youtubeUrl = youtubeUrl;
		this.userName = userName;
	}
	
	public String getYoutubeUrl() {
		return youtubeUrl;
	}
	public void setYoutubeUrl(String youtubeUrl) {
		this.youtubeUrl = youtubeUrl;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	
	
}
