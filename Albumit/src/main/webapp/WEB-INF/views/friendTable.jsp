<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
 <link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
  <script src="//code.jquery.com/jquery-1.10.2.js"></script>
  <script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
<style>
.blockCheck{
	display:none;
}
#blockBtn{
	display:block;
}
#commitBlock{
	display:none;
}
.ui-slider .ui-slider-handle {
    width: 60% !important;
}

.ui-slider {
    width: 15% !important;
}

</style>

<script type="text/javascript">

function commitBlock(){
	alert("commitBlock !!! check~!!#!");
	
	
}

$(function() {
	
	 $( ".slider-range-max" ).slider({
	      range: "max",
	      min: 1,
	      max: 2,
	      value: 2,
	      slide: function( event, ui ) {
	    	  console.log("this->->"+this);
	    	  var row= $(this).parents("tr").index();
	    	  console.log("row1:::::"+row);
	    	  var email = document.getElementById("myTable").rows[row].cells.namedItem("email").innerHTML;
	    	  console.log("email:"+email);
	    	  
	    	  if(ui.value ==1){
	    		  $( "input[name=amount]" ).eq(row-1).val("차단");
	    		  alert("차단을 선택하셨습니다. ");
	    		  
	    		  var contextpath = $("#contextpath").val();
	    			alert("ajax에서 email::"+email);
	    			$.ajax({
	    				type: "post",
	    				url: contextpath+"/blockFriend",
	    				data: {"blockFriend" : email },
	    				dataType : "html",
	    				success : function(data){
	    					$("#frtable").html(data);
	    				}
	    			});
	    	  }
	    	  else if(ui.value == 2){
	    		  $( "input[name=amount]" ).eq(row-1).val("차단해제");
	    	  }
	      }
	    });
	 
	 
	 /* 차단된 친구   */
	  $( ".slider-range-min" ).slider({
	      range: "max",
	      min: 1,
	      max: 2,
	      value: 1,
	      slide: function( event, ui ) {
	    	  console.log("this->->"+this);
	    	  var row= $(this).parents("tr").index();
	    	  console.log("row1:::::"+row);
	    	  var email = document.getElementById("myTable").rows[row].cells.namedItem("email").innerHTML;
	    	  console.log("email:"+email);
	    	  
	    	  if(ui.value ==1){
	    		  $( "input[name=amount2]" ).eq(row-1).val("차단");
	    		  alert("차단을 선택하셨습니다. ");
	    		  
	    		  var contextpath = $("#contextpath").val();
	    			alert("ajax에서 email::"+email);
	    			$.ajax({
	    				type: "post",
	    				url: contextpath+"/blockFriend",
	    				data: {"blockFriend" : email },
	    				dataType : "html",
	    				success : function(data){
	    					$("#frtable").html(data);
	    				}
	    			});
	    	  }
	    	  else if(ui.value == 2){
	    		  $( "input[name=amount2]" ).eq(row-1).val("차단해제");
	    	  }
	      }
	    });
	 
	 
	  $( "input[name=amount]" ).val("차단해제");
	  $( "input[name=amount2]" ).val("차단");
  }); 
</script>
<div id="ftable"></div>
<table id="myTable">
	<tr>
	<td>email</td>
	<td>profile</td>
	<td>block</td>
	</tr>
	
	
	<c:forEach var="f" items="${flist}">
		<tr id="status">
			<td id="email">${f.member_email}</td>
			<td>${f.member_nickname}</td>
			
			<c:if test="${f.friend_block == 'false'}">
 			<td>
			<p>
  				<input type="text" name="amount2" readonly style="border:0; color:#f6931f; font-weight:bold;">
			</p>
			<div class="slider-range-min"></div></td>
			</c:if>
			<c:if test="${f.friend_block == 'true'}">
			<td>
			<p>
  				<input type="text" name="amount" readonly style="border:0; color:#f6931f; font-weight:bold;">
			</p>
			<div class="slider-range-max"></div></td>
			</c:if>
		</tr>
       
	</c:forEach>
</table>


<input type="hidden" id="contextpath" value="${pageContext.request.contextPath}"/>