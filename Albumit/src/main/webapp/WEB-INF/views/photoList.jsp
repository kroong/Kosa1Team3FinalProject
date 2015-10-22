<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<!DOCTYPE html>
<html>
	<head>
	<link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
  <script src="//code.jquery.com/jquery-1.10.2.js"></script>
  <script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		<style type="text/css">
			body{
				
			}
			
	        .main_photo{
	        	display:inline-block;
	        	width:300px;
	        	height:500px;
	        	margin: 10px;
	        	background: gray;
	        	box_shadow: 0 1px 3px rgba(34,25,25,0.4);
	        }
	        
	        /* nav */
	        nav {
	        display:inline;
	        	width:20%;
	        }
	       	nav ul{padding-left:5px; }                   
         	nav ul li {
            	display:inline;                        
            	border-left:1px solid #999;            
            	font:bold 12px Dotum;                    
            	padding:0 10px;                        
        	}
         	nav ul li:first-child{border-left:none;}  
         	nav ul li:nth-child(4){border-left:none;}  
         	nav ul li:last-child{border-left:none;} 
         	 
		    .menu a{cursor:pointer;}
   			 .menu .hide{display:none;}
		</style>

		<script type="text/javascript">

			/* $(document).ready(function(){
				
				for(var i=0; i<100; i++){
					$('.main_photo').css({
						width:100,
						height: Math.floor(Math.random()*100)+50
					}).appendTo('body');
				}
				
			}); */
			

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
			
		/* 	var row= $(this).parents("tr").index();
	    	 console.log("row1:::::"+row);
	    	  var like = document.getElementById("myTable").rows[row].cells.namedItem("좋아요").innerHTML;
	    	  var album_no = document.getElementById("myTable").rows[row].cells.namedItem("앨범번호").innerHTML;
	    	  var photo_no = document.getElementById("myTable").rows[row].cells.namedItem("사진번호").innerHTML;
	    	  console.log("like:"+like);
			
			 var likephoto = document.getElementById("${photo.photo_no}");  */
			
			<%--    likephoto.addEventListener('click', function(){
			    	
			        //ajax part
			  
			        
			        
			        alert($(".likephoto").val());
			       /*  var album_no = $("input[name=album_no]").val();
			        var photo_no = $("input[name=photo_no]").val(); */
			  		alert("ano:"+album_no);
			  		alert("pno:"+photo_no);
			        
			        $.ajax({
			            type: "get",
			            url: 'addLike',
			            data:  { "album_no": album_no, "photo_no": photo_no},
			            //change button
			            success: function (msg){ 
			            	document.getElementById('likephoto').innerHTML=msg.photoLike;
			            	<%System.out.println("Please");%>
			            },
			            error: function (err)
			            { alert(err.responseText)}
			        });
			    });  --%>
			   
			   
			        // menu 클래스 바로 하위에 있는 a 태그를 클릭했을때
 $(document).ready(function(){
        // memu 클래스 바로 하위에 있는 a 태그를 클릭했을때
        $(".menu>a").click(function(){
            // 현재 클릭한 태그가 a 이기 때문에
            // a 옆의 태그중 ul 태그에 hide 클래스 태그를 넣던지 빼던지 한다.
            $(this).next("ul").toggleClass("hide");
        });
    });
			   
		</script>
		
	</head>
	
	<body>
	
		<nav>
		<ul>
			<li>Post </li>
			<li class="menu"><a>Move to </a> 
				<ul class="hide">
					<li>1</li>
					<li>2</li>
				</ul>
			
			</li>

			<li>Share Album</li>
			<li><button>Confirm</button></li>
			<li>
				<select id="photoArray" size="1" onchange="arrayfun(this)">
			<option value="latest" selected="selected" >최신순</option>
			<option value="popularity">인기순</option>
		</select></li>
		</ul>
		</nav>
		<div id="latest">
		<h4>최신순</h4>
		<hr/>
		
			<c:forEach  var="photo" items="${laList}">
				<div class="main_photo"> 
					<a href="photoDetail?album_no=${photo.album_no}&&photo_no=${photo.photo_no}">
					<img src="${pageContext.request.contextPath}/resources/uploadfiles/${photo.photo_filesystem_name}" width="300px"/></a>
					<hr/>
					<i id="like" class="fa fa-heart-o" style="color:white"></i>
					<i id="share" class="fa fa-share-square-o"></i>
				</div> 
			
			</c:forEach>
		</div>
		
		
		<div id="popularity" style="display: none;">
		<hr/><h4>좋아요순</h4><hr/>
		<table id="myTable">
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
					<td>${photo.photo_no}<input name="photo_no" type ="hidden" value="${photo.photo_no}"/></td>
					<td>${photo.album_no}<input name="album_no" type ="hidden" value="${photo.album_no}"/></td>
					<td>${photo.photo_title}</td>
					<td>${photo.photo_content}</td>
					<td><a href="photoDetail?album_no=${photo.album_no}&&photo_no=${photo.photo_no}">${photo.photo_original_file_name}</a></td>
					<td>${photo.uid}</td>
					<td><fmt:formatDate value="${photo.photo_date}" pattern="yyyy-MM-dd"/></td>
					<td id="${photo.photo_no}">${photo.photo_like}</td>
					
				</tr>
			</c:forEach>
		</table> 
		</div>
		
		<div id="buttonGroup">
			<a href="addPhoto?album_no=${album_no}">글쓰기</a>
		</div>
		
	</body>
</html>		
		