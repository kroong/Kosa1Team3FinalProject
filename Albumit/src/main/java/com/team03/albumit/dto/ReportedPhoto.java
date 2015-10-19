package com.team03.albumit.dto;

public class ReportedPhoto {

	private int photo_no;
	private int uid;
	private  String reported_reason;
	
	public int getPhoto_no() {
		return photo_no;
	}
	public void setPhoto_no(int photo_no) {
		this.photo_no = photo_no;
	}
	public int getUid() {
		return uid;
	}
	public void setUid(int uid) {
		this.uid = uid;
	}
	public String getReported_reason() {
		return reported_reason;
	}
	public void setReported_reason(String reported_reason) {
		this.reported_reason = reported_reason;
	}
}
