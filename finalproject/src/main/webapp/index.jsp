<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>

<section>
	<div class="container">
		<div class="mainbanner"><!-- 메인배너엔 뭘넣어야할까? -->
			<div id="main-banner" class="owl-carousel home-slider">
				<div class="item">
						<a href="${path }"><img src="${path }/resources/image/banners/banner_1.jpg"
						alt="main-banner1" class="img-responsive" /></a>
				</div>
				<div class="item">
					<a href="${path }/product/preList.do"><img src="${path }/resources/image/banners/banner_2.jpg"
						alt="main-banner2" class="img-responsive" /></a>
				</div>
				<div class="item">
					<a href="${path }/product/bestList.do"><img src="${path }/resources/image/banners/banner_3.jpg"
						alt="main-banner3" class="img-responsive" /></a>
				</div>
				<div class="item">
					<a href="${path }/product/newList.do"><img src="${path }/resources/image/banners/banner_4.jpg"
						alt="main-banner4" class="img-responsive" /></a>
				</div>
			</div>
		
		</div>
	</div>
	<div class="container">
		
	</div>
</section>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>	