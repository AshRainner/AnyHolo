package com.anyholo.model.data;

public class KirinukiView {
	KirinukiUser user;
	KirinukiVideo video;
	
	public KirinukiView(KirinukiUser user, KirinukiVideo video) {
		super();
		this.user = user;
		this.video = video;
	}
	public KirinukiUser getUser() {
		return user;
	}
	public void setUser(KirinukiUser user) {
		this.user = user;
	}
	public KirinukiVideo getVideo() {
		return video;
	}
	public void setVideo(KirinukiVideo video) {
		this.video = video;
	}
	
}
