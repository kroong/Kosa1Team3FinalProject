<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    
<p> 친구 추가 성공</p>
<table>
<tr>
<td>email</td>
<td>profile</td>
</tr>
	<c:forEach var="fr" items="${friends}" >
	<tr>
		<td><c:out value="${fr.member_email }"></c:out></td>
		<td><c:out value="${fr.member_profile }"></c:out></td>
	</tr>
	</c:forEach>
								
</table>