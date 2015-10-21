<%@ page contentType="text/html; charset=UTF-8" import="java.util.*, com.team03.albumit.dto.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>

<html>
	<head>
		<meta charset="UTF-8">
		<title>Albumit!</title>
		
		<!-- 파비콘설정 -->
		<link rel="icon"  href="${pageContext.request.contextPath}/resources/image/favicon.ico" type="image/x-icon"/> 
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">
		<script type="text/javascript"
			src='${pageContext.request.contextPath}/resources/js/jquery-1.11.3.min.js'></script>
		<link rel="stylesheet"
			href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
		<script src="//code.jquery.com/jquery-1.10.2.js"></script>
		<script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
		
		<script>
			
		
		</script>
	
		<style type="text/css">
		
			* {
				margin: 0 auto;
				padding: 0px;
		    }
		     
		    body{
			    width: 100%;
				height : 100%;
				background-color: white;
				margin: 0 auto;
		    }
		    
			#albumThumbnail {
				display: inline-block;
			}
			#albumThumbnail p {
				text-align: center;
				margin: 1px 15px;
			}
			#albumThumbnail img {
				width: 150px; height: 150px;
			}
	
		</style>
	
	</head>
	
	<body>
	<!-- -----앨범 보기 부분 ------------------------------------------------------------------------------------- -->
		<c:forEach var="albumEntry" items="${albumList}">
			<div id="albumThumbnail">
				<p>
					<img src="${pageContext.request.contextPath}/resources/thumb/${albumEntry.value.thumbnail_original_file_name}"/>
				</p>
				<p>${albumEntry.key.album_name}</p>
			</div>
		</c:forEach>
	<!-- --------------------------------------------------------------------------------------------------------- -->
		<div>
			<p>앨범 예시</p>
			<a href="photoList?album_no=1">album1</a>	
			<a href="photoList?album_no=2">album2</a>	
		</div>
	</body>
</html>