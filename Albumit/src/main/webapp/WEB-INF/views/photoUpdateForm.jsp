<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		<style type="text/css">
			body {
				font-size: small;
			}
			
			input {
				font-size: 12px;
			}
		</style>

		<script type="text/javascript">
			function sendData() {
				//값의 유효성 검사
				var modifyForm = document.modifyForm;
				console.log(modifyForm);
				
				var photo_title = document.modifyForm.photo_title;
				console.log(title);
				
				var photo_content = document.modifyForm.photo_content;
				
				if(photo_title.value == "" || photo_content.value == "") {
					alert("제목과 내용은 있어야 합니다.");
					return;
				}

				//서버로 전송
				modifyForm.submit();
			}
		</script>
	</head>
	
	<body>
		<h4>게시물 보기</h4>
		<form id="modifyForm" name="modifyForm" method="post" action="updatePhoto">		
			<span class="title">번호:</span> 
			<span class="content">${photo.photo_no}</span> 
			<input type="hidden" name="photo_no" value="${photo.photo_no}"/><br/>
			<input type="hidden" name="album_no" value="${photo.album_no}"/><br/>
			
			<span class="title">제목:</span> 
			<input id="title" type="text" name="photo_title" value="${photo.photo_title}"/><br/>
			
			<span class="title">글쓴이:</span> 
			<span class="content">${photo.uid}</span> <br/>
			
			<span class="title">날짜:</span> 
			<span class="content"><fmt:formatDate value="${photo.photo_date}" pattern="yyyy-MM-dd"/></span> <br/>
			
			<span class="title">조회수:</span> 
			<span class="content">${photo.photo_hitcount}</span> <br/>
			
			<span class="title">내용:</span> <br/>
			<textarea name="photo_content" cols="80" rows="5">${photo.photo_content}</textarea>
		</form>
		<div id="buttonGroup">
			<a href="javascript:sendData()">수정</a>
			<a href="photoDetail?photo_no=${photo.photo_no}&&album_no=${photo.album_no}">취소</a>
		</div>		
	</body>
</html>