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
			
			//스크롤이 생기지 않도록 iframe 높이 조정-----------------------
			var winHeight = $(window).height();
			var headerHeight = $("#large-header").height();
			$("#showListBody").height(winHeight-headerHeight-50);
			//----------------------------------------------------
			
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
	
	<!-- 셀렉트박스 -->
	<script type="text/javascript">
		// HELPERS //
		NodeList.prototype.forEach = function (callback) {
		  Array.prototype.forEach.call(this, callback);
		}

		// Function definitions //
	
		function deactivateSelect(select) {
		  if (!select.classList.contains('active')) return;
	
		  var optList = select.querySelector('.optList');
	
		  optList.classList.add('hidden');
		  select.classList.remove('active');
		}
	
		function activeSelect(select, selectList) {
		  if (select.classList.contains('active')) return;
	
		  selectList.forEach(deactivateSelect);
		  select.classList.add('active');
		};
	
		function toggleOptList(select, show) {
		  var optList = select.querySelector('.optList');
	
		  optList.classList.toggle('hidden');
		}
	
		function highlightOption(select, option) {
		  var optionList = select.querySelectorAll('.option');
	
		  optionList.forEach(function (other) {
		    other.classList.remove('highlight');
		  });
	
		  option.classList.add('highlight');
		};
	
		function updateValue(select, index) {
		  var nativeWidget = select.previousElementSibling;
		  var value = select.querySelector('.value');
		  var optionList = select.querySelectorAll('.option');
	
		  optionList.forEach(function (other) {
		    other.setAttribute('aria-selected', 'false');
		  });
	
		  optionList[index].setAttribute('aria-selected', 'true');
	
		  nativeWidget.selectedIndex = index;
		  value.innerHTML = optionList[index].innerHTML;
		  highlightOption(select, optionList[index]);
		};
	
		function getIndex(select) {
		  var nativeWidget = select.previousElementSibling;
	
		  return nativeWidget.selectedIndex;
		};
	
		// Event binding //
	
		window.addEventListener("load", function () {
		  var form = document.querySelector('form');
		 
		  form.classList.remove("no-widget");
		  form.classList.add("widget");
		});
	
		window.addEventListener('load', function () {
		  var selectList = document.querySelectorAll('.select');
	
		  selectList.forEach(function (select) {
		    var optionList = select.querySelectorAll('.option'),
		        selectedIndex = getIndex(select);
	
		    select.tabIndex = 0;
		    select.previousElementSibling.tabIndex = -1;
	
		    updateValue(select, selectedIndex);
	
		    optionList.forEach(function (option, index) {
		      option.addEventListener('mouseover', function () {
		        highlightOption(select, option);
		      });
	
		      option.addEventListener('click', function (event) {
		        updateValue(select, index);
		      });
		    });
	
		    select.addEventListener('click', function (event) {
		      toggleOptList(select);
		    });
	
		    select.addEventListener('focus', function (event) {
		      activeSelect(select, selectList);
		    });
	
		    select.addEventListener('blur', function (event) {
		      deactivateSelect(select);
		    });
	
		    select.addEventListener('keyup', function (event) {
		      var length = optionList.length,
		          index  = getIndex(select);
	
		      if (event.keyCode === 40 && index < length - 1) { index++; }
		      if (event.keyCode === 38 && index > 0) { index--; }
	
		      updateValue(select, index);
		    });
		  });
		});
	</script>
	
		<style type="text/css">
		
			* {
		      margin: 0 auto;
		      padding: 0px;
		      }
		     
		     body{
		      min-width: 960px;
		      height : 100%;
		      background-color: white;
		      margin: 0 auto;
		      /* position: fixed; */
		      scroll: no;
		     }
		      
		     #pagewrapper{
		 	  margin: 0px auto;
		      padding: 0px;
		      width: 100%;
		      overflow: none;
		     }
		     
		     
 /*  메뉴바 부분 -------------------------------------------------------------------------------------------------------------- */
		     
		     #large-header{
		     	min-width: 960px;
		     	position: fixed;
		     	top: 0;
		     	right: 0;
		     	left: 0;
		     	z-index: 10; 
		     	display: block;
		     	background-color: black;
		     	/* background-image:url('${pageContext.request.contextPath}/resources/image/menubg.PNG'); 
		     	background-repeat: no-repeat;
           		background-size: cover; */
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
				width: 600px;
				background-color: rgba(255,255,255,0)/* green */;
				padding: 5px;
				/* width: 650px; */
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
			
			
			
			/* 아이콘 */
			.fa{
				font-size: 25px;
				color: white;
				margin: 5px auto;
				background-color: rgba(255,255,255,0.0) /* yellow */;
				margin: 0 auto;
				padding: 2px;
			}
			
			/* 오른쪽 부분 */
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
			
		
			#showListBody {
				position: absolute; width: 100%; top: 110px; left: 0px;
				border: none; height: 100%;
			}
			
			/* ======= */
			/* 셀렉트박스 */
			/* ======= */
			
			#menu{
			 width: 100px;
			 height: 35px;
			 float:left; 
			 margin: 10px 0px 10px 10px;
			 padding: 0px 2px 0px 2px;
			}
			
			.widget select, .no-widget .select {
			  position : absolute;
				left: -5000em;
			  height   : 0;
			  overflow : hidden;
			}
			 
			/* 셀렉트 박스 - Required Styles */
			.select {
			  position: relative;
			  display : inline-block;
			  height: 35px;
			  margin: 10px 0px 10px 0px;
			padding: 0px 2px 0px 2px;
			
			}
			 
			.select.active, .select:focus {
			  box-shadow: 0 0 3px 1px #227755;
			  outline: none;
			}
			 
			.select .optList {
			  position: absolute;
			  top: 100%;
			  left: 0;
			  cursor: pointer;
			}
			 
			.select .optList.hidden {
			  max-height: 0;
			  visibility: hidden;
			}
			 
			/* 셀렉트 박스 - Fancy Styles */
			.select {
			  font-size   : 15px;
			  text-align: center;
			  font-family : Verdana, Arial, sans-serif;
			  -moz-box-sizing : border-box;
			  box-sizing : border-box;
			  padding: 1px 25px 2px 5px; 
			  width: 100px; 
			  border: 2px solid #000;
			  /* border-radius : 4px;  */
			 
			  box-shadow : 0 1px 2px rgba(0,0,0,.45); 
			 
			  background : #F0F0F0;
			  background : -webkit-linear-gradient(90deg, #E3E3E3, #fcfcfc 50%, #f0f0f0);
			  background : linear-gradient(0deg, #E3E3E3, #fcfcfc 50%, #f0f0f0);
			}
			 
			.select .value {
			  display: inline-block;
			  width: 100%;
			  height: 30px;
			  overflow: hidden;
			  white-space: nowrap;
			  text-overflow: ellipsis;
			  vertical-align: middle;
			  text-align: center;
			}
			 
			.select:after {
			  content: "▼";
			  position: absolute;
			  z-index: 1;
			  height: 100%;
			  width: 25px; 
			  top: 0;
			  right: 0;
			  padding-top: .1em;
			  -moz-box-sizing: border-box;
			  box-sizing: border-box;
			  text-align : center;
			  border-left  : .2em solid #fff;
			  border-radius: none/* 0 .1em .1em 0 */;
			  background-color : #FFF;
			  color : #000;
			  cursor: pointer;
			}
			 
			.select .optList {
			  z-index : 2;
			  list-style: none;
			  margin : 0;
			  padding: 0;
			  background: #f0f0f0;
			  border: 2px solid #000;
			  border-top-width : .1em;
			  /* border-radius: 0 0 .4em .4em; */
			  box-shadow: 0 .2em .4em rgba(0,0,0,.4);
			  -moz-box-sizing : border-box;
			  box-sizing : border-box;
			  min-width : 100%;
			  max-height: 100px; 
			  overflow-y: auto;
			  overflow-x: hidden;
			}
			 
			.select .option {
			  padding: 2px;
			  height: 28px;
			  width: 90px;
			}
			 
			.select .highlight {
			  background: #000;
			  color: #FFFFFF;
			}
			

						
		</style>
	
	<!-- 푸터부분 -->	
	<style type="text/css">
	
	footer{
	position: fixed;
	bottom: 0px;
	left: 0px;
	width: 100%;
	height: 30px;
	background-color: black;
	border-top: 1px solid #222;
	z-index: 5;
	}
	footer ul{
	width: 40%;
	height: 30px;
	float: left;
	margin-left: 30px;
	margin-top: 3px;
	}
	footer ul li{
	float: left;
	width: 20%;
	text-align: center;
	color: white;
	list-style: none;
	font: 10px/2 obitron;
	vertical-align: middle;
	}
	footer span{
	font: 10px/2 obitron;
	color: white;
	float: right;
	letter-spacing: 1px;
	margin-right: 40px;
	margin-top: 4px;
	}	
		</style>
	</head>
	
	<body>
		<div id="pagewrapper">
<!-- ////////////////////////-메뉴바 부분-///////////////////////////////////////////////////////////////////////////////////////////////////////////////// -->
			
			 <div id="large-header" class="large-header">
			
			<!-- <div id="header" > -->
			<!-- -------------------------------------------------------------------------------------------------------------------- -->
				<div id="menu_wrapper">
				<!-- ------ 1. Albumit 로고 --------------------------------------------------------------------------------------------- -->
					<div id="albumitlogo">
						<a href="main"><img src="${pageContext.request.contextPath}/resources/image/logo.png" alt="Albumit" title="Albumit" id="logo" ></a>
					</div>
					<!-- -------------------------------------------------------------------------------------------------------------------- -->
<!-- -------2. 내정보----------------------------------------------------------------------------------------------------- -->
					<!-- <div class="menu"> -->
					<div id="btn_myinfo"  class="menu">
						<input type="button"  id="myinfo" value="Hi, ${member.member_email}" />
					</div>

		<div id="small_wrapper">
					
<!-- -------- 3. album/friend 옵션 선택 ----------------------------------------------------------------------------------- -->
		<!-- <div id="right"> -->
					<!--  <div id="menu" class="menu">
						<select id="option">	
							<option> ALBUM </option>
							<option> PHOTO </option>
						</select>
					</div> -->
					 
			<!--스타일적용옵션  -->
			<form id="menu" class="no-widget">
			  <select name="styleoption">
			    <option>ALBUM</option>
			    <option>PHOTO</option>
			   </select>
			  
			  <div class="select" role="listbox">
			    <span class="value">ALBUM</span>
			    <ul class="optList hidden" role="presentation">
			      <li class="option" role="option" aria-selected="true">ALBUM</li>
			      <li class="option" role="option">PHOTO</li>
			    </ul>
			  </div>
			</form>
								
	
	<!-- --------4. 검색------------------------------------------------------------------------------------------------------- -->
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
				
				
				
<!-- -------------------------------------------------------------------------------------------------------------------- -->
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
				<!-- </div> -->
				 <!-- --------------------------------------------------------------------------------------------------------------------- -->
				 </div>
			 <!-- --------------------------------------------------------------------------------------------------------------------- -->	
			</div>
		
<!-- ////////////////////////-메뉴바 끝///////////////////////////////////////////////////////////////////////////////////////////////////////////////// -->
		<iframe id="showListBody" src="allAlbumList"></iframe>
		
<!-- //푸터// -->
	<footer> 
		<ul>
			<li>Team3 Project</li>
			<li>2015-10-31</li>
			<li>TestVer.</li>
		</ul>
		<span>Copyright © 2015 ALBUMIT ALL Rights Reserved.</span>
	</footer>
		
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