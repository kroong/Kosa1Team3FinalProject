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
	<link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
	<script type="text/javascript" src='${pageContext.request.contextPath}/resources/js/jquery-1.11.3.min.js'></script>
	<script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
	
	<script>
		$(function() {		
			/* function loadPageinDIV(url) {
				var $showDiv = $("#showListBody");
				$showDiv.load(url, function() {
					$showDiv.find("a").on("click", function(evt) {
						var $link = $(this);
						loadPageinDIV($link.attr("href"));
						evt.preventDefault();
						return false;
					});
				});
			}
			
			loadPageinDIV("allAlbumList"); */
			
			$("#dialog").dialog({
				autoOpen : false,
				height : 500,
				width : 600,
				left : 0,
				aspectRatio : true,
				show : {
					effect : "blind",
					duration : 1000
				},
				hide : {
					effect : "explode",
					duration : 1000
				}
	
			});
	
			//$("#opener").click(function() {
				$("#myinfo").click(function(){
				$("#dialog").dialog("open");
				$("#tabs").tabs();
			});
		
			$("#modifyProfile").click(function(){
				var contextpath= $("#contextpath").val();
				console.log(contextpath);
				console.log( "adaf"+$("#email").val() );
				$.ajax({
					type: "post",
					url: contextpath+"/modifyProfile",
					  data : { "email" :$("#email").val() },
					dataType : "html",
					success : function(data){
						console.log(data);
						$("#mypage").html(data);
					}
				});
			});	
			
			$("#addfriend").click(function(){
				$("#friends").css("display","none");
				var femail = $("#femail").val();
				var loginEmail= $("#loginEmail").val();
				if(femail == loginEmail){
					alert("It's you!!! Please enter other email");
					$("#femail").val("");
				}else{
					var contextpath= $("#contextpath").val();
					console.log(contextpath);
					$.ajax({
						type: "post",
						url: contextpath+"/addFriend",
						  data : { "femail" :$("#femail").val() },
						dataType : "html",
						success : function(data){
							console.log(data);
							$("#frtable").html(data);
						}
					});
				}
				});
			
			addAlbumBox = $("#addAlbumBox").dialog({
				autoOpen : false,
				height : 300,
				width : 500,
				modal: true,
				buttons: {
					Create : function() {
						$("#addAlbumBox form").submit();
					},
					Cancel: function() {
						addAlbumBox.dialog("close");
					}
				},
				close: function() {
					$("#addAlbumBox form").reset();
				}
			});
			
			$("#addAlbumButton").on("click", function() {
				console.log("addAlbumButton");
				$("#addAlbumBox").dialog("open");
			});
			
			/* form = addAlbumBox.find("form").on("submit", function(event){
				event.preventDefault();
				
			}); */
			
			$("#showMyFriendsList").on("click", function() {
				$.ajax({
					url: "showFriendsList",
					dataType: "json",
					success: function(data) {
						console.log("ajax");
						console.log(data);
						var html = '';
						for(var i = 0; i < data.length; i++) {
							html += '<p><input type="checkbox" name="memberList[' + i + '].uid" id="cboxfor_' 
										+ data[i].uid + '" value="' + data[i].uid + '"/>';
							html += '<label for="cboxfor_"' + data[i].uid + '">&nbsp&nbsp&nbsp';
							html += data[i].member_email + '</label>&nbsp&nbsp&nbsp';
							html += '<span>' + data[i].member_nickname + '</span></p>';
						}
						$("#addAlbumField").append(html);
					},
					error: function(data) {
						console.log(data);
					}
				});
			});
			
		});
			
		function block(){
			
		alert("block누름!");
		$("#friends").css("display","none");
			var contextpath = $("#contextpath").val();
			$.ajax({
				url:contextpath+"/blockPage",
				type:"post",
				datatype:"html",
				success:function(data){
					$("#frtable").html(data);			
				}
			});
		}
		
		function search() {
			var selection = $("#search").val();
			var content = $("#searchContent").val();
	
			//검색할 내용 공백 유무 검증
			if (content == "" || content == null) {
				var status = $("em").attr("title");
				$("#validation-content").text(status);
			}
			//앨범 선택시
			else if (selection == "Album") {
				console.log("앨범");
				$("#validation-content").text("");
				//이동할 페이지 주소 입력
	
			}
			//사진 선택시
			else if (selection == "Photo") {
				console.log("사진");
				$("#validation-content").text("");
				//이동할 페이지 주소 입력
			}
		}
		
		//친구 목록, 추가 기능 Ajax
	
	</script>
	
		<style type="text/css">
		
			* {
		      margin: 0 auto;
		      padding: 0px;
		      }
		     
		     body{
		      min-width: 1083px;
		      height : 100%;
		      background-color: white;
		      margin: 0 auto;
		     }
		      
		     #pagewrapper{
		 	  margin: 0px auto;
		      padding: 0px;
		      width: 100%;
		      overflow: none;
		     }
		     
		     
		     /*  메뉴바 부분 -------------------------------------------------------------------------------------------------------------- */
		     
		     #large-header{
		     	min-width: 1083px;
		     	position: absolute;
		     	top: 0;
		     	right: 0;
		     	left: 0;
		     	z-index: 10; 
		     	display: block;
		     	/* background-color: #666699;  */
		     	background-image:url('${pageContext.request.contextPath}/resources/image/menubg.PNG'); 
		     	background-repeat: no-repeat;
           		background-size: cover;
		     	height: 100px;
		     	padding: 5px;
		     }
		     
		     #menu_wrapper{
		     	min-width: 1083px;
		     	position: fixed;
		     	top: 5px;
		     	right: 0;
		     	left: 0;
		     	z-index: 10; 
		     	display: block;
		     	height: 100px;
		     	padding: 5px;
		     }
		     
		     #small_wrapper{
				height: 80px;
				background-color: rgba(255,255,255,0)/* green */;
				padding: 5px;
				width: 650px;
				float: left;
				margin: 0px auto;
				display: table-cell;
				vertical-align: middle;
			}
			.menu {
				 display: inline; 
				 float: left; 
			}
			
			
			#btn_myinfo, #searchContent{
				float:left;
			}
			
			.ui-dialog.ui-widget.ui-widget-content.ui-corner-all.ui-front.ui-draggable.ui-resizable{
				position: relative !important;
				margin: 0 auto !important;
				left: 0px !important;
				top: 30px !important;
			}
			
			#albumit{
		 	    top: 0;
			    right: 0;
			    left: 0;
			    z-index: 10000;
			}
			
			/* 로고부분  */
			#albumitlogo{
				width: 210px;
				height: 70px;
				float: left;
				margin: 5px auto;
				padding: 5px 5px 5px 15px;
			}
			#logo{
				 width: 200px;
				 height: 60px;
				 float:left;
				 margin: 5px auto;
			}
			
			/* 내정보버튼 */
			#btn_myinfo{
				 background-color: rgba(255,255,255,0)/* black */;
				 width: 200px;
				 height: 60px;
				 border: none;
				 float: left;
				 margin: 5px auto;
				 padding: 5px;
			}
			#myinfo{
				height: 35px;
				width:180px;
				margin: 0px auto;
				background-color: rgba(255,255,255,0)/* red */;
				border: none;
				text-align: left;
				color: white;
				padding: 5px 10px 5px 10px;
				float: left;
				left: 5px;
				margin: 10px 5px 0px 10px;
				font-size: 20px;
			}
			.menu{
				background-color: none;
			}
			
			/* 검색부분  */
			#search{
				padding: 5px;
				width: 400px;
				height: 60px; 
				background-color: rgba(255,255,255,0)/* blue */;
				border: none;
				float: left;
				margin: 5px auto;
			}
			#searchContent{
				width: 300px;
				height: 35px;
				padding: 0px 2px 0px 2px;
				text-align: center;
				color: rgba(255,255,255,1);
				background-color: rgba(255,255,255,0.5); 
				border: none;
				float: left;
				margin: 10px 0px 0px 10px;
			}
			::-webkit-input-placeholder{color:rgba(255,255,255,1);}
			 #btn_search{
				height: 35px;
				border: none;
				text-align: center;
				color: rgba(255,255,255,1);
				background-color: rgba(255,255,255,0.5); 
				border: none;
				float: left;
				margin: 10px 0px 10px 0px;
				padding: 0px 2px 0px 2px;
			} 
			
			.album{
			  display: inline-block;
			  padding: 5px;
			  width: 150px;
			  height: 150px;
			  margin: 1em;
			  border: 1px;
			  border-color: white;
			}
			
			fieldset {padding:0; border:0; margin-top: 5px;}
			
			#small_wapper{
			 height: 30px;
			 width: 500px;
			 margin: 5px auto; 
			 padding: 10px;
			 display: block;
			 float: left;
			}
			
			/* 아이콘 */
			.fa{
				font-size: 25px;
				color: grey;
				margin: 5px auto;
				background-color: rgba(255,255,255,0.0) /* yellow */;
				margin: 0 auto;
				padding: 2px;
			}
			/* 오른쪽 부분 */
			#right{
				float: right;
				border: none;
				background-color: rgba(255,255,255,0)/* purple */;
				width: 400px;
				padding: 5px 0 0 0;
				height: 80px;
				margin: 0px auto;
				display: table-cell;
				vertical-align: middle;
				
			}
			#addalbumchat{
				float: right;
				border:none;
				background-color: rgba(255,255,255,0)/* fuchsia */;
				padding: 5px;
				margin: 5px auto;
				width: 150px;
				height: 60px;
				border: none;
			}
				
			#addalbum{
				height: 35px;
				width: 100px;
				border: none;
				text-align: right;
				color: rgba(255,255,255,1);
				background-color: rgba(255,255,255,0)/* red */; 
				border: none;
				float: left;
				margin: 10px 0px 10px 0px;
				padding: 0px 2px 0px 2px;
			}
			
			.menu{
				height: 35px;
				border: none;
				text-align: center;
				color: rgba(255,255,255,1);
				background-color: rgba(255,255,255,0) /* blue */; 
				border: none;
				float: left;
				margin: 10px 0px 10px 0px;
				padding: 0px 2px 0px 2px;
			}
			
		
			
			/* 선택박스 */
			#selectex { 
			    margin: 22px 10px 10px 10px;
			    padding: 7px; 
			    border: none; 
			    width: 200px;
			    float: left;
			    text-align: center;
			    background-color: /* aqua */rgba(255,255,255,03);
			    z-index: 15;
			    font-family: Verdana,sans-serif;
			}
			#selectex > ul {
				 display: none;
				 background-color: rgba(255,255,255,03);
				 border: none;
			  }
			#selectex:hover > ul {
				display: block;
				background: none;
				border-top: 1px solid rgba(255,255,255,0);
				list-style:none;
			 }
			#selectex:hover > ul > li {
				 padding: 3px;
				 border-bottom: 1px solid rgba(255,255,255,0);
			  }
			#selectex:hover > ul > li:hover {
				 background: white;
				list-style:none; 
			 }
			#selectex:hover > ul > li:hover > a {
				 color: green; 
			 }
		
			.validation{
				text-align: center;
			}
		
			#showListBody {
				position: absolute; width: 100%; top: 110px; left: 0px;
				border: none; height: 100%;
			}
		</style>
	
	</head>
	
	<body>
		<div id="pagewrapper">
<!-- ////////////////////////-메뉴바 부분-///////////////////////////////////////////////////////////////////////////////////////////////////////////////// -->
			
       <%--              <canvas id="demo-canvas">	</canvas> --%>
			 <div id="large-header" class="large-header">
			
			<!-- <div id="header" > -->
			<!-- -------------------------------------------------------------------------------------------------------------------- -->
				<div id="menu_wrapper">
				<!-- ------ 1. Albumit 로고 --------------------------------------------------------------------------------------------- -->
				
					<div id="albumitlogo">
						<img src="${pageContext.request.contextPath}/resources/image/logo.png" alt="Albumit" title="Albumit" id="logo" >
					</div>
					<!-- -------------------------------------------------------------------------------------------------------------------- -->
					<div id="small_wrapper">
				<!-- -------2. 내정보----------------------------------------------------------------------------------------------------- -->
					<!-- <div class="menu"> -->
					<div id="btn_myinfo"  class="menu">
						<%-- <input type="button" id="opener" value="${member.member_email}" /> --%>
						<input type="button"  id="myinfo" value="Hi, ${member.member_email}" />
					</div>
				<!-- --------3. 검색------------------------------------------------------------------------------------------------------- -->
				<!-- <div class="input-group margin-bottom-sm menu"> -->
					<div id="search" class="input-group margin-bottom-sm menu">
					<!-- 	 <span class="input-group-addon">
						<i class="fa fa-search fa-fw"></i>
						</span> -->
						<input id="searchContent" type="text" placeholder="Search">
						<button id="btn_search" onclick="search()"><i class="fa fa-search fa-fw"></i></button>
						<br/>
						<p id="validation">
							<em title="Please enter something you want to search" class="validation"></em>
						</p>
						<div id="validation-content"></div>
					</div>
				</div>	
				<!-- -------- 4. album/friend 옵션 선택 ----------------------------------------------------------------------------------- -->
				<div id="right">
					<!-- <div id="menu" class="menu">
						<select id="option">	
							<option> ALBUM </option>
							<option> PHOTO </option>
						</select>
					</div>
					 -->
					 
					<div id="selectex">
					 SELECT
					    <ul>
					        <li><a href="#">ALBUM</a></li>
					        <li><a href="#">PHOTO</a></li>
					    </ul>
					</div>
					<!-- --------------------------------------------------------------------------------------------------------- -->
				<div id="addalbumchat">
				<!-- ------ 5. 앨범추가 --------------------------------------------------------------------------------------------------- -->
				
					<div id="addalbum" class="menu">
						<a href="#" id="addAlbumButton"><i class="fa fa-plus-square"></i></a>
					</div>
		        <!-- ------ 6. 채팅 ------------------------------------------------------------------------------------------------------- -->
					<div id="chat" class="menu">
						<a href="#" id="chat_btn"><i class="fa fa-comments-o"></i></a>
					</div>
					
					</div>
					
					<!-- --------------------------------------------------------------------------------------------------------------------- -->
				</div>
				 <!-- --------------------------------------------------------------------------------------------------------------------- -->
				 </div>
			 <!-- --------------------------------------------------------------------------------------------------------------------- -->	
			</div>
		
<!-- ////////////////////////-메뉴바 끝///////////////////////////////////////////////////////////////////////////////////////////////////////////////// -->
		<iframe id="showListBody" src="allAlbumList"></iframe>
		
		<!-- -----내정보-------------------------------------------------------------------------------------------- -->
			<div id="dialog">
				<div id="tabs">
					<ul>
						<li><a href="#mypage">MyPage</a></li>
						<li><a href="#flist">Friends</a></li>
					</ul>
					<input type="hidden" id="email" value="${member.member_email}"/>
					<div id="mypage">
						<div id="nickname">
							nickname :
							<c:out value="${member.member_nickname }" />
						</div>
						<div>
							email :
							<c:out value="${member.member_email}" />
						</div>
						<div id="profile">
							profile :
							<c:out value="${member.member_profile }" />
						</div>
						<div id="photo"></div>
		
						<img
							src="${pageContext.request.contextPath}/resources/image/${member.member_filesystem_name}"
							width="100px" height="100px" /><br /> 
							<a href="#">pw ?</a> 
							<a href="leave">leave Albumit</a>
							<button id="modifyProfile">modifyProfile</button>
					</div>
					
		<!-- --------------------------------------------------------------------------------------------------------- -->
					<div id="flist">
					<div id="friends">
					<table>
					<tr>
					<td>email</td>
					<td>profile</td>
					<td>block</td>
					</tr>
						<c:forEach var="fr" items="${sessionScope.friendList}" >
					<tr>
						<td><c:out value="${fr.member_email }"></c:out></td>
						<td><c:out value="${fr.member_profile }"></c:out></td>
						<td> <c:out value="${fr.friend_block }"></c:out></td>
					</tr>
						</c:forEach></table>
					</div>
						
						<input type="text" id="femail" placeholder="Enter Friend's email"/>
						<input type="hidden" id="contextpath" value="${pageContext.request.contextPath}"/>
						<button id="addfriend">Add Friend</button>
							<div id="frtable">
							</div>
							
						<button onclick="block()">block!!</button>	
					</div>
				</div>
			</div>
		
		
		<!-- --------[+]앨범만들기부분---------------------------------------------------------------------------------------- -->
			<div id="addAlbumBox" title="Create a new Album">
				<form method="post" action="makeAlbum">
					<fieldset id="addAlbumField">
						<label for="album_name">Album Name</label>
						<input type="text" id="album_name" name="album_name" size="20"/><br/>
						<input type="hidden" name="uid" value="${member.uid }"/>
						<hr/>
						<p>Would you like to open this album to public?</p>
						<input type="radio" name="album_publicity" value="true"/>yes
						<input type="radio" name="album_publicity" value="false"/>no<br/>
						<hr/>
						<p>Invite Your friends to this Album!!!</p>
						<a href="#" id="showMyFriendsList">show my friends</a>
					</fieldset>
				</form>
			</div>
		</div>
	</body>
</html>