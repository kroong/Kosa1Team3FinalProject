<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<p>This member is not our member! Sorry</p>
	
	<table>
					<tr>
					<td>email</td>
					<td>profile</td>
					<td>block</td>
					</tr>
						<c:forEach var="fr" items="${sessionScope.editFriends}" >
					<tr>
						<td><c:out value="${fr.member_email }"></c:out></td>
						<td><c:out value="${fr.member_profile }"></c:out></td>
						<td> <c:out value="${fr.friend_block }"></c:out></td>
					</tr>
						</c:forEach></table>