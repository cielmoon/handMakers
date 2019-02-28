<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	import = "kh.hand.makers.member.model.vo.*, java.util.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath }" />

<!DOCTYPE html>
<html>
<head>
<title>handmakers</title>
<meta http-equiv="content-type" content="text/html;charset=utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description"
	content="e-commerce site well design with responsive view." />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<link href="${path }/resources/bootstrap/css/bootstrap.min.css"
	rel="stylesheet" media="screen" />
<link href="${path }/resources/font-awesome/css/font-awesome.min.css"
	rel="stylesheet" type="text/css" />
<link
	href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700"
	rel="stylesheet">
<link href="${path }/resources/css/stylesheet.css" rel="stylesheet">
<link href="${path }/resources/css/responsive.css" rel="stylesheet">
<link href="${path }/resources/owl-carousel/owl.carousel.css"
	type="text/css" rel="stylesheet" media="screen" />
<link href="${path }/resources/owl-carousel/owl.transitions.css"
	type="text/css" rel="stylesheet" media="screen" />
<script src="${path }/resources/javascript/jquery-2.1.1.min.js"
	type="text/javascript"></script>
<script src="${path }/resources/bootstrap/js/bootstrap.min.js"
	type="text/javascript"></script>
<script src="${path }/resources/javascript/jstree.min.js"
	type="text/javascript"></script>
<script src="${path }/resources/javascript/template.js"
	type="text/javascript"></script>
<script src="${path }/resources/javascript/common.js"
	type="text/javascript"></script>
<script src="${path }/resources/javascript/global.js"
	type="text/javascript"></script>
<script src="${path }/resources/owl-carousel/owl.carousel.min.js"
	type="text/javascript"></script>
</head>
<body>
	<header>
		<div class="header-top">
			<div class="container">
				<div class="row">
					<div class="col-sm-12">
						<div class="top-left pull-left"></div>
						<div class="top-right pull-right">
							<div id="top-links" class="nav pull-right">
								<ul class="list-inline">

									<li class="dropdown account"><a href="#"
										title="My Account" class="  dropdown-toggle"
										data-toggle="dropdown"> <i class="fa fa-user"></i><span>MyAccount</span>
											<span class="caret"></span></a> 
										<c:choose>
											<c:when test="${member != null }">
												<c:choose>
												<c:when test="${member.memberAuthority == 'M' }">
												<ul class="dropdown-menu dropdown-menu-right">
													<li><a href="#" onclick="location.href='${path}/member/myPage.do'">마이페이지</a></li>
													<li><a href="#"
														onclick="location.href='${path}/member/memberLogout.do'">로그아웃</a></li>
												</ul>
												</c:when>
												<c:when test="${member.memberAuthority == 'S' }">
												<ul class="dropdown-menu dropdown-menu-right">								
													<li><a href="#" onclick="location.href='${path}/member/myPage.do'">마이페이지</a></li>
													<li><a href="#" onclick="location.href='${path}/member/myPage.do'">판매관리</a></li>
													<li><a href="#"
														onclick="location.href='${path}/member/memberLogout.do'">로그아웃</a></li>
												</ul>
												</c:when>
												<c:when test="${member.memberAuthority == 'A' }">
												<ul class="dropdown-menu dropdown-menu-right">
													<li><a href="#" onclick="location.href='${path}/member/myPage.do'">관리자페이지</a></li>	
													<li><a href="#"
														onclick="location.href='${path}/member/memberLogout.do'">로그아웃</a></li>
												</ul>
												</c:when>
												</c:choose>
											</c:when>
											<c:otherwise>					
												<ul class="dropdown-menu dropdown-menu-right">
													<li><a href="#"
														onclick="location.href='${path}/member/memberLogin.do'">로그인</a></li>
													<li><a href="#"
														onclick="location.href='${path}/member/memberEnroll.do'">회원가입</a></li>
												</ul>											
											</c:otherwise>
										</c:choose>
									</li>

								</ul>
								<div class="search-box">
									<input class="input-text" placeholder="Search By Products.."
										type="text">
									<button class="search-btn">
										<i class="fa fa-search"></i>
									</button>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="container">
			<div class="header-inner">
				<div class="col-sm-4 col-xs-6 header-left">
					<div class="shipping">
						<div class="shipping-img"></div>
						<div class="shipping-text">
							(+91) 000-1233<br> <span class="shipping-detail">24/7
								Online Support</span>
						</div>
					</div>
				</div>
				<div class="col-sm-4 col-xs-12 header-middle">
					<div class="header-middle-top">
						<div id="logo">
							<a href="${pageContext.request.contextPath }"><img
								src="${path }/resources/image/logo.png" title="handmakers"
								alt="handmakers" class="img-responsive" /></a>
						</div>
					</div>
				</div>
				<div class="col-sm-4 col-xs-12 header-right">
					<div id="cart" class="btn-group btn-block">
						<button type="button"
							class="btn btn-inverse btn-block btn-lg dropdown-toggle cart-dropdown-button" onclick="location.href='${path}/shop/shopCart.do'">
							<span id="cart-total"><span class="cart-title">Shopping
									Cart</span><br> 0 item(s) - $0.00</span>
						</button>
<%-- 						<ul class="dropdown-menu pull-right cart-dropdown-menu">
							<li>
								<table class="table table-striped">
									<tbody>
										<tr>
											<td class="text-center"><a href="#"><img
													class="img-thumbnail" title="장바구니"
													alt="장바구니"
													src="${path }/resources/image/product/7product50x59.jpg"></a></td>
											<td class="text-left"><a href="#">lorem ippsum dolor
													dummy</a></td>
											<td class="text-right">x 1</td>
											<td class="text-right">$254.00</td>
											<td class="text-center"><button
													class="btn btn-danger btn-xs" title="Remove" type="button">
													<i class="fa fa-times"></i>
												</button></td>
										</tr>
									</tbody>
								</table>
							</li>
							<li>
								<div>
									<table class="table table-bordered">
										<tbody>
											<tr>
												<td class="text-right"><strong>Sub-Total</strong></td>
												<td class="text-right">$210.00</td>
											</tr>
											<tr>
												<td class="text-right"><strong>Eco Tax (-2.00)</strong></td>
												<td class="text-right">$2.00</td>
											</tr>
											<tr>
												<td class="text-right"><strong>VAT (20%)</strong></td>
												<td class="text-right">$42.00</td>
											</tr>
											<tr>
												<td class="text-right"><strong>Total</strong></td>
												<td class="text-right">$254.00</td>
											</tr>
										</tbody>
									</table>
									<p class="text-right">
										<span class="btn-viewcart"><a href="cart.html"><strong><i
													class="fa fa-shopping-cart"></i> View Cart</strong></a></span> <span
											class="btn-checkout"><a href="checkout.html"><strong><i
													class="fa fa-share"></i> Checkout</strong></a></span>
									</p>
								</div>
							</li>
						</ul> --%>
					</div>
				</div>
			</div>
			<nav id="menu" class="navbar">
				<div class="nav-inner">
					<div class="navbar-header">
						<span id="category" class="visible-xs">Categories</span>
						<button type="button" class="btn btn-navbar navbar-toggle">
							<i class="fa fa-bars"></i>
						</button>
					</div>
					<div class="navbar-collapse">
						<ul class="main-navigation">
							<li><a href="#" class="active parent">카테고리</a>
								<ul>
									<li><a href="category.html">IT/가전</a></li>
									<li><a href="cart.html">푸드</a></li>
									<li><a href="checkout.html">악세서리</a></li>
									<li><a href="blog.html">가방/지갑</a></li>		
								</ul></li>
							<li><a href="index.html" class="parent">신규</a></li>
							<li><a href="category.html" class="parent">베스트</a></li>
							<li><a href="category.html" class="parent">입점예정</a></li>
							<li><a href="#" class="active parent">문의하기</a>
								<ul>
									<li><a href="category.html">Q & A</a></li>
									<li><a href="cart.html">입점문의</a></li>
								</ul></li>
						</ul>
					</div>
				</div>
			</nav>
		</div>
	</header>