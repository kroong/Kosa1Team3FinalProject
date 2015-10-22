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
			
			#wrapper{
				background-color: pink;
				padding: 10px;
				display:inline-block;
				width: 1000px;
				height: 500px;
				display: flex;
				margin:0, auto;
				
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
			// Variable to store your files
			var files;

			// Add events
			$('#attach').on('change', prepareUpload);

			// Grab the files and set them to our variable
			function prepareUpload(event) {
				files = event.target.files;
			 
				var data = new FormData();
				$.each(files, function(key, value) {
				    data.append("attach", value);
				});
			  
				$.ajax({
				      url: 'preaddPhoto',
				      type: 'POST',
				      data: data,
				      cache: false,
				      dataType: 'json',
				      processData: false, 
				      contentType: false,
				      success: function(data) {
				          $("#photo").attr("src", "/albumit/resources/uploadfiles/photo_download.jsp?fileName="+data.fileName);
				      },
				      error: function(jqXHR, textStatus, errorThrown) {
				          alert("error");
				      }
				});
				
			}d
			
			
			/* var dialog, form;
			
			dialog = $("#dialog").dialog({
				autoOpen : false,
				height : 200,
				width : 300,
				left : 0,
				modal: true
			});
			
			form = dialog.find("#prephoto").on("submit", function(event){
				event.preventDefault();
				confirm();
			});
		
			$("#button").on("click", function(){
				dialog.dialog("open");
			});
			
			$("#btnUpload").on("click", function(){
				$.ajax({
				    url: "preaddPhoto",
				    type: "POST",
				    //data: formdata,
				    processData: false,
				    contentType: false,
				    success: function (res) {
				      //document.getElementById("response").innerHTML = res; 
				    }
				});
			});
			
			$("#btnCancel").on("click", function(){
				dialog.dialog("close");
			}); */
			
		});
		
		</script>
		
	</head>
	
	<body>
		<div id="wrapper">
	
		<div id="image">
			<img id="photo" width="300px" height="300px"/>
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
					<td><textarea name="photo_content" rows="5" cols="50"></textarea></td>
				</tr>
				<tr>
					<td><input type="hidden" name="album_no" value="${album_no}"/></td>
				</tr>
				<tr>
					<td colspan="2">
					<input type="file" id="attach" name="attach" value="사진등록"/>
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
