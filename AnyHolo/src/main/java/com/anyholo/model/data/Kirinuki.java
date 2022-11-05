package com.anyholo.model.data;

public class Kirinuki {
	String youtubeURL;
	String channelName;
	String thumnailsURL;
	String videoTitle;
	String tag;
	String country;
	String uploadTime;
	
	public Kirinuki(String youtubeURL, String channelName, String thumnailsURL, String videoTitle, String tag,
			String country, String uploadTime) {
		super();
		this.youtubeURL = youtubeURL;
		this.channelName = channelName;
		this.thumnailsURL = thumnailsURL;
		this.videoTitle = videoTitle;
		this.tag = tag;
		this.country = country;
		this.uploadTime = uploadTime;
	}
	public String getYoutubeURL() {
		return youtubeURL;
	}
	public void setYoutubeURL(String youtubeURL) {
		this.youtubeURL = youtubeURL;
	}
	public String getChannelName() {
		return channelName;
	}
	public void setChannelName(String channelName) {
		this.channelName = channelName;
	}
	public String getThumnailsURL() {
		return thumnailsURL;
	}
	public void setThumnailsURL(String thumnailsURL) {
		this.thumnailsURL = thumnailsURL;
	}
	public String getTag() {
		return tag;
	}
	public void setTag(String tag) {
		this.tag = tag;
	}
	public String getUploadTime() {
		return uploadTime;
	}
	public void setUploadTime(String uploadTime) {
		this.uploadTime = uploadTime;
	}
	public String getVideoTitle() {
		return videoTitle;
	}
	public void setVideoTitle(String videoTitle) {
		this.videoTitle = videoTitle;
	}
	public String getCountry() {
		return country;
	}
	public void setCountry(String country) {
		this.country = country;
	}
	
	
}
