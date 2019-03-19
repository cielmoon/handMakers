<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath }" />

<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
<%-- <jsp:param value="" name="pageTitle"/> --%>
<section>
	<div class="container">
		<ul class="breadcrumb">
			<li><a href="${path }"><i class="fa fa-home"></i></a></li>
			<li><a href="${path}/admin/adminPage.do">관리자페이지</a></li>
			<li><a href="${path}/admin/manageBrand.do">브랜드 등록관리</a></li>
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
								<th>사업자 등록번호</th>
								<th>브랜드명</th>								
								<th>브랜드 카테고리</th>
								<th>승인상태</th>
								<th>등록날짜</th>
								<th>요청관리</th>								
							</tr>
 							<c:forEach var="b" items="${brandList }"> 								
								<tr>
									<td>${b.brandLicense }</td>
									<td>${b.brandTitle }</td>
									<td>${b.brandType }</td>																
									<c:choose>
										<c:when test="${b.brandState.toString() == 'b' }">
											<td>승인</td>		
										</c:when>
										<c:when test="${b.brandState.toString() == 'c' }">
											<td>반려</td>											
										</c:when>
										<c:when test="${b.brandState.toString() == 'd' }">
											<td>폐점요청</td>											
										</c:when>
										<c:when test="${b.brandState.toString() == 'e' }">
											<td>폐점완료</td>											
										</c:when>
										<c:when test="${b.brandState.toString() == 'f' }">
											<td>폐점반려</td>											
										</c:when>
										<c:otherwise>
											<td>승인요청</td>		
										</c:otherwise>						
									</c:choose>			
															
									<td>${b.brandEnrollDate}</td>
									<c:choose>
										<c:when test="${b.brandState.toString() == 'b' }">
											<td><a href="${path}/admin/changeBrandState.do?brandNo=${b.brandNo}+,0"><button class="AgreeBtn">승인취소</button></a></td>					
										</c:when>
										<c:when test="${b.brandState.toString() == 'c' }">
											<td><a href="${path}/admin/changeBrandState.do?brandNo=${b.brandNo}+,0"><button class="AgreeBtn">반려취소</button></a></td>											
										</c:when>
										<c:when test="${b.brandState.toString() == 'a' }">
											<td><a href="${path}/admin/changeBrandState.do?brandNo=${b.brandNo}+,4"><button class="AgreeBtn">승인</button></a>
											<a href="${path}/admin/changeBrandState.do?brandNo=${b.brandNo}+,0"><button class="AgreeBtn">반려</button></a></td>											
										</c:when>									
										<c:otherwise>
											<td></td>	
										</c:otherwise>								
									</c:choose>
								</tr>
							</c:forEach>
						</table>
						${pageBar }
					</div>
<%-- 					<div class="col-sm-12">
						<div class="col-sm-9"></div>
						<div class="col-sm-3">
							<input type="button" class="btn btn-primary"
								onclick='location.href="${path}/admin/enrollProduct.do"'
								value="상품등록" />
						</div>
					</div> --%>
				</div>
			</div>
			
			
		</div>
	</div>
</section>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>