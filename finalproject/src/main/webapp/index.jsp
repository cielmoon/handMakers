<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
<section>
	<div class="container">
		<div class="mainbanner">
			<div id="main-banner" class="owl-carousel home-slider">
				<div class="item">
					<a href="#"><img src="${path }/resources/image/banners/Main-Banner1.jpg"
						alt="main-banner1" class="img-responsive" /></a>
				</div>
				<div class="item">
					<a href="#"><img src="${path }/resources/image/banners/Main-Banner2.jpg"
						alt="main-banner2" class="img-responsive" /></a>
				</div>
				<div class="item">
					<a href="#"><img src="${path }/resources/image/banners/Main-Banner3.jpg"
						alt="main-banner3" class="img-responsive" /></a>
				</div>
			</div>
		</div>
	</div>
	<div class="container">
		<h1>오호오호</h1>
	</div>
</section>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>