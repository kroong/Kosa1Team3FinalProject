package com.team03.albumit.dao;

import org.springframework.validation.*;

import com.team03.albumit.dto.*;


public class JoinValidator implements Validator{

	@Override
	public boolean supports(Class<?> clazz) {
		return Member.class.isAssignableFrom(clazz);
	}

	@Override
	public void validate(Object target, Errors errors) {
		Member member =(Member)target;
		
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "member_email", "required");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "member_password", "required");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "member_nickname", "required");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "member_profile", "required");
		
		if(member.getMember_password().length()<4)
		errors.rejectValue("member_password", "minlength");
	}
}
