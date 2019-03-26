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
						<a href="#"><img src="${path }/resources/image/banners/ex1.jpg"
						alt="main-banner1" class="img-responsive" /></a>
				</div>
				<div class="item">
					<a href="#"><img src="${path }/resources/image/banners/ex2.jpg"
						alt="main-banner2" class="img-responsive" /></a>
				</div>
				<div class="item">
					<a href="#"><img src="${path }/resources/image/banners/ex3.jpg"
						alt="main-banner3" class="img-responsive" /></a>
				</div>
			</div>
		
		</div>
	</div>
	<div class="container">
		<p>가내수공업(家內手工業)은 가정에서 제품을 생산하는 공업이다. 가내공업(家內工業)이라고도 한다. 가내수공업은 서양에서 18세기에서 19세기에 많이 이루어졌다. 주로 농촌에 사는 사람이 부업으로 가내수공업을 하곤 했다. 주로 옷과 옷감, 짚신과 같은 신발, 보자기 같은 수공예품, 담배 등을 생산하였다. 오늘날 가정에서 제품을 만드는 것도 가내수공업이라고 한다. 아직도 바느질 같은 수공예품이 가내수공업으로 이루어진다.</p>
	</div>
</section>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>	