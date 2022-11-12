package com.anyholo.model.data;

import java.sql.Date;

import io.github.redouane59.twitter.dto.tweet.TweetType;

public class Tweet {
	String tweetID;
	String writeUserName;
	String userProfileURL;
	String tweetContent;
	String tweetType;
	String prevTweetID;
	String mediaType;
	String mediaURL;
	String writeDate;
	int number;
	public Tweet(String tweetID, String writeUserName, String userProfileURL, String tweetContent, String tweetType,
			String prevTweetID, String mediaType, String mediaURL, String writeDate,int number) {
		super();
		this.tweetID = tweetID;
		this.writeUserName = writeUserName;
		this.userProfileURL = userProfileURL;
		this.tweetContent = tweetContent;
		this.tweetType = tweetType;
		this.prevTweetID = prevTweetID;
		this.mediaType = mediaType;
		this.mediaURL = mediaURL;
		this.writeDate = writeDate;
		this.number = number;
	}
	

	public int getNumber() {
		return number;
	}

	public void setNumber(int number) {
		this.number = number;
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
	
	
}
