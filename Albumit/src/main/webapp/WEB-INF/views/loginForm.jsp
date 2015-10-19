<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Albumit!</title>
<!-- 파비콘설정 -->
<link rel="icon"  href="${pageContext.request.contextPath}/resources/image/favicon.ico" type="image/x-icon"/> 

<style>
   * {
      margin: 0px;
      padding: 0px;
      }
      
   body {
      width: 960px;
      height: 100%;
      margin: 0 auto;
      padding: 100px;
      /*background-image: url('${pageContext.request.contextPath}/resources/image/watercolor.jpg'); 
      background-repeat: no-repeat;
      background-size: cover; */
      }      
   
   /* 배경 비디오 */
   .vid{
	   	width: 100%;
	   	height: 100%;
	   	position: fixed;
	   	top: -60px;
	   	left: 0px;
	   	opacity: 0.9; 	 /* 동영상 투명도 조절  */
	   	z-index: -10;
   }
	.vid video{
	   	width:100%;
	   	min-width: 1600px;
   } 
    
   #pagewrapper{
      margin: 0 auto;
      vertical-align: middle;
      height: 100%;
   }
   
   /* 원부분 */   
   #loginForm{
      background-color: rgba(255, 255, 255, 0.3);
      margin: 0 auto;
      width: 330px;
      height: 330px;
      border-radius:330px;
      margin: 0 auto;
      padding: 20px;   
   }
   #login{
      padding: 10px 10px 10px 10px;
      /*  top-right-bottom-left]; */
   }
  
  #loginFormwrapper{
	  margin: 15px 0px 15px 0px;
	  padding: 10px;
	  text-align: center;
	  vertical-align: middle;
	}
	  
   	/* 로고 */
   #logo{
       width: 80%;
       height: 70%;
       text-align: center;
       /* padding :10px; */
       margin: auto;
   } 
   
   #uname, #upw{
      font-color: rgb(255,255,255);
      margin: 5px 0px;
      height: 30px;
      width: 100%;
 	  background-color: rgba(255,255,255,0.1); 
 	  border-bottom: 0.5px solid white;  	 
      border-left: 0px solid;
      border-top:0.5px solid white;
      border-right: 0px solid;
      border-radius: 5px;
      font-family: Verdana,sans-serif;
      text-align: center;
   }
   
   ::-webkit-input-placeholder{color:rgba(255,255,255,0.7);}
   
   /* 로그인 버튼 */
   #loginbtn{
      margin: 10px 0px;
      height: 30px;
      width: 100%;
      background-color: rgba(255,255,255,0.5);
      border-color: rgba(255,255,255,0);
      border-radius: 5px;
      text-align: center;
      vertical-align: middle;
      cursor: pointer;
      font-size: 14pt;
      color: rgba(204, 0, 82, 0.8);
      font-family: Verdana,sans-serif;
   }
   #loginbtn:hover {
		background-color: rgba(255, 255, 255, 0.7);
		text-decoration: none;
		box-shadow: 2px 2px 2px silver;
	}
	#loginbtn:active {
		background: rgba(135, 80, 25, 0.3); /* 지금은 브라운임! */
		text-decoration: none;
	}

   #findPW{
      font-size: 10pt;
      text-align: center;
      vertical-align: middle;
      font-family: Verdana,sans-serif;
      color: white;
   }
   
</style>
</head>

<body>
	
	<figure class="vid">
		<video loop autoplay>
			<source src="${pageContext.request.contextPath}/resources/image/albumitbgvid.mp4" type="video/mp4"/>
		</video>
	</figure> 
	 
   <div id="pagewrapper">
      <div id="loginForm">
      	<div id="loginFormwrapper">
	         <div id="albumit">
	            <img src="${pageContext.request.contextPath}/resources/image/logo.png" alt="Albumit" title="Albumit" id="logo">
	         </div>
	         <div id="login">
	            <form:form commandName="member">
	               <div id="username">
	                  <form:input type="e-mail"  id="uname" path="member_email" size="20" placeholder="Your@email.com" style="text-align: center; border-top: rgba(255,255,255,0.3); 1px solid; border-bottom: rgba(255,255,255,0.3);1px solid;"/><br/>
	               </div>   
	               <div id="userpw">   
	                  <form:password id="upw" path="member_password" size="20"  placeholder="Your password" style="text-align: center"/><br/>
	               </div>
	               <div id="btn">
	                  <input id="loginbtn" type="submit" value="login" />
	               </div>
	            </form:form>
	         </div>
	         <br/>
	         <div id="findPW">
	            <a href="findPWForm">Forgot your Password?</a>
	            <a> | </a>
	            <a href="join">Sign Up</a>
	         </div>
         </div>
      </div> 
   </div>
</body>
</html>