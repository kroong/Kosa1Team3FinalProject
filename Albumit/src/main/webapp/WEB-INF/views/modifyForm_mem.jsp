<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script type="text/javascript">
function goMypage() {
	var contextpath = $("#contextpath").val();
	console.log("modifyForm에서 컨텍스트 루"+contextpath);
	$.ajax({
		type: "get",
		url: contextpath+"/showProfile",
		data: {"email" : $("#email").val()},
		dataType : "html",
		success : function(data){
			$("#mypage").html(data);
		}
	});
	
}
//프로필 수정시 오류 발생시 append태그 중복 출력을 방지 하기 위해 dupCheck라는 전역변수를 설정
var dupCheck=0;

//commit버튼 눌렀을 때 실행되는 함수
function commit(){
	
	var nickname= $("#nickname").val();
	var profile= $("#profile").val();
	var pw = $("#pw").val();
	
	var pwleng = pw.length;
	
	//입력하지 않은 필드 값을 알아내기 위한 변수 'check'
	var check = 0;
	
	if(nickname.length <=0){
		check++;
	}
	if(profile.length<=0){
		check++;
	}
	if( pw.length<=0 ){
		check++;
	}
	//세 항목 모두 기입하지 않거나, 비밀번호가 4자리 이하일때는 수정X
 	if(check == 3 || (pwleng < 4)){
		alert("NotModfied!!");
		console.log("check : " +check);
		
		//comment태그에 이전에 append되었으면 아래 구문들은 실행 되지 않는다.
		if(dupCheck==0){
			$("#comment").append("<b>can't update your profile! please chcek field</b><br/><b>password must be more than 4 characters! please try again</b>");
			$("#pw").val("");
			$("#profile").val();
			$("#nickname").val();
		}
		dupCheck ++;
	}
 	//조건 충족시 회원프로필 수정!!
	if((check<3) && (pwleng >=4)){
		alert("Modified!!!");
 		$("#modifyForm").submit();
	}
	
}
</script>

email: <c:out value="${Modifiedmem.member_email}" />
<form id="modifyForm" action="modifyMember" method="post" enctype="multipart/form-data">
	<input type="hidden" id="contextpath" value="${pageContext.request.contextPath}" /> 
	<input type="hidden" id="email" value="${Modifiedmem.member_email}" /> 
	nickName<input type="text" id="nickname" name="member_nickname" /> 
	profile<input type="text" id="profile" name="member_profile" /> 
	password<input type="text" id="pw" name="member_password" /> 
	photo<input type="file"	id="photo" name="attach" /> 
	<input type="button" onclick="commit()"	value="commit!" />
</form>
<!-- 회원수정 오류시 경고 메시지 출력하는 div -->
<div id="comment"></div>

<input type="button" onclick="goMypage()" value="back" />