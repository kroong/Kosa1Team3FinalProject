<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		<style type="text/css">
			body {
				font-family: "돋움";
				font-size: 12px;
			}
			span {
				display: inline-block;
				margin: 2px 10px;
			}
			
			span.title {
				margin: 2px 10px;
				border: 1px solid darkgray;
				background: lightgray;
				width: 70px;
				text-align: center;
				color: black;
			}
			
			pre {
				margin: 10px;
				border: 1px solid darkgray;
				padding: 10px;
				width: 90%;
				height: 100px;
				font-size: 12px;
			}
			
			#part1 {
				display: flex;
			}
			#part1_1 {
				flex: 1;
			}
			#part1_2 {
				width: 120;
				margin-right: 10px;
				text-align: center;
			}
			#part1_2 img {
				display: block;
				padding: 10px;
			}
			
			#buttonGroup {
				margin: 10px;
				text-align: center;
			}
			
			#buttonGroup a {
				display:inline-block;
				width: 70px;
				line-height: 30px;
				text-decoration: none;
				font-size: small;
				color: white;
				border: 1px solid darkgray;
				background-color: gray;
				font-weight: bold;
			}
			
			#buttonGroup a:hover {
				color: black;
				background-color: lightgray;
			}
		</style>
	</head>
	
	<body>
		<h4>게시물 보기</h4>
		<div id="part1">
			<div id="part1_1">	
				<span class="title">사진</span> 
				<span class="content">${photo.photo_original_file_name}</span> <br/>
				
				<span class="title">제목:</span> 
				<span class="content">${photo.photo_title}</span> <br/>
				
				<span class="title">글쓴이:</span> 
				<span class="content">${photo.uid}</span> <br/>
				
				<span class="title">날짜:</span> 
				<span class="content">${photo.photo_date}</span> <br/>
				
				<span class="title">조회수:</span> 
				<span class="content">${photo.photo_hitcount}</span> <br/>
				
				<span class="title">좋아요:</span>
				<span class="content">${photo.photo_like}</span>
			</div>
			
			<div id="part1_2">
				<img src="${pageContext.request.contextPath}/resources/uploadfiles/${photo.photo_filesystem_name}" width="100px" height="100px"/>
				<button>다운로드</button>
			</div>
		</div>
		
		<div id="part2">
			<span class="title">내용:</span> <br/>
			<pre>${photo.photo_content}</pre>
		</div>
		
		<div id="buttonGroup">
			<a href="photoList?album_no=${photo.album_no }">목록</a>
			<a href="photoUpdateForm?album_no=${photo.album_no}&&photo_no=${photo.photo_no}">수정</a>
			<a href="delete/${photo.album_no }&&${photo.photo_no}">삭제</a>
		</div>		
	</body>
</html>
