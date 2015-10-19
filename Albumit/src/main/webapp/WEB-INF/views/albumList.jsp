<%@ page contentType="text/html; charset=UTF-8"%>
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
		$(function() {
			$("#dialog").dialog({
				autoOpen : false,
				height : 500,
				width : 350,
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
					Create : function() {},
					Cancel: function() {
						addAlbumBox.dialog("close");
					}
				},
				close: function() {
					form[0].reset();
				}
			});
			
			$("#addAlbumButton").on("click", function() {
				console.log("addAlbumButton");
				$("#addAlbumBox").dialog("open");
			});
			
			form = addAlbumBox.find("form").on("submit", function(event){
				event.preventDefault();
			});
			
		});
		
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
	
<!-- <script type="text/javascript"> //헤더부분 애니메이션 추가
		var _gaq = _gaq || [];
		_gaq.push(['_setAccount', 'UA-7243260-2']);
		_gaq.push(['_trackPageview']);
		(function() {
		var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
		ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
		var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
		})();
	</script>
	
	<script type="text/javascript">
	(function() {
	    var width, height, largeHeader, canvas, ctx, circles, target, animateHeader = true;

	    // Main
	    initHeader();
	    addListeners();

	    function initHeader() {
	        width = window.innerWidth;
	        height = window.innerHeight;
	        target = {x: 0, y: height};

	        largeHeader = document.getElementById('large-header');
	        largeHeader.style.height = height+'px';

	        canvas = document.getElementById('demo-canvas');
	        canvas.width = width;
	        canvas.height = height;
	        ctx = canvas.getContext('2d');

	        // create particles
	        circles = [];
	        for(var x = 0; x < width*0.5; x++) {
	            var c = new Circle();
	            circles.push(c);
	        }
	        animate();
	    }

	    // Event handling
	    function addListeners() {
	        window.addEventListener('scroll', scrollCheck);
	        window.addEventListener('resize', resize);
	    }

	    function scrollCheck() {
	        if(document.body.scrollTop > height) animateHeader = false;
	        else animateHeader = true;
	    }

	    function resize() {
	        width = window.innerWidth;
	        height = window.innerHeight;
	        largeHeader.style.height = height+'px';
	        canvas.width = width;
	        canvas.height = height;
	    }

	    function animate() {
	        if(animateHeader) {
	            ctx.clearRect(0,0,width,height);
	            for(var i in circles) {
	                circles[i].draw();
	            }
	        }
	        requestAnimationFrame(animate);
	    }

	    // Canvas manipulation
	    function Circle() {
	        var _this = this;

	        // constructor
	        (function() {
	            _this.pos = {};
	            init();
	            console.log(_this);
	        })();

	        function init() {
	            _this.pos.x = Math.random()*width;
	            _this.pos.y = height+Math.random()*100;
	            _this.alpha = 0.1+Math.random()*0.3;
	            _this.scale = 0.1+Math.random()*0.3;
	            _this.velocity = Math.random();
	        }

	        this.draw = function() {
	            if(_this.alpha <= 0) {
	                init();
	            }
	            _this.pos.y -= _this.velocity;
	            _this.alpha -= 0.0005;
	            ctx.beginPath();
	            ctx.arc(_this.pos.x, _this.pos.y, _this.scale*10, 0, 2 * Math.PI, false);
	            ctx.fillStyle = 'rgba(255,255,255,'+ _this.alpha+')';
	            ctx.fill();
	        };
	    }

	})(); 
	
	</script>-->
	
		<style type="text/css">
		
			* {
		      margin: 0 auto;
		      padding: 0px;
		      }
		     
		     body{
		      width: 1000px;
		      height : 100%;
		      background-color: white;
		      margin: 0 auto;
		     }
		      
		     #pagewrapper{
		 	  margin: 0px;
		      padding: 0px;
		     }
		     
		     
		     /*  메뉴바 부분 -------------------------------------------------------------------------------------------------------------- */
		     
		     #large-header{
		     	min-width: 1083px;
		     	position: fixed;
		     	top: 0;
		     	right: 0;
		     	left: 0;
		     	z-index: 10; 
		     	display: block;
		     	/* background-color: #666699; */
		     	background-image:url('${pageContext.request.contextPath}/resources/image/watercolor.jpg');
		     	background-repeat: no-repeat;
           		background-size: cover;
		     	height: 100px;
		     	padding: 5px;
		     }
		     
		     #menu_wrapper{
		     	min-width: 1083px;
		     	position: fixed;
		     	top: 0;
		     	right: 0;
		     	left: 0;
		     	z-index: 10; 
		     	display: block;
		     	height: 100px;
		     	padding: 5px;
		     }
		     
		     #small_wrapper{
				height: 80px;
				background-color: green;
				padding: 5px;
				margin: 5px;
				width: 600px;
				float: left;
			}
	/* 	     #demo-canvas{
				position: fixed;
		     	top: 0;
		     	right: 0;
		     	left: 0;
		     	z-index: 10; 
		     	display: block;
		 	   background-color: black;
	 	    	height: 150px; 
		     } */
		     
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
				margin: 5px;
				padding: 5px;
			}
			#logo{
				 width: 200px;
				 height: 60px;
				 float:left;
				 margin: 10px;
			}
			
			/* 내정보버튼 */
			#btn_myinfo{
				 background-color: black;
				 width: 200px;
				 height: 60px;
				 border: none;
				 float: left;
				 margin: 5px;
				 padding: 5px;
			}
			#myinfo{
				height: 35px;
				width:180px;
				background-color: red;
				border: none;
				text-align: center;
				color: white;
				padding: 3px;
				float: left;
				margin: 5px;
				padding: 5px;
			}
			.menu{
				background-color: none;
			}
			
			/* 검색부분  */
			#search{
				padding: 5px;
				width: 300px;
				height: 60px; 
				background-color: blue;
				border: none;
				float: left;
				margin: 5px;
			}
			#searchContent{
				width: 200px;
				height: 40px;
				padding: 0px 2px 0px 2px;
				text-align: center;
				color: rgba(255,255,255,1);
				background-color: rgba(255,255,255,0.5); 
				border: none;
				float: left;
			}
			::-webkit-input-placeholder{color:rgba(255,255,255,0.7);}
			#btn_search{
				height: 40px;
				border: none;
				text-align: center;
				color: white;
				background-color: orange/* rgba(255,255,255,0.5) */; 
				border: none;
				float: left;
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
			 margin: 10px; 
			 padding: 10px;
			 display: block;
			 float: left;
			}
			
			/* 아이콘 */
			.fa{
				font-size: 25px;
				color: white;
				padding: 0px;
				margin: 10px;
			}
			
			#right{
				float: right;
				border: none;
				background-color: purple;
			}
			
			#menu{
				width: 100px;
				height: 50px;
			}
			
			/* 선택박스 */
			#selectex { 
			    margin: 10px;
			    padding: 3px; 
			    border: none/* 2px solid rgba(255,255,255,1) */; 
			    width: 200px;
			    float: right;
			    text-align: center;
			    background-color: rgba(255,255,255,1);
			    z-index: 15;
			}
			#selectex > ul {
				 display: none;
				 background-color: white;
			  }
			#selectex:hover > ul {
				display: block;
				background: none;
				border-top: 1px solid rgba(255,255,255,0);
			 }
			#selectex:hover > ul > li {
				 padding: 3px;
				 border-bottom: 1px solid rgba(255,255,255,0);
			  }
			#selectex:hover > ul > li:hover {
				 background: white;
			 }
			#selectex:hover > ul > li:hover > a {
				 color: red; 
			 }
		
		.validation{
		float: 11;
		text-align: center;
		color: red;
		}
		
		#dialog{
		border-color: red;
		background-color: gray;
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
					    Select
					    <ul>
					        <li><a href="#">ALBUM</a></li>
					        <li><a href="#">PHOTO</a></li>
					    </ul>
					</div>
					
				<!-- ------ 5. 앨범추가 --------------------------------------------------------------------------------------------------- -->
				
					<div class="menu">
						<a href="#" id="addAlbumButton"><i class="fa fa-plus-square"></i></a>
					</div>
		        <!-- ------ 6. 채팅 ------------------------------------------------------------------------------------------------------- -->
					<div class="menu">
						<a href="#" id="chat_btn"><i class="fa fa-comments-o"></i></a>
					</div>
					
					</div>
					
					<!-- --------------------------------------------------------------------------------------------------------------------- -->
				
				 <!-- --------------------------------------------------------------------------------------------------------------------- -->
				 </div>
			 <!-- --------------------------------------------------------------------------------------------------------------------- -->	
			</div>
		
<!-- ////////////////////////-메뉴바 끝///////////////////////////////////////////////////////////////////////////////////////////////////////////////// -->
		
		
		
		
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
						<input type="text" id="femail" placeholder="Enter Friend's email"/>
						<input type="hidden" id="contextpath" value="${pageContext.request.contextPath}"/>
						<button id="addfriend">Add Friend</button>
							<div id="frtable">
							</div>
					</div>
				</div>
			</div>
		
		
		<!-- --------[+]앨범만들기부분---------------------------------------------------------------------------------------- -->
		<div id="addAlbumBox" title="Create a new Album">
			<form>
				<fieldset>
					<label for="album_name">Album Name</label>
					<input type="text" id="album_name" name="album_name" size="20"/><br/>
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
	<!-- --------------------------------------------------------------------------------------------------------- -->
		<div>
			<a href="photoList" class="album">
				<input type="image" />
			</a>	
			<a href="photoList" class="album">
				<input type="image" />
			</a>	
			<a href="photoList" class="album">
				<input type="image" />
			</a>		
			<a href="photoList" class="album">
				<input type="image" />
			</a>	
			<a href="photoList" class="album">
				<input type="image" />
			</a>	
			<a href="photoList" class="album">
				<input type="image" />
			</a>	
			<a href="photoList" class="album">
				<input type="image" />
			</a>	
			<a href="photoList" class="album">
				<input type="image" />
			</a>	
		</div>
		
		
	<div>
		<p>앨범 예시</p>
		
		<a href="photoList?album_no=1">album1</a>	
		<a href="photoList?album_no=2">album2</a>	
		

	</div>

	
	
</div>	
	
	
	
	
	
</body>
</html>