<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div id="ftable"></div>
<table id="myTable">
	<tr>
	<td>email</td>
	<td>profile</td>
	<td>block</td>
	</tr>
	
	<c:forEach var="f" items="${flist}">
		<tr id="status">
			<td id="email">${f.member_email}</td>
			<td>${f.member_nickname}</td>
			<td>
			<p>
  				<input type="text" id="a" name="amount2" readonly style="border:0; color:#f6931f; font-weight:bold;">
			</p>
			<div class="slider-range-min"></div></td>
			
		<c:if test="${f.friend_block == false }">
		<td id="blocked">
			차단된친구
		</td></c:if> 
		
		<c:if test="${f.friend_block == true }">
		<td id="blocked">
			안차단친구
		</td></c:if> 
	
		</tr>
       
	</c:forEach>
</table>
<div id="frtable3">

</div>

<input type="hidden" id="contextpath" value="${pageContext.request.contextPath}"/>