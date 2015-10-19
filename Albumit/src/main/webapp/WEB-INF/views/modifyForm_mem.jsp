<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script type="text/javascript">
function goMypage() {
	var contextpath = $("#contextpath").val();
	console.log("modifyForm���� ���ؽ�Ʈ ��"+contextpath);
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
//������ ������ ���� �߻��� append�±� �ߺ� ����� ���� �ϱ� ���� dupCheck��� ���������� ����
var dupCheck=0;

//commit��ư ������ �� ����Ǵ� �Լ�
function commit(){
	
	var nickname= $("#nickname").val();
	var profile= $("#profile").val();
	var pw = $("#pw").val();
	
	var pwleng = pw.length;
	
	//�Է����� ���� �ʵ� ���� �˾Ƴ��� ���� ���� 'check'
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
	//�� �׸� ��� �������� �ʰų�, ��й�ȣ�� 4�ڸ� �����϶��� ����X
 	if(check == 3 || (pwleng < 4)){
		alert("NotModfied!!");
		console.log("check : " +check);
		
		//comment�±׿� ������ append�Ǿ����� �Ʒ� �������� ���� ���� �ʴ´�.
		if(dupCheck==0){
			$("#comment").append("<b>can't update your profile! please chcek field</b><br/><b>password must be more than 4 characters! please try again</b>");
			$("#pw").val("");
			$("#profile").val();
			$("#nickname").val();
		}
		dupCheck ++;
	}
 	//���� ������ ȸ�������� ����!!
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
<!-- ȸ������ ������ ��� �޽��� ����ϴ� div -->
<div id="comment"></div>

<input type="button" onclick="goMypage()" value="back" />