<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath }" />
<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>

<style>
.min-height-400 {
	min-height: 400px;
}

.modal-dialog {
	z-index: 1050;
}

.modal-body {
	padding-top: 5px;
}

.float-left {
	float: left;
}

.float-right {
	float: right;
}

.mt-10 {
	margin-top: 10px;
}

.mt-0 {
	margin-top: 0px;
}
</style>

<section>
	<div class="container">
		<ul class="breadcrumb">
			<li><a href="${path }/index.jsp"><i
					class="fa fa-home"></i></a></li>
			<li><a href="${path }/member/myPage.do">마이페이지</a></li>
			<li><a href="${path }/shop/brandHome.do?brandNo=${brand.brandNo}">${brand.brandTitle}</a></li>
			<li><a href="${path }/shop/brandSaleProduct.do?brandNo=${brand.brandNo}">${product.PRODUCT_TITLE }</a></li>
		</ul>
		<br />
		<div class="row">
			<div class="col-sm-3 hidden-xs column-left" id="column-left">
				<div class="min-height-400">
					<div class="columnblock-title">${product.PRODUCT_TITLE }</div>
					<div class="account-block">
						<div class="list-group">
							<a class="list-group-item" href="#">주문목록</a>						
							<a class="list-group-item" href="#">Q&amp;A</a>
						</div>
					</div>
				</div>
			</div>
			
			<div class="col-sm-9" id="content">
				<div class="row">
					<div class="col-sm-12">			
						<label>주문 목록</label>
					</div>
					<div class="col-sm-12 mt-10">					
						<table id='tbl-board' class='table table-striped table-hover'>
							<tr>
								<th>번호</th>
								<th>옵션</th>								
								<th>수량</th>
								<th>주문일</th>
								<th>합계</th>
								<th>상태</th>					
							</tr>
 							<c:forEach var="o" items="${orderList }" varStatus="vs">
								<tr>
									<td>${vs.count }</td>
									<td>${o.PRODUCT_OPTION }</td>
									<td>${o.PRODUCT_OPTION_QTY }</td>
									<td><fmt:formatDate value="${o.ORDER_DATE}" pattern="yyyy-MM-dd HH:mm"/></td>
									<td>${o.PRODUCT_TOTAL_PRICE }원</td>	
									<td>배송준비중</td>
								</tr>
							</c:forEach>
						</table>
					</div>
					<div class="col-sm-12 text-center">
						${pageBar }
					</div>
				</div>
			</div>
			
		</div>
	</div>
</section>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>