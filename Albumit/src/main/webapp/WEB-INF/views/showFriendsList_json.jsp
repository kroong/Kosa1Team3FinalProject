<%@ page contentType="application/json; charset=UTF-8"
import="java.util.*, com.team03.albumit.dto.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

[
	<c:forEach var="member" items="${friendsList }">
		{
			"uid" : ${member.uid},
			"member_email" : "${member.member_email}",
			"member_nickname" : "${member.member_nickname}",
			"member_profile" : "${member.member_profile }"
		}
	</c:forEach>
]