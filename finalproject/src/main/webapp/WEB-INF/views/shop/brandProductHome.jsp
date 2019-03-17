<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath }" />
<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>

<style>
.bottom-0 {
	position: absolute;
	bottom: 0;
}

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
.text-right{
	text-align: right;
}
</style>
<script>
	$(function(){
		//디데이 종료 일자 설정 
		var countDownDate = new Date('${product.PRODUCT_ENDDATE }').getTime(); 

		var x = setInterval(function() { 
			// 오늘 날짜 
			var now = new Date().getTime(); 
			// 종료일자에서 현재일자를 뺀 시간 
			var distance = countDownDate - now; 
	
			var d = Math.floor(distance / (1000 * 60 * 60 * 24)); 
			var h = Math.floor((distance % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
			
			document.getElementById("d-day").innerHTML = d +"일 " + h + "시간  남았습니다.";
		});
	});

</script>
<section>
	<div class="container">
		<ul class="breadcrumb">
			<li><a href="${path }/index.jsp"><i
					class="fa fa-home"></i></a></li>
			<li><a href="${path }/member/myPage.do">마이페이지</a></li>
			<li><a href="${path }/shop/brandHome.do?brandNo=${brand.brandNo}">${brand.brandTitle}</a></li>
			<li><a href="${path }/shop/brandProductHome.do?productNo=${product.PRODUCT_NO }&brandNo=${brand.brandNo}">${product.PRODUCT_TITLE }</a></li>
		</ul>
		<br />
		<div class="row">
			<div class="col-sm-3 hidden-xs column-left" id="column-left">
				<div class="min-height-400">
					<div class="columnblock-title">${product.PRODUCT_TITLE }</div>
					<div class="account-block">
						<div class="list-group">
							<a class="list-group-item" href="${path }/shop/brandProductHome.do?productNo=${product.PRODUCT_NO }&brandNo=${brand.brandNo}">주문목록</a>						
							<a class="list-group-item" href="${path }/shop/brandProductQna.do?productNo=${product.PRODUCT_NO }&brandNo=${brand.brandNo}">문의관리</a>
						</div>
						<div id="list-group">
							<span id="d-day-title">판매종료&nbsp;<i class="fa fa-bell" style="font-size: 18px; color: gold;" aria-hidden="true"></i></span>
							<div id="d-day"></div>
						</div>
					</div>
				</div>
			</div>
			
			<div class="col-sm-9" id="content">
				<div class="row">
					<div class="col-sm-4">			
						<label>주문목록</label>
					</div>
					<div class="col-sm-3"></div>
					<div class="col-sm-5 float-right text-right">		
						<c:if test="${product.PRODUCT_CURSELL < product.PRODUCT_MIN}">
							<label>최소 주문수량 미달 <i class="fa fa-times" style="font-size:18px; color: firebrick;"></i></label>&nbsp;&nbsp;							
							<label>현재 ${product.PRODUCT_MIN - product.PRODUCT_CURSELL}개 남음</label>
						</c:if>
						<c:if test="${product.PRODUCT_CURSELL >= product.PRODUCT_MIN}">	
							<label>최소 주문수량 달성 <i class="fa fa-check" style="font-size:18px; color: lightgreen;"></i></label>&nbsp;&nbsp;	
							<label>현재 ${product.PRODUCT_CURSELL}개 주문중</label>
						</c:if>
					</div>
					<div class="col-sm-12 mt-10">					
						<table id='tbl-board' class='table table-striped table-hover'>
							<tr>
								<th>번호</th>
								<th>주문자</th>
								<th>옵션</th>								
								<th>수량</th>
								<th>주문일</th>
								<th>합계</th>
								<th>상태</th>					
							</tr>
							<c:if test="${orderList.size()==0 }">
								<tr>
									<td colspan="7" style="text-align: center;">상품 주문이 없습니다.</td>
								</tr>
							</c:if>
 							<c:forEach var="o" items="${orderList }" varStatus="vs">
								<tr>
									<td>${vs.count }</td>
									<td>${fn:replace(o.MEMBER_ID, fn:substring(o.MEMBER_ID, o.MEMBER_ID.length()-3, o.MEMBER_ID.length()), '***')}</td>
									<td>${o.PRODUCT_OPTION }</td>
									<td>${o.PRODUCT_OPTION_QTY }개</td>
									<td><fmt:formatDate value="${o.ORDER_DATE}" pattern="yyyy-MM-dd HH:mm"/></td>
									<td>${o.ORDER_TOTAL_PRICE }원</td>	
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