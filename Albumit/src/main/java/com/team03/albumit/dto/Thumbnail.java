package com.team03.albumit.dto;

public class Thumbnail {
	
	private int thumbnail_no;
	private String thumbnail_original_file_name;
	private String thumbnail_filesystem_name;
	private String thumbnail_content_type;
	public int getThumbnail_no() {
		return thumbnail_no;
	}
	public void setThumbnail_no(int thumbnail_no) {
		this.thumbnail_no = thumbnail_no;
	}
	public String getThumbnail_original_file_name() {
		return thumbnail_original_file_name;
	}
	public void setThumbnail_original_file_name(String thumbnail_original_file_name) {
		this.thumbnail_original_file_name = thumbnail_original_file_name;
	}
	public String getThumbnail_filesystem_name() {
		return thumbnail_filesystem_name;
	}
	public void setThumbnail_filesystem_name(String thumbnail_filesystem_name) {
		this.thumbnail_filesystem_name = thumbnail_filesystem_name;
	}
	public String getThumbnail_content_type() {
		return thumbnail_content_type;
	}
	public void setThumbnail_content_type(String thumbnail_content_type) {
		this.thumbnail_content_type = thumbnail_content_type;
	}
	
	

}
