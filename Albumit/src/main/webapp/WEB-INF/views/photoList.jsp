<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		<style type="text/css">
		#darken-background {
            position: absolute;
            top: 0; left: 0; right: 0;
            height: 100%; 

            display: none;
            background: rgba(0, 0, 0, 0.9);
            z-index: 10000;
            overflow-y: scroll;
        }

        #lightbox {
            width: 700px;
            margin: 20px auto; padding: 15px;

            border: 1px solid #333333;
            border-radius: 5px;
            background: white;
            box-shadow: 0 5px 5px rgba(34, 25, 25, 0.4);

            text-align: center;
        }
         .paper {
            width: 190px;
            margin-top: 10px;
            padding: 15px 15px 0;
            font-size: 11px;
            background: #FFFFFF;
            box-shadow: 0 1px 3px rgba(34, 25, 25, 0.4);
        }

       

        

      
		</style>

		<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
    	<script src="resources/js/jquery.masonry.min.js"></script>
   		<script src="resources/js/jquery.imagesloaded.min.js"></script>
		
		
		<script type="text/javascript">

			/* $(document).ready(function(){
				
				for(var i=0; i<100; i++){
					$('<div></div>').addClass('box').css({
						width:100,
						height: Math.floor(Math.random()*100)+50
					}).appendTo('body');
				}
				
				$('body').masonry({
					columnWidth:100
				});
				
			});
			 */

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
			
			var row= $(this).parents("tr").index();
	    	  console.log("row1:::::"+row);
	    	  var like = document.getElementById("myTable").rows[row].cells.namedItem("좋아요").innerHTML;
	    	  var album_no = document.getElementById("myTable").rows[row].cells.namedItem("앨범번호").innerHTML;
	    	  var photo_no = document.getElementById("myTable").rows[row].cells.namedItem("사진번호").innerHTML;
	    	  console.log("like:"+like);
			
			 var likephoto = document.getElementById("${photo.photo_no}"); 
			
			   likephoto.addEventListener('click', function(){
			    	
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
			    }); 
		
		
		        // 페이지
		        $(document).ready(function () {
		            // 이미지 로드 확인
		            $('#main-section').imagesLoaded(function () {
		                // jQuery Masonry 플러그인 적용
		                $('#main-section').masonry({
		                    itemSelector: '.paper',
		                    columnWidth: 500,
		                    isAnimated: true
		                });
		            });
		});
		         
		     // 라이트 박스
		        $(document).ready(function () {
		            function showLightBox() {
		                // 라이트박스를 보이게 합니다.
		                $('#darken-background').show();
		                $('#darken-background').css('top', $(window).scrollTop());
		                // 스크롤을 못하게 합니다.
		                $('body').css('overflow', 'hidden');
		            }

		            function hideLightBox() {
		                // 라이트박스를 안 보이게 합니다.
		                $('#darken-background').hide();

		                // 스크롤을 하게 합니다.
		                $('body').css('overflow', '');
		            }

		            // 라이트박스 제거 이벤트
		            $('#darken-background').click(function () {
		                hideLightBox();
		            });

		              // 클릭 이벤트 연결
		            $('.paper').click(function () {
		                showLightBox();
		            });

		            // 라이트박스 제거 이벤트 보조
		            $('#lightbox').click(function (event) {
		                event.stopPropagation()
		            });
		        });
		        
		</script>
		
	</head>
	
	<body>
		
		<select id="photoArray" size="1" onchange="arrayfun(this)">
			<option value="latest" selected="selected" >최신순</option>
			<option value="popularity">인기순</option>
		</select>

		<div id="latest">
		<h4>최신순</h4>
		<hr/>
		
			<c:forEach  var="photo" items="${laList}">
			
				
					<section id="main-section"> 
         
			        <div class="paper"> 
			            <div class="paper-holder"> 
			               <%-- <a href="photoDetail?album_no=${photo.album_no}&&photo_no=${photo.photo_no}"> --%>
						<a href="photoDetail?album_no=${photo.album_no}&&photo_no=${photo.photo_no}">
						<img src="${pageContext.request.contextPath}/resources/uploadfiles/${photo.photo_filesystem_name}"/></a>
			            </div> 
			            <p class="paper-description">Lorem ipsum dolor sit amet</p> 
			            </div> 
			        </div>
						<%-- <a href="photoDetail?album_no=${photo.album_no}&&photo_no=${photo.photo_no}">
						<img src="${pageContext.request.contextPath}/resources/uploadfiles/${photo.photo_filesystem_name}" width="300px"/></a>
						<i id="like" class="fa fa-heart-o"></i>
						<i id="share" class="fa fa-share-square-o"></i> --%>
					
			</c:forEach>
			
					<!-- 라이트박스 --> 
		    <div id="darken-background"> 
		        <div id="lightbox"> 
		                    <h3>User</h3>
		                    <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam sem mi, egestas a facilisis eget, egestas ut magna.</p>
		                </div> 
		            </div>
		            <hr class="lightbox-splitter" />
		            <img src="${pageContext.request.contextPath}/resources/uploadfiles/${photo.photo_filesystem_name}" /> 
		        </div> 
		    </div> 
			
			
			
		</div>
		
		
		<div id="popularity" style="display: none;">
		<hr/><h4>좋아요순</h4><hr/>
		
		
		
		<div id="1">
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
		
		</div>
		
		
		
		<div id="buttonGroup">
			<a href="addPhoto?album_no=${album_no}">글쓰기</a>
		</div>
		
	</body>
</html>		
		