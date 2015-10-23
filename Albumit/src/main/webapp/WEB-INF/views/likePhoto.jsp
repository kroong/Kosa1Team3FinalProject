<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<ul>
	<li><span><fmt:formatDate value="${photo.photo_date}" pattern="yyyy-MM-dd" /></span></li>
	<li><span><a href="#"><i class="fa fa-heart-o"></i>좋아요${photo.photo_like}</a></span></li>
	<li><span>조회수${photo.photo_hitcount}</span></li>
	<li><span>1/1000</span></li>
	<li><span>80</span></li>
</ul>