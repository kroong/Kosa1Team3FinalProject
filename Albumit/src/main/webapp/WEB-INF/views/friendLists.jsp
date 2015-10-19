<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
   <style>
   #friends{
   display:block;
   }
   
   </style> 
<script>
function block(){
	alert("block!");
	var contextpath = $("#contextpath").val();
	$.ajax({
		type: "post",
		url: contextpath+"/blockPage",
		dataType : "html",
		success : function(data){
			$("#ftable").html(data);
		}
	});
}

</script>
   <div id="friends">
<table >
	<tr>
	<td>email</td>
	<td>profile</td>
	</tr>
	
	
	<c:forEach var="f" items="${flist}">
		<tr id="status">
			<td id="email">${f.member_email}</td>
			<td>${f.member_nickname}</td>
			<td>${f.friend_block}</td>
		</tr>
	</c:forEach>
	
	
</table>
<input type="hidden" id="contextpath" value="${pageContext.request.contextPath}"/>
<input type="button" onclick="block()" value="blockFriend"/>
</div>

