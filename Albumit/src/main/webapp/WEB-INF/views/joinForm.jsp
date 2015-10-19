<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>

<html>
   <head>
      <meta charset="UTF-8">
      <title>Albumit</title>
		<!-- 파비콘설정 -->
		<link rel="icon"  href="${pageContext.request.contextPath}/resources/image/favicon.ico" type="image/x-icon"/> 
      <style type="text/css">
         * {
            margin: 0px;
            padding: 0px;
         }
         body {
            width: 960px;
            height : 600px;
            margin: 0 auto;
            padding: 50px;
            font-size: small;
            color: black;
            font-family: Verdana,sans-serif;
            background-image: url('${pageContext.request.contextPath}/resources/image/watercolor.jpg');
            background-repeat: no-repeat;
            background-size: cover;
         }
         
         #pagewrapper{
            margin: 0px auto;
            padding: 50px;
            background-color: rgba(255,255,255,0);
            border-radius: 30px; 
            width: 400px; 
            height: 350px;
            text-align: center;
         }
         
         input {
            font-size: 12px;
         }
         
         #emailform, #passwordform, #nicknameform, #Smessageform {
/*          padding: 10px;
            margin: 3px;
            width: 90%;
            height: 10px;
            border-radius: 5px;
            background-color: rgba(255,255,255,0);
            font-family: Verdana,sans-serif;
            text-align: center;
            font-color: rgba(255,255,255,1);
            font-color: rgb(255,255,255); */
			margin: 5px 0px;
			height: 30px;
			width: 100%;
			background-color: rgba(255,255,255,0.4); 
			border-bottom: 0.5px solid white;  	 
			border-left: 0px solid;
			border-top:0.5px solid white;
			border-right: 0px solid;
			border-radius: 5px;
			font-family: Verdana,sans-serif;
			text-align: center;
			box-shadow: 2px 2px 10px purple;
         }
         
         ::-webkit-input-placeholder{color:rgb(204, 0, 82);}
         
         .signup{
            text-align: left;
            color: white;
            text-shadow: 5px 5px 5px purple;
         }
         
         #albumit {
             width: 100%;
             height: 78px;
             text-align: center;
         }
         
         #member{
            margin: 10px 0px 10px 0px;
            /*  top-right-bottom-left]; */
         }
       
          #logo{
		    width: 80%;
		    height: 80%;
		    text-align: center;
		    /* padding :10px; */
		    margin: auto;
		}         
		
		/* 기본버튼 숨기기 */
		#uploadfile{
		position: absolute;
		width: 1px;
		height: 1px;
		padding: 0;
		margin: -1px;
		overflow: hidden;
		clip:rect(0,0,0,0);
		border: 0;
		}
		
		.filebox label {
		  display: inline-block;
		  padding: .5em .75em;
		  color: #999;
		  font-size: inherit;
		  line-height: normal;
		  vertical-align: middle;
		  background-color: #fdfdfd;
		  cursor: pointer;
		  border: 1px solid #ebebeb;
		  border-bottom-color: #e2e2e2;
		  border-radius: .25em;
		}
		
		.filebox input[type="file"] {  /* 파일 필드 숨기기 */
		  position: absolute;
		  width: 1px;
		  height: 1px;
		  padding: 0;
		  margin: -1px;
		  overflow: hidden;
		  clip:rect(0,0,0,0);
		  border: 0;
		}
		
		/* ------------------------------------------------------------------ */
	.btn{
		margin: 5px 3px 5px 3px;
		height: 30px;
		width: 48%;
		background-color: rgba(255,255,255,0.5);
		border-color: rgba(255,255,255,0);
		border-radius: 5px;
		text-align: center;
		vertical-align: middle;
		cursor: pointer;
		font-size: 14pt;
		color: rgba(204, 0, 82, 0.8);
		font-family: Verdana,sans-serif;
		float: left;
		box-shadow: 2px 2px 10px purple;
		}
	.btn:hover {
		background-color: rgba(255, 255, 255, 0.7);
		text-decoration: none;
		box-shadow: 2px 2px 2px silver;
	}
	.btn:active {
		background: rgba(135, 80, 25, 0.3); /* 지금은 브라운임! */
		text-decoration: none;
	} 
      </style>
   </head>
   
   <body>
      <div id="pagewrapper">
      
         <div id="albumit">
            <img src="${pageContext.request.contextPath}/resources/image/logo.png"  alt="Albumit" title="Albumit" id="logo"/>
         </div>
         
         <div>      
            <h2 class="signup">Sign Up  : </h2><br/>
            <h2 class="signup">Create your Albumit Account!</h2>
         </div>
         
         <form:form  commandName ="member" enctype="multipart/form-data" >
            <!-- 입력란 -->
            <div id="textbox">
               <!-- E-mail -->
               <div id="email">
                  <form:input path="member_email" placeholder="Email address"  id="emailform"/>
                  <form:errors path="member_email"/>
               </div>
               
               <!-- Password -->
               <div id="password">
                  <form:input path="member_password" placeholder="Password"  id="passwordform"/>
                  <form:errors path="member_password"/>
               </div>
                     
               <!-- NickName -->
               <div id="nickname">
                  <form:input path="member_nickname" placeholder="Nickname" id="nicknameform"/>
                  <form:errors path="member_nickname"/>
               </div>
                  
               <!-- Status message -->
               <div id="Smessage">
                  <form:input path="member_profile" placeholder="Status message"  id="Smessageform"/>
                  <form:errors path="member_profile"/>
               </div>
            
            <!-- 
            	<div id="fileUpload">
            		
            		파일 등록 : <input type="file" name="attach" />
            	</div> -->
            </div>
   <!--  --------------------------------------------------------------------------------- -->
            
<!--             <div class="filebox preview-image">
			  <input class="upload-name" value="파일선택" disabled="disabled" >
				Upload your Photo<br/>
			  <input type="file" id="input-file" class="upload-hidden"> 
			</div>
 -->

			<!-- 지인언니 여기서 자꾸 오류가 나내요;;; 주석처리 해놨어요
			
			<h3 id="uploadtitle">Upload your Photo!!</h3>
			<br/>
			<input type="text" name="attach" id="fileName" class="file_input_textbox" readonly="readonly">
			 
			<div class="file_input_div">
			  <input type="button" value="Search files" class="file_input_button" />
			  <input type="file"  class="file_input_hidden" onchange="javascript: document.getElementById('fileName').value = this.value" />
			</div> -->
			
            <div class="filebox">
               Upload your Photo<br/>
               <lable for="ex_file">업로드</lable>
               <input type="file" name="attach" id="uploadfile"/>
            </div>      
   <!--  --------------------------------------------------------------------------------- -->         
			<div>
             	<input type="reset"  value= "Reet"  id="reset" class="btn"/>
               <input type="submit" value="Join" id="join" class="btn"/>
            </div>
         </form:form>
      </div>
   </body>
</html>