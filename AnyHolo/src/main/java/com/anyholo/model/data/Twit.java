package com.anyholo.model.data;

import java.sql.Date;

public class Twit {
	String twitID;
	String writeUserName;
	String userID;
	String userProfileURL;
	String twitContent;
	String twitType;
	String nextTwitID;
	String mediaType;
	String mediaURL;
	String writeDate;
	
	

	public Twit(String twitID, String writeUserName, String userID, String userProfileURL, String twitContent,
			String twitType, String nextTwitID, String mediaType, String mediaURL, String writeDate) {
		super();
		this.twitID = twitID;
		this.writeUserName = writeUserName;
		this.userID = userID;
		this.userProfileURL = userProfileURL;
		this.twitContent = twitContent;
		this.twitType = twitType;
		this.nextTwitID = nextTwitID;
		this.mediaType = mediaType;
		this.mediaURL = mediaURL;
		this.writeDate = writeDate;
	}

	public String getUserProfileURL() {
		return userProfileURL;
	}

	public void setUserProfileURL(String userProfileURL) {
		this.userProfileURL = userProfileURL;
	}

	public String getMediaType() {
		return mediaType;
	}

	public void setMediaType(String mediaType) {
		this.mediaType = mediaType;
	}

	public String getTwitID() {
		return twitID;
	}
	public void setTwitID(String twitID) {
		this.twitID = twitID;
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
	public String getTwitContent() {
		return twitContent;
	}
	public void setTwitContent(String twitContent) {
		this.twitContent = twitContent;
	}
	public String getMediaURL() {
		return mediaURL;
	}
	public void setMediaURL(String mediaURL) {
		this.mediaURL = mediaURL;
	}
	public String getTwitType() {
		return twitType;
	}
	public void setTwitType(String twitType) {
		this.twitType = twitType;
	}
	public String getWriteDate() {
		return writeDate;
	}
	public void setWriteDate(String writeDate) {
		this.writeDate = writeDate;
	}
	public String getNextTwitID() {
		return nextTwitID;
	}
	public void setNextTwitID(String nextTwitID) {
		this.nextTwitID = nextTwitID;
	}
	
}
