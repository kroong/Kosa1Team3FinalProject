<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		<style type="text/css">
			body {
				font-size: small;
				height: 100%;
			}
			
			input {
				font-size: 12px;
			}
			
			div{
				background-color: pink;
				padding: 10px;
				display:inline-block;
				width: 1000px;
				height: 500px;
				display: flex;
				margin:50% auto;
				
			}
			
			#image{
				flex:1;
			}
			
			#content{
				flex:2;
			}
			
			
		</style>
		<script type="text/javascript"
		src='${pageContext.request.contextPath}/resources/js/jquery-1.11.3.min.js'></script>
		<script src="//code.jquery.com/jquery-1.10.2.js"></script>
		<script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
		
		<script>
		$(function() {
			var dialog, form;
			
		function confirm(){
			
		}
			
		dialog = $("#dialog").dialog({
				autoOpen : false,
				height : 500,
				width : 350,
				left : 0,
				modal: true,
				buttons:{
					"확인": confirm,
					cancel: function(){
						dialog.dialog("close");
					}
				},
				close: function(){
					form[0].reset();
					
				}
			});
			
			form = dialog.find("form").on("submit", function(event){
				event.preventDefault();
				confirm();
			});
		
			$("#button").on("click", function(){
				dialog.dialog("open");
			});
			
		});
		
		</script>
		
	</head>
	
	<body>
		<div>
		<div id="dialog" style="background-color: blue">
		<form method="post" action="preaddPhoto" enctype="multipart/form-data">
		<input type="hidden" name="album_no" value="${album_no}"/>
				<p>첨부</p>
				<input type="file" name="attach"/>
		</form>
		</div>
		<div id="image">
			<img src="${pageContext.request.contextPath}/resources/uploadfiles/${photo.photo_filesystem_name}" width="300px" height="300px"/>
		</div>
		

		<div id="content">
		<form method="post" action="addPhoto" enctype="multipart/form-data">
			<table>
				<tr>
					<td>제목</td>
					<td><input type="text" name="photo_title" value="${photo.photo_title}"/></td>
				</tr>
				<tr>
					<td>장소</td>
					<td><input type="text" name="photo_place" value="${photo.photo_place}"/></td>
				</tr>
				<tr>
					<td>날짜</td>
					<td><input type="date" name="photo_place" value="${photo.photo_date}"/></td>
				</tr>
				<tr>
					<td>내용</td>
					<td><textarea name="photo_content" rows="5" cols="50""></textarea></td>
				</tr>
				<tr>
					<td><input type="hidden" name="album_no" value="${album_no}"/></td>
				</tr>
				<tr>
					<td>
					<input type="button" id="button" value="사진등록"/>
					</td>
				</tr>
				<tr>
			
				</tr>
				<tr>
					<td colspan="2" style="text-align: center;">
						<br/>
						<input type="submit" value="글올리기"/>
						<input type="reset" value="다시작성"/>					
					</td>
				</tr>
			</table>
		</form>
		</div>
		</div>
			
	</body>
</html>
