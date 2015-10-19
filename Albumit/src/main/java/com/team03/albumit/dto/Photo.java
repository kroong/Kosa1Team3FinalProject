package com.team03.albumit.dto;

import java.util.*;

import org.springframework.web.multipart.*;

public class Photo {
	private int photo_no;
	private String photo_place;
	private int album_no;
	private Date photo_date;
	private String photo_original_file_name;
	private String photo_filesystem_name;
	private String photo_content_type;
	private MultipartFile attach;
	private int photo_like;
	private int photo_hitcount;
	private String photo_content;
	private String photo_title;
	private int uid;
	
	public int getPhoto_no() {
		return photo_no;
	}
	public void setPhoto_no(int photo_no) {
		this.photo_no = photo_no;
	}
	public String getPhoto_place() {
		return photo_place;
	}
	public void setPhoto_place(String photo_place) {
		this.photo_place = photo_place;
	}
	public int getAlbum_no() {
		return album_no;
	}
	public void setAlbum_no(int album_no) {
		this.album_no = album_no;
	}
	public Date getPhoto_date() {
		return photo_date;
	}
	public void setPhoto_date(Date photo_date) {
		this.photo_date = photo_date;
	}
	public String getPhoto_original_file_name() {
		return photo_original_file_name;
	}
	public void setPhoto_original_file_name(String photo_original_file_name) {
		this.photo_original_file_name = photo_original_file_name;
	}
	public String getPhoto_filesystem_name() {
		return photo_filesystem_name;
	}
	public void setPhoto_filesystem_name(String photo_filesystem_name) {
		this.photo_filesystem_name = photo_filesystem_name;
	}
	public String getPhoto_content_type() {
		return photo_content_type;
	}
	public void setPhoto_content_type(String photo_content_type) {
		this.photo_content_type = photo_content_type;
	}
	public MultipartFile getAttach() {
		return attach;
	}
	public void setAttach(MultipartFile attach) {
		this.attach = attach;
	}
	public int getPhoto_like() {
		return photo_like;
	}
	public void setPhoto_like(int photo_like) {
		this.photo_like = photo_like;
	}
	public int getPhoto_hitcount() {
		return photo_hitcount;
	}
	public void setPhoto_hitcount(int photo_hitcount) {
		this.photo_hitcount = photo_hitcount;
	}
	public String getPhoto_content() {
		return photo_content;
	}
	public void setPhoto_content(String photo_content) {
		this.photo_content = photo_content;
	}
	public String getPhoto_title() {
		return photo_title;
	}
	public void setPhoto_title(String photo_title) {
		this.photo_title = photo_title;
	}
	public int getUid() {
		return uid;
	}
	public void setUid(int uid) {
		this.uid = uid;
	}
	
	
}
