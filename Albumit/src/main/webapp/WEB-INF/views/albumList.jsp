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
		<script type="text/javascript" src='${pageContext.request.contextPath}/resources/js/jquery-1.11.3.min.js'></script>
		<link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
		<script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
				
		<style type="text/css">
			* {
				margin: 0 auto;
				padding: 0px;
		    }
		    
		    body{
			    width: 100%;
				height : 100%;
				margin: 0 auto;
				font-size: 1;
				color:black;
				background-color: white;
				/* color:white;
				background-color: black; */
		    }
		    a, a:hover, a:FOCUS, a:VISITED {
		    	color: grey;
		    	text-decoration: none;
		    }
		    ol, ul {list-style: none;}
		    
		    .albumContainer {
		    	position: relative;
		    	width: 960px;
		    	height: 100%;
		    	left: 50%;
		    	margin: 0;
		    	transform: translateX(-50%);
		    }
		    
		    .albumThumbnailList {
		    	display: inline-block;
		    	position: relative;
		    	padding: 0; margin: 0;
		    	width: 180px;
		    	
		    }
		    
			.albumThumbnail {
				display: inline-block;
				text-align: center;
				margin: 1px 15px;
			}
			.albumThumbnail img {
				width: 150px; height: 150px;
				display: block;
			}
			.albumThumbnail span {
				display: inline-block; position: absolute; width: 150px;
				top: 135px; left: 50%; transform: translateX(-50%);
			}
			
			.albumThumbnailList .albumMenu {
				display: inline-block; position: absolute; font-size: 1.2em;
				left: 18px; top: 100px; z-index: 3; opacity: 0; transition: all 0.5s;
				background-color: white;
			}
			
			.albumThumbnailList:hover .albumMenu { opacity: 0.7; }
			
			.albumMenu ul li {float: left; margin: 1px 15px;}
			.albumMenu ul li a:hover {color: #6677ff; opacity: 1;}
			
		</style>
	
	</head>
	
	<body>
	<!-- -----앨범 보기 부분 ------------------------------------------------------------------------------------- -->
		<input type="hidden" name="curAlbumList" value="${curAlbumList}"/>
		<div class="albumContainer">
			<c:forEach var="albumEntry" items="${albumList}">
				<div class="albumThumbnailList">
					<div class="albumThumbnail">
						<a href="photoList?album_no=${albumEntry.key.album_no}">
							<img src="${pageContext.request.contextPath}/resources/thumb/${albumEntry.value.thumbnail_original_file_name}"/>
							<span>${albumEntry.key.album_name}</span>
							<input type="hidden" value="${albumEntry.key.album_no}"/>
							<input type="hidden" value="${albumEntry.key.album_name}"/>
						</a>
					</div>
					<div class="albumMenu">
						<ul>
							<li><a href="#" id="albumLikeButton"><i class="fa fa-heart-o"></i></a></li>
							<li><a href="#" id="albumModifyButton"><i class="fa fa-cog"></i></a></li>
							<li><a href="#" id="albumDeleteButton"><i class="fa fa-trash-o"></i></a></li>
						</ul>
					</div>
				</div>
			</c:forEach>
		</div>
	<!-- --------------------------------------------------------------------------------------------------------- -->
	
	<!-- -----앨범 삭제 확인 ------------------------------------------------------------------------------------- -->
		<div id="delete_confirm_window">
			<p>
				<span>
					<i class="fa fa-exclamation" style="display: inline-block; float: left; font-size: 20px; color: red; margin: 0 15px 0 5px"></i>
				</span>
				Do you really want to delete this album?
			</p>
		</div>
	<!-- --------------------------------------------------------------------------------------------------------- -->
	
		<script>
			$(function() {
				$("#albumDeleteButton").on("click", function() {
					$("#delete_confirm_window").dialog("open");
					$(".ui-dialog-titlebar").hide();
				});
				
				$("#delete_confirm_window").dialog({
					resizable: false,
					autoOpen: false,
					height: 200,
					modal: true,
					buttons: {
						"OK": function() {
							$(this).dialog("close");
						},
						Cancel: function() {
							$(this).dialog("close");
						}
					}
				});
			});
		</script>
	</body>
</html>