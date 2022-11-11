package com.anyholo.model.data;

public class KirinukiVideo {
	String videoUrl;
	String videoTitle;
	String thumnailUrl;
	String tag;
	String upLoadTime;
	String country;
	String youtubeUrl;
	
	public KirinukiVideo(String videoUrl, String videoTitle, String thumnailUrl, String tag, String upLoadTime,
			String country, String youtubeUrl) {
		super();
		this.videoUrl = videoUrl;
		this.videoTitle = videoTitle;
		this.thumnailUrl = thumnailUrl;
		this.tag = tag;
		this.upLoadTime = upLoadTime;
		this.country = country;
		this.youtubeUrl = youtubeUrl;
	}
	
	
	public String getYoutubeUrl() {
		return youtubeUrl;
	}


	public void setYoutubeUrl(String youtubeUrl) {
		this.youtubeUrl = youtubeUrl;
	}


	public String getVideoUrl() {
		return videoUrl;
	}
	public void setVideoUrl(String videoUrl) {
		this.videoUrl = videoUrl;
	}
	public String getVideoTitle() {
		return videoTitle;
	}
	public void setVideoTitle(String videoTitle) {
		this.videoTitle = videoTitle;
	}
	public String getThumnailUrl() {
		return thumnailUrl;
	}
	public void setThumnailUrl(String thumnailUrl) {
		this.thumnailUrl = thumnailUrl;
	}
	public String getTag() {
		return tag;
	}
	public void setTag(String tag) {
		this.tag = tag;
	}
	public String getUpLoadTime() {
		return upLoadTime;
	}
	public void setUpLoadTime(String upLoadTime) {
		this.upLoadTime = upLoadTime;
	}
	public String getCountry() {
		return country;
	}
	public void setCountry(String country) {
		this.country = country;
	}
	
	
}
