package com.anyholo.model.data;

public class MemberView {
	Member member;
	MemberOnAir onAir;
	
	public MemberView(Member member, MemberOnAir onAir) {
		super();
		this.member = member;
		this.onAir = onAir;
	}
	
	public Member getMember() {
		return member;
	}
	public void setMember(Member member) {
		this.member = member;
	}
	public MemberOnAir getOnAir() {
		return onAir;
	}
	public void setOnAir(MemberOnAir onAir) {
		this.onAir = onAir;
	}
	
	
}
