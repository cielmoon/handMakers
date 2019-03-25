<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	import="kh.hand.makers.member.model.vo.*, java.util.*"%>
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
<script type='text/javascript' src='//code.jquery.com/jquery-1.8.3.js'></script>

<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.2/css/all.css" integrity="sha384-fnmOCqbTlWIlj8LyTjo7mOUStjsKC4pOpQbqyi7RrhN7udi9RwhKkMHpvLbHG9Sr" crossorigin="anonymous">
<meta name="description" content="e-commerce site well design with responsive view." />
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
<%-- <script src="${path }/resources/javascript/template.js"
	type="text/javascript"></script> --%>
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
											<c:when test="${member.memberAuthority == 'A' }">
												<ul class="dropdown-menu dropdown-menu-right">
													<li><a href="#" onclick="location.href='${path}/admin/adminPage.do'">관리자페이지</a></li>
													<li><a href="#" onclick="location.href='${path}/member/memberLogout.do'">로그아웃</a></li>
													</ul>
											</c:when>
										
											
											<c:when test="${member.memberAuthority == null }">
											<ul class="dropdown-menu dropdown-menu-right">
													<li><a href="#" onclick="location.href='${path}/member/memberLogin.do'">로그인</a></li>
													<li><a href="#" onclick="location.href='${path}/member/memberEnroll.do'">회원가입</a></li>
												</ul>
											</c:when>
											
											<c:otherwise>
												<ul class="dropdown-menu dropdown-menu-right">
													<li><a href="#"	onclick="location.href='${path}/member/myPage.do'">마이페이지</a></li>
													<li><a href="#" onclick="location.href='${path}/member/memberLogout.do'">로그아웃</a></li>
												</ul>
											</c:otherwise>
										</c:choose>
										
									</c:when>
									<c:otherwise>
												<ul class="dropdown-menu dropdown-menu-right">
													<li><a href="#" onclick="location.href='${path}/member/memberLogin.do'">로그인</a></li>
													<li><a href="#" onclick="location.href='${path}/member/memberEnroll.do'">회원가입</a></li>
												</ul>
									</c:otherwise>
									</c:choose></li>
									
									<c:if test="${member!=null }">
										<li><a href="#"	onclick="location.href='${path}/member/wishList.do'" id="wishlist-total" title="Wish List"><i class="fa fa-heart"></i><span>Wish List</span></a></li>
									</c:if>
									<c:if test="${member ==null }">
										<li><a href="#"	onclick="location.href='${path}/member/wishList.do'" id="wishlist-total" title="Wish List"><i class="fa fa-heart"></i><span>Wish List</span></a></li>
									</c:if>
								</ul>
				
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="container">
			<div class="header-inner">
				<div class="col-sm-4 col-xs-12 header-middle">
					<div class="header-middle-top">
						<div id="logo">
							<a href="${pageContext.request.contextPath }"><img
								src="${path }/resources/image/logo.png" title="handmakers"
								alt="handmakers" class="img-responsive" /></a>
						</div>
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
							<li> <a href="javascript:;" class="active parent">카테고리</a>
								<%-- <ul>
									<li><a href="${path }/product/category.do?category=B_C_NO_1">IT/가전(B_C_NO_1)</a></li>
									<li><a href="${path }/product/category.do?category=B_C_NO_2">푸드IT/가전(B_C_NO_2)</a></li>
									<li><a href="${path }/product/category.do">악세서리</a></li>
									<li><a href="${path }/product/productTest.do">상세테스트-가방/지갑</a></li>
								</ul> --%>
								<ul>
								<div id = "menuList"></div>
								</ul>
								</li>
							<li><a href="${path }/product/newList.do" class="parent">신규</a></li>
							<li><a href="${path }/product/bestList.do" class="parent">베스트</a></li>
							<li><a href="${path }/product/preList.do" class="parent">입점예정</a></li>
							<li><a href="#" class="active parent">문의하기</a>
								<ul>
									<li><a href="${path }/admin/questionAndAnswer.do">Q &amp; A</a></li>
									<c:if test="${member.memberAuthority != 'A' }">
										<li><a href="${path }/shop/shopEnroll.do">입점문의</a></li>
									</c:if>
								</ul></li>
						</ul>
						<table id="level1" style="border : 1px solid tomato">
						
						</table>
					</div>
				</div>
			</nav>
		</div>
	</header>
	
	<script type="text/javascript">
	$(function(){
		$.ajax({
			url:"${path}/common/menuList.do",
			success: function(data){
				for(var i = 0 ; i < data.length ; i++){
					$('#menuList').append('<li><a href="${path }/product/category.do?category='+data[i].BC_NO+'">'+data[i].BC_TITLE+'</a></li>');
				}
			}
		});
	});
	</script>