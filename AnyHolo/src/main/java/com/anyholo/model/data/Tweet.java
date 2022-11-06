package com.anyholo.model.data;

import java.sql.Date;

public class Tweet {
	String tweetID;
	String writeUserName;
	String userID;
	String userProfileURL;
	String tweetContent;
	String tweetType;
	String prevTweetID;
	String mediaType;
	String mediaURL;
	String writeDate;
	String country;
	String holo;
	String name;
	

	public Tweet(String tweetID, String writeUserName, String userID, String userProfileURL, String tweetContent,
			String tweetType, String prevTweetID, String mediaType, String mediaURL, String writeDate,String country,String holo,String name) {
		super();
		this.tweetID = tweetID;
		this.writeUserName = writeUserName;
		this.userID = userID;
		this.userProfileURL = userProfileURL;
		this.tweetContent = tweetContent;
		this.tweetType = tweetType;
		this.prevTweetID = prevTweetID;
		this.mediaType = mediaType;
		this.mediaURL = mediaURL;
		this.writeDate = writeDate;
		this.country = country;
		this.holo = holo;
		this.name=name;
	}



	public String getTweetID() {
		return tweetID;
	}



	public void setTweetID(String tweetID) {
		this.tweetID = tweetID;
	}



	public String getWriteUserName() {
		return writeUserName;
	}



	public void setWriteUserName(String writeUserName) {
		this.writeUserName = writeUserName;
	}



	public String getUserID() {
		return userID;
	}



	public void setUserID(String userID) {
		this.userID = userID;
	}



	public String getUserProfileURL() {
		return userProfileURL;
	}



	public void setUserProfileURL(String userProfileURL) {
		this.userProfileURL = userProfileURL;
	}



	public String getTweetContent() {
		return tweetContent;
	}



	public void setTweetContent(String tweetContent) {
		this.tweetContent = tweetContent;
	}



	public String getTweetType() {
		return tweetType;
	}



	public void setTweetType(String tweetType) {
		this.tweetType = tweetType;
	}



	public String getPrevTweetID() {
		return prevTweetID;
	}



	public void setPrevTweetID(String prevTweetID) {
		this.prevTweetID = prevTweetID;
	}



	public String getMediaType() {
		return mediaType;
	}



	public void setMediaType(String mediaType) {
		this.mediaType = mediaType;
	}



	public String getMediaURL() {
		return mediaURL;
	}



	public void setMediaURL(String mediaURL) {
		this.mediaURL = mediaURL;
	}



	public String getWriteDate() {
		return writeDate;
	}



	public void setWriteDate(String writeDate) {
		this.writeDate = writeDate;
	}



	public String getCountry() {
		return country;
	}



	public void setCountry(String country) {
		this.country = country;
	}



	public String getHolo() {
		return holo;
	}



	public void setHolo(String holo) {
		this.holo = holo;
	}



	public String getName() {
		return name;
	}



	public void setName(String name) {
		this.name = name;
	}
	
	
}
