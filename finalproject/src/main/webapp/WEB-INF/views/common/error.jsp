<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isErrorPage="true"%>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
	<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
	<script src="${pageContext.request.contextPath }/resources/js/jquery-3.2.1.min.js"></script>
	<!-- 부트스트랩관련 라이브러리 -->
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css" integrity="sha384-9gVQ4dYFwwWSjIDZnLEWnxCjeSWFphJiwGPXr1jddIhOegiu1FwO5qRGvFXOdJZ4" crossorigin="anonymous">
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js" integrity="sha384-uefMccjFJAIv6A+rW+L4AHf99KvxDjWSu1z9VI8SKNVmz4sk7buKt/6v9KI65qnm" crossorigin="anonymous"></script>
	<!-- 사용자작성 css -->
	<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/style.css" />
<meta charset="UTF-8">
<title>handmakers</title>

<style>

/*======================
    404 page
=======================*/
.page_404 {
	padding: 40px 0;
	background: #fff;
}

.page_404  img {
	width: 100%;
}

.four_zero_four_bg {
	background-image:
		url(https://cdn.dribbble.com/users/285475/screenshots/2083086/dribbble_1.gif);
	height: 400px;
	background-position: center;
}

.four_zero_four_bg h1 {
	font-size: 80px;
}

.four_zero_four_bg h3 {
	font-size: 80px;
}

.link_404 {
	color: #fff !important;
	padding: 10px 20px;
	background: #39ac31;
	margin: 20px 0;
	display: inline-block;
}

.contant_box_404 {
	margin-top: -50px;
}
</style>

</head>
<body>
<section class="page_404">
		<div class="container">
			<div class="row">
				<div class="col-sm-12 ">
					<div class="col-sm-12 col-sm-offset-1  text-center">
						<div class="four_zero_four_bg"></div>

						<div class="contant_box_404">
							<h3 class="h2">Sorry :(</h3>

							<p>접속자가 많습니다. 잠시 후 재시도 해주세요.</p>

							<a href="${path }/makers" class="link_404">Go to Home</a>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
</body>
</html>





