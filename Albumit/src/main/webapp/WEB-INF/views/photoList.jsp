<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">
		<style type="text/css">
			body {
			
			}
			table {
				width: 100%;
				border-collapse: collapse;
				font-size: small;
			}
			table, th, td {
				border: 1px solid black;
				text-align: center;
			}
			th {
				background-color: orange;
				color: black;
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
			
			#pager {
				margin-top: 5px;
				text-align: center;
				font-size: small;
			}
			
			#pager a {
				text-decoration: none;
				
			}
			
			#pager a:hover {
				color: orange;
			}
			
			#pager a.pageNo {
				margin-left: 5px;
				margin-right: 5px;
			}
			
			#pager a.pageNo.selected {
				color: aqua;
			}
			.fa{
				size:20px;
			}
			.fa a:hover{
				size:20px;
				color:red;
			}
			
			
		</style>
		<script type="text/javascript">
			function arrayfun(sel) {
			    var x = sel.options[sel.selectedIndex].value;
			    
			    if(x == "latest"){
			    	
			    	document.getElementById("latest").style.display="";
			    	document.getElementById("popularity").style.display="none";
			    }
			    
			    if(x == "popularity"){
			    	
			    	document.getElementById("latest").style.display="none";
			    	document.getElementById("popularity").style.display="";
			    	
			    }
			}
		
		</script>
	</head>
	
	<body>
	
		<select id="photoArray" size="1" onchange="arrayfun(this)">
			<option value="latest" selected="selected" >최신순</option>
			<option value="popularity">인기순</option>
		</select>
<!-- //////////////////////////////////////////////////////////////////// -->		
		<div class="content">
			<div class="grid">
				<div class="grid__item" data-size="1280x961">
					<a href="img/original/4.jpg" class="img-wrap"><img src="img/thumbs/4.jpg" alt="img04" />
						<div class="description description--grid">Propinquity</div>
					</a>
				</div>
				<div class="grid__item" data-size="1280x1131">
					<a href="img/original/5.jpg" class="img-wrap"><img src="img/thumbs/5.jpg" alt="img05" />
						<div class="description description--grid">Ephemeral</div>
					</a>
				</div>
				<div class="grid__item" data-size="1280x857">
					<a href="img/original/6.jpg" class="img-wrap"><img src="img/thumbs/6.jpg" alt="img06" />
						<div class="description description--grid">Surreptitious</div>
					</a>
				</div>
				<div class="grid__item" data-size="1280x1280">
					<a href="img/original/7.jpg" class="img-wrap"><img src="img/thumbs/7.jpg" alt="img07" />
						<div class="description description--grid">Scintilla</div>
					</a>
				</div>
				<div class="grid__item" data-size="1280x853">
					<a href="img/original/8.jpg" class="img-wrap"><img src="img/thumbs/8.jpg" alt="img08" />
						<div class="description description--grid">Vestigial</div>
					</a>
				</div>
				<div class="grid__item" data-size="865x1280">
					<a href="img/original/9.jpg" class="img-wrap"><img src="img/thumbs/9.jpg" alt="img09" />
						<div class="description description--grid">Zephyr</div>
					</a>
				</div>
				<div class="grid__item" data-size="1280x1280">
					<a href="img/original/10.jpg" class="img-wrap"><img src="img/thumbs/10.jpg" alt="img10" />
						<div class="description description--grid">Desideratum</div>
					</a>
				</div>
				<div class="grid__item" data-size="1280x850">
					<a href="img/original/11.jpg" class="img-wrap"><img src="img/thumbs/11.jpg" alt="img11" />
						<div class="description description--grid">Quixotic</div>
					</a>
				</div>
				<div class="grid__item" data-size="1280x853">
					<a href="img/original/1.jpg" class="img-wrap"><img src="img/thumbs/1.jpg" alt="img01" />
						<div class="description description--grid">Assemblage</div>
					</a>
				</div>
				<div class="grid__item" data-size="958x1280">
					<a href="img/original/2.jpg" class="img-wrap"><img src="img/thumbs/2.jpg" alt="img02" />
						<div class="description description--grid">Demesne</div>
					</a>
				</div>
				<div class="grid__item" data-size="837x1280">
					<a href="img/original/3.jpg" class="img-wrap"><img src="img/thumbs/3.jpg" alt="img03" />
						<div class="description description--grid">Felicity</div>
					</a>
				</div>
				<div class="grid__item" data-size="1280x961">
					<a href="img/original/4.jpg" class="img-wrap"><img src="img/thumbs/4.jpg" alt="img04" />
						<div class="description description--grid">Propinquity</div>
					</a>
				</div>
				<div class="grid__item" data-size="1280x1131">
					<a href="img/original/5.jpg" class="img-wrap"><img src="img/thumbs/5.jpg" alt="img05" />
						<div class="description description--grid">Ephemeral</div>
					</a>
				</div>
				<div class="grid__item" data-size="1280x857">
					<a href="img/original/6.jpg" class="img-wrap"><img src="img/thumbs/6.jpg" alt="img06" />
						<div class="description description--grid">Surreptitious</div>
					</a>
				</div>
				<div class="grid__item" data-size="1280x1280">
					<a href="img/original/7.jpg" class="img-wrap"><img src="img/thumbs/7.jpg" alt="img07" />
						<div class="description description--grid">Scintilla</div>
					</a>
				</div>
				<div class="grid__item" data-size="1280x853">
					<a href="img/original/8.jpg" class="img-wrap"><img src="img/thumbs/8.jpg" alt="img08" />
						<div class="description description--grid">Vestigial</div>
					</a>
				</div>
				<div class="grid__item" data-size="865x1280">
					<a href="img/original/9.jpg" class="img-wrap"><img src="img/thumbs/9.jpg" alt="img09" />
						<div class="description description--grid">Zephyr</div>
					</a>
				</div>
				<div class="grid__item" data-size="1280x1280">
					<a href="img/original/10.jpg" class="img-wrap"><img src="img/thumbs/10.jpg" alt="img10" />
						<div class="description description--grid">Desideratum</div>
					</a>
				</div>
				<div class="grid__item" data-size="1280x850">
					<a href="img/original/11.jpg" class="img-wrap"><img src="img/thumbs/11.jpg" alt="img11" />
						<div class="description description--grid">Quixotic</div>
					</a>
				</div>
				<div class="grid__item" data-size="1280x853">
					<a href="img/original/1.jpg" class="img-wrap"><img src="img/thumbs/1.jpg" alt="img01" />
						<div class="description description--grid">Assemblage</div>
					</a>
				</div>
				<div class="grid__item" data-size="958x1280">
					<a href="img/original/2.jpg" class="img-wrap"><img src="img/thumbs/2.jpg" alt="img02" />
						<div class="description description--grid">Demesne</div>
					</a>
				</div>
				<div class="grid__item" data-size="837x1280">
					<a href="img/original/3.jpg" class="img-wrap"><img src="img/thumbs/3.jpg" alt="img03" />
						<div class="description description--grid">Felicity</div>
					</a>
				</div>
				<div class="grid__item" data-size="1280x961">
					<a href="img/original/4.jpg" class="img-wrap"><img src="img/thumbs/4.jpg" alt="img04" />
						<div class="description description--grid">Propinquity</div>
					</a>
				</div>
				<div class="grid__item" data-size="1280x1131">
					<a href="img/original/5.jpg" class="img-wrap"><img src="img/thumbs/5.jpg" alt="img05" />
						<div class="description description--grid">Ephemeral</div>
					</a>
				</div>
			</div>
		
		
		
		
<!-- /////////////////////////////////////////////////////////////////   -->
		<div id="latest">
		<h4>최신순</h4>
		<hr/>
		
		<table>
			<!-- <tr>
				<th style="width:50px">사진번호</th>
				<th style="width:50px">앨범번호</th>
				<th>제목</th>
				<th>내용</th>
				<th style="width:150px">사진</th>
				<th style="width:60px">글쓴이</th>
				<th style="width:100px">날짜</th>
				
				ddd
			</tr> -->
			

			<c:forEach  var="photo" items="${laList}">
			
				<tr>
				
					<%-- <td>${photo.photo_no}</a></td>
					<td>${photo.album_no}</td>
					<td>${photo.photo_title}</td>
					<td>${photo.photo_content}</td> --%>
					<td>
						<a href="photoDetail?album_no=${photo.album_no}&&photo_no=${photo.photo_no}">
						<img src="${pageContext.request.contextPath}/resources/uploadfiles/${photo.photo_filesystem_name}" width="300px"/></a>
						<i id="like" class="fa fa-heart-o"></i>
						<i id="share" class="fa fa-share-square-o"></i>
					</td>
					<%-- <td>${photo.uid}</td>
					<td><fmt:formatDate value="${photo.photo_date}" pattern="yyyy-MM-dd"/></td> --%>
			
				</tr>
			</c:forEach>
		</table>
		</div>
		
		
		<div id="popularity" style="display: none;">
		<hr/><h4>좋아요순</h4><hr/>
		<table>
			<tr>
				<th style="width:50px">사진번호</th>
				<th style="width:50px">앨범번호</th>
				<th>제목</th>
				<th>내용</th>
				<th style="width:150px">사진</th>
				<th style="width:60px">글쓴이</th>
				<th style="width:100px">날짜</th>
				<th style="width:100px">좋아요</th>
				
			</tr>

	
			
			<c:forEach var="photo" items="${liList}">
				<tr>
					<td>${photo.photo_no}</a></td>
					<td>${photo.album_no}</td>
					<td>${photo.photo_title}</td>
					<td>${photo.photo_content}</td>
					<td><a href="photoDetail?album_no=${photo.album_no}&&photo_no=${photo.photo_no}">${photo.photo_original_file_name}</a></td>
					<td>${photo.uid}</td>
					<td><fmt:formatDate value="${photo.photo_date}" pattern="yyyy-MM-dd"/></td>
					<td>${photo.photo_like}</td>
					
				</tr>
			</c:forEach>
		</table> 
		</div>
		
		
		<div id="buttonGroup">
			<a href="addPhoto?album_no=${album_no}">글쓰기</a>
		</div>
		
	</body>
</html>		
		