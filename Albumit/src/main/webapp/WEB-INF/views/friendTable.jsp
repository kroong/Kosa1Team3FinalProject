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

$(function() {
	
	var row;
	 /* 차단된 친구   */
	  $( ".slider-range-min" ).slider({
	      range: "max",
	      min: 1,
	      max: 2,
	      value: 1,
	      slide: function( event, ui ) {
	    	  row= $(this).parents("tr").index();
	    	  console.log("row1:::::"+row);
	    	  var email = document.getElementById("myTable").rows[row].cells.namedItem("email").innerHTML;
	    	  console.log("email:"+email);
	    		  var contextpath = $("#contextpath").val();
	    	  
	    	  if(ui.value ==1){
	    	
		    	  var blocked = document.getElementById("myTable").rows[row].cells.namedItem("blocked").innerHTML;
				console.log("blocked:"+blocked);
		    	  
		    	  if(blocked.indexOf("차단된친구") > -1){
			    		 $( "input[name=amount2]" ).eq(row-1).val("차단");
			    		console.log("차단된친구에서 차단시도!!");
			    		
			    		 $.ajax({
			    				type: "post",
			    				url: contextpath+"/blockFriend",
			    				data: {"blockFriend" : email }
			    			
			    			});
			    		
					}
					
					else{
					 $( "input[name=amount2]" ).eq(row-1).val("차단해제");
					 
				  $.ajax({
	    				type: "post",
	    				url: contextpath+"/UnBlockFriend",
	    				data: {"UnBlockFriend" : email }
	    			
	    			});
				 
	    	  }	
	    	  }
	    	  else {
	    		  
	    		  var blocked = document.getElementById("myTable").rows[row].cells.namedItem("blocked").innerHTML;
					console.log("blocked:"+blocked);

	    		  if(blocked.indexOf("차단된친구") > -1){
			    		 $( "input[name=amount2]" ).eq(row-1).val("차단해제");
			    			console.log("차단된친구에서 차단해 시도!!");
						
			    			 $.ajax({
				    				type: "post",
				    				url: contextpath+"/UnBlockFriend",
				    				data: {"UnBlockFriend" : email }
				    			
				    			});	
					}
					else {
	    		  $( "input[name=amount2]" ).eq(row-1).val("차단");
	    		  
				 console.log("차단!");
					
				 $.ajax({
	    				type: "post",
	    				url: contextpath+"/blockFriend",
	    				data: {"blockFriend" : email }
	    			
	    			});
				 
					}
	    		
	    	  }	     
			}
	    }); 
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
			<td>
			<p>
  				<input type="text" id="a" name="amount2" readonly style="border:0; color:#f6931f; font-weight:bold;">
			</p>
			<div class="slider-range-min"></div></td>
			
		<c:if test="${f.friend_block == false }">
		<td id="blocked">
			차단된친구
		</td></c:if> 
		
		<c:if test="${f.friend_block == true }">
		<td id="blocked">
			안차단친구
		</td></c:if> 
	
		</tr>
       
	</c:forEach>
</table>
<div id="frtable3">

</div>

<input type="hidden" id="contextpath" value="${pageContext.request.contextPath}"/>