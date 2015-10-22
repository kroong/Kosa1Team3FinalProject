<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="en" class="no-js">

<head>
	<meta charset="UTF-8" />
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/normalize.css" />
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/font/font-awesome-4.3.0/css/font-awesome.min.css" />
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/demo.css" />
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/style2.css" />
	<script src="${pageContext.request.contextPath}/resources/js/modernizr-custom.js"></script>
	<style type="text/css">
	body{
		color:white;
	}
	
	.add_left{
		font-size:20px;
		list-style: none;
		display: inline-block;
		float: left;
	}
	.add_right{
		font-size:20px;
		list-style: none;
		display: inline-block;
		float: right;
		margin: 1px 15px;
	}
	</style>


</head>
		
<body class="demo-2">
	<select id="photoArray" size="1" onchange="arrayfun(this)">
		<option value="latest" selected="selected" >최신순</option>
		<option value="popularity">인기순</option>
	</select>

	<div id="latest">
	<h4>최신순</h4>
	<hr/>
	
	<div class="content">
		<div class="grid">
			<c:forEach  var="photo" items="${laList}">
			<div class="grid__item" data-size="100x100">
					<a href="${pageContext.request.contextPath}/resources/uploadfiles/${photo.photo_filesystem_name}" class="img-wrap"><img src="${pageContext.request.contextPath}/resources/uploadfiles/${photo.photo_filesystem_name}"/>
					<ul>
						<li class="add_left"><a href="#"><i class="fa fa-heart-o"></i></a></li>
						<li class="add_right"><a href="#"><i class="fa fa-share-square-o"></i></a></li>
						<li class="add_right"><a href="#"><i class="fa fa-ellipsis-v"></i></a></li>
					</ul>
					<div class="description description--grid">
							<h3>${photo.photo_title }</h3>
							<p>${photo.photo_content}<em>&mdash; ${photo.uid }</em></p>
							<div class="details">
								<ul>
									<li><span><fmt:formatDate value="${photo.photo_date}" pattern="yyyy-MM-dd"/></span></li>
									<li><span><a href="#"><i class="fa fa-heart-o"></i>좋아요${photo.photo_like}</a></span></li>
									<li><span>조회수${photo.photo_hitcount}</span></li>
									<li><span>1/1000</span></li>
									<li></i><span>80</span></li>
								</ul>
							</div>
						</div>
					</a>
				</div>
			</c:forEach>
		</div>
		<!-- /grid -->
		<div class="preview">
			<button class="action action--close"><i class="fa fa-times"></i><span class="text-hidden">Close</span></button>
			<div class="description description--preview"></div>
		</div>
		<!-- /preview -->
	</div>
	<!-- /container -->
	<script src="${pageContext.request.contextPath}/resources/js/imagesloaded.pkgd.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/masonry.pkgd.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/classie.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/main.js"></script>
	<script>
		(function() {
			var support = { transitions: Modernizr.csstransitions },
				// transition end event name
				transEndEventNames = { 'WebkitTransition': 'webkitTransitionEnd', 'MozTransition': 'transitionend', 'OTransition': 'oTransitionEnd', 'msTransition': 'MSTransitionEnd', 'transition': 'transitionend' },
				transEndEventName = transEndEventNames[ Modernizr.prefixed( 'transition' ) ],
				onEndTransition = function( el, callback ) {
					var onEndCallbackFn = function( ev ) {
						if( support.transitions ) {
							if( ev.target != this ) return;
							this.removeEventListener( transEndEventName, onEndCallbackFn );
						}
						if( callback && typeof callback === 'function' ) { callback.call(this); }
					};
					if( support.transitions ) {
						el.addEventListener( transEndEventName, onEndCallbackFn );
					}
					else {
						onEndCallbackFn();
					}
				};

			new GridFx(document.querySelector('.grid'), {
				imgPosition : {
					x : -0.5,
					y : 1
				},
				onOpenItem : function(instance, item) {
					instance.items.forEach(function(el) {
						if(item != el) {
							var delay = Math.floor(Math.random() * 50);
							el.style.WebkitTransition = 'opacity .5s ' + delay + 'ms cubic-bezier(.7,0,.3,1), -webkit-transform .5s ' + delay + 'ms cubic-bezier(.7,0,.3,1)';
							el.style.transition = 'opacity .5s ' + delay + 'ms cubic-bezier(.7,0,.3,1), transform .5s ' + delay + 'ms cubic-bezier(.7,0,.3,1)';
							el.style.WebkitTransform = 'scale3d(0.1,0.1,1)';
							el.style.transform = 'scale3d(0.1,0.1,1)';
							el.style.opacity = 0;
						}
					});
				},
				onCloseItem : function(instance, item) {
					instance.items.forEach(function(el) {
						if(item != el) {
							el.style.WebkitTransition = 'opacity .4s, -webkit-transform .4s';
							el.style.transition = 'opacity .4s, transform .4s';
							el.style.WebkitTransform = 'scale3d(1,1,1)';
							el.style.transform = 'scale3d(1,1,1)';
							el.style.opacity = 1;

							onEndTransition(el, function() {
								el.style.transition = 'none';
								el.style.WebkitTransform = 'none';
							});
						}
					});
				}
			});
		})();
	</script>
	<!-- ------------------------------------------------------------------- -->
	<div id="popularity">
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