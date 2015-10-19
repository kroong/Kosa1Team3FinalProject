package com.team03.albumit.dto;

import org.springframework.web.multipart.MultipartFile;

public class Member {
	private int uid;
	private String member_email;
	private String member_nickname;
	private String member_password;
	private String member_profile;
	private String member_original_file_name;
	private String member_filesystem_name;
	private String member_content_type;
	private MultipartFile attach;
	
	public MultipartFile getAttach() {
		return attach;
	}
	public void setAttach(MultipartFile attach) {
		this.attach = attach;
	}
	public int getUid() {
		return uid;
	}
	public void setUid(int uid) {
		this.uid = uid;
	}
	public String getMember_email() {
		return member_email;
	}
	public void setMember_email(String member_email) {
		this.member_email = member_email;
	}
	public String getMember_nickname() {
		return member_nickname;
	}
	public void setMember_nickname(String member_nickname) {
		this.member_nickname = member_nickname;
	}
	public String getMember_password() {
		return member_password;
	}
	public void setMember_password(String member_password) {
		this.member_password = member_password;
	}
	public String getMember_profile() {
		return member_profile;
	}
	public void setMember_profile(String member_profile) {
		this.member_profile = member_profile;
	}
	public String getMember_original_file_name() {
		return member_original_file_name;
	}
	public void setMember_original_file_name(String member_original_file_name) {
		this.member_original_file_name = member_original_file_name;
	}
	public String getMember_filesystem_name() {
		return member_filesystem_name;
	}
	public void setMember_filesystem_name(String member_filesystem_name) {
		this.member_filesystem_name = member_filesystem_name;
	}
	public String getMember_content_type() {
		return member_content_type;
	}
	public void setMember_content_type(String member_content_type) {
		this.member_content_type = member_content_type;
	}
	
}
