<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="en" class="no-js">

<head>
	<meta charset="UTF-8" />
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/normalize.css" />
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/font/font-awesome-4.3.0/css/font-awesome.min.css" />
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/demo.css" />
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/style2.css" />
	<script src="${pageContext.request.contextPath}/resources/js/modernizr-custom.js"></script>
</head>

<body class="demo-2">
	<div class="content">
		<div class="grid">
			<%for(int i=1; i<20; i++) {%>
			<div class="grid__item" data-size="100x100">
				<a href="${pageContext.request.contextPath}/resources/uploadfiles/<%=i%>.jpg" class="img-wrap"><img src="${pageContext.request.contextPath}/resources/uploadfiles/<%=i%>.jpg"/>
					<div class="description description--grid">
						<h3>Mother's Love</h3>
						<p>Every time you drink a glass of milk or eat a piece of cheese, you harm a mother. Please go vegan. <em>&mdash; Gary L. Francione</em></p>
						<div class="details">
							<ul>
								<li><i class="icon icon-camera"></i><span>Canon PowerShot S95</span></li>
								<li><i class="icon icon-focal_length"></i><span>22.5mm</span></li>
								<li><i class="icon icon-aperture"></i><span>&fnof;/5.6</span></li>
								<li><i class="icon icon-exposure_time"></i><span>1/1000</span></li>
								<li><i class="icon icon-iso"></i><span>80</span></li>
							</ul>
						</div>
					</div>
				</a>
			</div>
			<%}%>
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
</body>

</html>
	