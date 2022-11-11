package com.anyholo.model.data;

public class MemberOnAir {
	int number;
	String onAir;
	String onAirTitle;
	String onAirThumnailsUrl;
	String onAirVideoUrl;
	
	public MemberOnAir(int number, String onAir, String onAirTitle, String onAirThumnailsUrl, String onAirVideoUrl) {
		super();
		this.number = number;
		this.onAir = onAir;
		this.onAirTitle = onAirTitle;
		this.onAirThumnailsUrl = onAirThumnailsUrl;
		this.onAirVideoUrl = onAirVideoUrl;
	}
	public int getNumber() {
		return number;
	}
	public void setNumber(int number) {
		this.number = number;
	}
	public String getOnAir() {
		return onAir;
	}
	public void setOnAir(String onAir) {
		this.onAir = onAir;
	}
	public String getOnAirTitle() {
		return onAirTitle;
	}
	public void setOnAirTitle(String onAirTitle) {
		this.onAirTitle = onAirTitle;
	}
	public String getOnAirThumnailsUrl() {
		return onAirThumnailsUrl;
	}
	public void setOnAirThumnailsUrl(String onAirThumnailsUrl) {
		this.onAirThumnailsUrl = onAirThumnailsUrl;
	}
	public String getOnAirVideoUrl() {
		return onAirVideoUrl;
	}
	public void setOnAirVideoUrl(String onAirVideoUrl) {
		this.onAirVideoUrl = onAirVideoUrl;
	}
	
	
}
