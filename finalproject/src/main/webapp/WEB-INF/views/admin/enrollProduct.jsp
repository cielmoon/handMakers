<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath }" />
<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>

<section>
	<div class="container">
		<ul class="breadcrumb">
			<li><a href="${path }"><i class="fa fa-home"></i></a></li>
			<li><a href="#">관리자페이지</a></li>
			<li><a href="#">상품 관리</a></li>
			<li><a href="#">상품 등록</a></li>
		</ul>
		<br />
		<div class="row">
			<div class="col-sm-3 hidden-xs column-left" id="column-left">
				<div class="column-block">
					<div class="columnblock-title">관리자페이지</div>
					<div class="account-block">
						<div class="list-group">
							<a class="list-group-item" href="#">홈</a> <a
								class="list-group-item" href="#">공지사항 관리</a> <a
								class="list-group-item" href="#">메인배너 관리</a> <a
								class="list-group-item" href="#">회원 관리</a> <a
								class="list-group-item" href="#">입점문의 관리</a> <a
								class="list-group-item" href="${path}/admin/manageProduct.do">상품
								관리</a> <a class="list-group-item"
								href="${path}/member/adminBrandCloseManage.do">브랜드 관리</a> <a
								class="list-group-item" href="#">상품 판매 관리</a> <a
								class="list-group-item" href="#">상품 재등록 관리</a>
						</div>
					</div>
				</div>
			</div>
			<!-- 정보 변경 전에 다시 비밀번호 확인 -->
			<div class="col-sm-9" id="content">
				<div class="row">
					<div class="col-sm-1"></div>
					<div class="col-sm-10">
						<div class="well">
							<form name="memberEnrollFrm" action="${path}/admin/enrollProductEnd.do" method="post" onsubmit="return validate();" >
								<div class="form-group">
									<input type="text" class="form-control" id="productName"
										placeholder="상품명" name="productName">
								</div>

								<div class="form-group">
									<input type="text" class="form-control" id="productComment"
										placeholder="한줄 설명" name="productComment">
								</div>
								<div class="form-group">									
									<input type="text" class="form-control" id="productPrice"
										placeholder="상품 가격" name="productPrice">
								</div>
								<div class="form-group">									
									<input type="text" class="form-control" id="productSale"
										placeholder="상품 세일가격" name="productSale">
								</div>

								<input type="submit" class="btn btn-primary" value="등록하기">
							</form>
						</div>
					</div>
					<div class="col-sm-1"></div>
				</div>
			</div>
		</div>
	</div>
</section>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>