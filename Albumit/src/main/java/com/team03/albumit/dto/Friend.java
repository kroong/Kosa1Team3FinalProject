package com.team03.albumit.dto;

public class Friend {
	private int uid;
	private int f_uid;
	private boolean frined_block;
	
	public boolean isFrined_block() {
		return frined_block;
	}
	public void setFrined_block(boolean frined_block) {
		this.frined_block = frined_block;
	}
	
	public int getUid() {
		return uid;
	}
	public void setUid(int uid) {
		this.uid = uid;
	}
	public int getF_uid() {
		return f_uid;
	}
	public void setF_uid(int f_uid) {
		this.f_uid = f_uid;
	}
	
}
