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
			<li><a href="${path}/admin/adminPage.do">관리자페이지</a></li>
			<li><a href="${path}/admin/manageProduct.do">상품 관리</a></li>
		</ul>
		<br />
		<div class="row">
			<div class="col-sm-3 hidden-xs column-left" id="column-left">
				<div class="column-block">
					<div class="columnblock-title">관리자페이지</div>
					<div class="account-block">
						<div class="list-group">
							<a class="list-group-item" href="${path}/admin/adminPage.do">홈</a>					
							<a class="list-group-item" href="${path}/admin/memberList.do">회원목록</a>
							<a class="list-group-item"	href="${path}/admin/manageBrand.do">브랜드 등록관리</a>							
							<a class="list-group-item" href="${path}/admin/managePreProduct.do">입점 제안관리</a>
							<a class="list-group-item" href="${path}/admin/manageProduct.do">상품 관리</a>												 
							<a class="list-group-item" href="${path}/admin/manageReProduct.do">상품 재등록 관리</a>
							<a class="list-group-item"	href="${path}/admin/manageRequest.do">폐점신고 및 상품 판매중지 요청</a>					 
						</div>
					</div>
				</div>
			</div>
			<!-- 정보 변경 전에 다시 비밀번호 확인 -->
			<div class="col-sm-9" id="content">
				<div class="row">
					<div class="col-sm-12">					
						<table id='tbl-board' class='table table-striped table-hover'>
							<tr>
								<th>카테고리(대)</th>
								<th>카테고리(소)</th>								
								<th>상품명</th>
								<th>브랜드명</th>
								<th>상품상태</th>
								<th>등록날짜</th>
								<th>마감날짜</th>	
								<th></th>								
							</tr>
 							<c:forEach var="a" items="${adminProductList }">
 								<tr>
									<td>${a.productBcTitle }</td>
									<td>${a.productScTitle }</td>
									<td>${a.productTitle }</td>	
									<td>${a.productBrandTitle }</td>
									<c:choose>
										<c:when test="${a.productState == '1' }">
											<td>판매중지요청</td>
										</c:when>
										<c:when test="${a.productState == '2' }">
											<td>판매중지</td>
										</c:when>
										<c:when test="${a.productState == '3' }">
											<td>판매완료</td>
										</c:when>
										<c:when test="${a.productState == '4' }">
											<td>판매 재등록요청</td>
										</c:when>
									</c:choose>		
									<td>${a.productEnrollDate }</td>	
									<td>${a.productEndDate }</td>
									<td></td>
							
															
											
								</tr>
							</c:forEach>
						</table>
						${pageBar }
					</div>
 					<div class="col-sm-12">
						<div class="col-sm-9"></div>
						<div class="col-sm-3">
							<input type="button" class="btn btn-primary"
								onclick='location.href="${path}/admin/enrollProduct.do"'
								value="상품등록" />
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</section>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>