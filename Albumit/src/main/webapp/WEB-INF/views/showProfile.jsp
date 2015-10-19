<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script>
$("#modifyProfile").click(function(){
	//컨텍스트 경로 얻기
	var contextpath = $("#contextpath").val();
	console.log("수정 눌렀져!!!");
	console.log("수정하려는 사람"+$("#loginEmail").val());
	console.log("albumList contextpath 컨텍스트 루 "+contextpath);
	$.ajax({
		type: "post",
		url: contextpath+"/modifyProfile",
		data: {"email" : $("#loginEmail").val()},
		dataType : "html",
		success : function(data){
			$("#mypage").html(data);
		}
	});
	
});

</script>
<div id="nickname">
	nickname :
	<c:out value="${memProfile.member_nickname }" />
</div>
<div id="email">
	email :
	<c:out value="${memProfile.member_email}" />
	<input type="hidden" id="loginEmail" value="${memProfile.member_email}" />
</div>
<div id="profile">
	profile :
	<c:out value="${memProfile.member_profile }" />
</div>
<div id="photo"></div>

<img
	src="${pageContext.request.contextPath}/resources/image/${memProfile.member_filesystem_name}"
	width="100px" height="100px" />
<br />
<a href="#">pw ?</a>
<a href="leave">leave Albumit</a>
<button id="modifyProfile">Modify Profile</button>