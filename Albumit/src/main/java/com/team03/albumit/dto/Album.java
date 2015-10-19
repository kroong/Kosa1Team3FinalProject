package com.team03.albumit.dto;

public class Album {

	private int album_no;
	private int uid;
	private String album_name;
	private boolean album_publicity;
	private int thumbnail_no;
	
	public int getAlbum_no() {
		return album_no;
	}
	public void setAlbum_no(int album_no) {
		this.album_no = album_no;
	}
	public int getUid() {
		return uid;
	}
	public void setUid(int uid) {
		this.uid = uid;
	}
	public String getAlbum_name() {
		return album_name;
	}
	public void setAlbum_name(String album_name) {
		this.album_name = album_name;
	}
	public boolean isAlbum_publicity() {
		return album_publicity;
	}
	public void setAlbum_publicity(boolean album_publicity) {
		this.album_publicity = album_publicity;
	}
	public int getThumbnail_no() {
		return thumbnail_no;
	}
	public void setThumbnail_no(int thumbnail_no) {
		this.thumbnail_no = thumbnail_no;
	}
}
