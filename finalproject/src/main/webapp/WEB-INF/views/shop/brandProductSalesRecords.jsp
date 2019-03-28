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
	var productState = ${product.PRODUCT_STATE};
	var countDownDate = new Date('${product.PRODUCT_ENDDATE }').getTime(); 
	var x = setInterval(function() { 
		// 오늘 날짜 
		var now = new Date().getTime(); 
		// 종료일자에서 현재일자를 뺀 시간 
		var distance = countDownDate - now; 

		var d = Math.floor(distance / (1000 * 60 * 60 * 24)); 
		var h = Math.floor((distance % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
		
		if(productState == '0' || productState == '1')
		{
			document.getElementById("d-day").innerHTML = d +"일 " + h + "시간  남았습니다.";		
		}
		else
		{
			document.getElementById("d-day").innerHTML = "";
		}
	});
});
function recordView(recordNo)
{
	$.ajax({
		url:"${path}/shop/recordView.do",
		data:{"recordNo" : recordNo},
		success:function(data){
			var enrollDate = data.record.PRODUCT_ENROLLDATE;
			var endDate = data.record.PRODUCT_ENDDATE;
			var dateText = (enrollDate.year + 1900)  + "년" + (enrollDate.month + 1) + "월" + (enrollDate.date) + "일 ~ " + (endDate.year + 1900)  + "년" + (endDate.month + 1) + "월" + (endDate.date) + "일 ";
			$("#input-sellingDate").text(dateText);
			
			$("#input-productPrice").text(data.record.PRODUCT_PRICE + "원");
			$("#input-sellingQty").text(data.record.PRODUCT_CURSELL + "개");
			$("#input-sellingTotPrice").text(data.record.TOTAL_SELLING_PRICE + "원");
			$("#input-sellingProfit").text(data.record.SELLING_NET_PROFIT + "원");
			
			$("#recordsViewModal").modal();
		}
	});
}
</script>
<section>
	<div class="container">
		<ul class="breadcrumb">
			<li><a href="${path }/index.jsp"><i class="fa fa-home"></i></a></li>
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
							<a class="list-group-item" href="${path }/shop/brandProductSalesRecords.do?productNo=${product.PRODUCT_NO }&brandNo=${brand.brandNo}">판매이력</a>
							<a class="list-group-item" href="${path }/product/productView.do?productNo=${product.PRODUCT_NO }">상품페이지로 이동</a>								
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
						<label>판매이력</label>
					</div>
					<div class="col-sm-8"></div>
					
					
					<div class="col-sm-12 mt-10">					
						<table id='tbl-board' class='table table-striped table-hover'>
							<tr>
								<th>번호</th>
								<th>판매기간</th>
								<th width="60%;">구분</th>		
							</tr>
							<c:if test="${salesRecordsList.size()==0 }">
								<tr>
									<td colspan="6" style="text-align: center;">판매이력이 없습니다.</td>
								</tr>
							</c:if>
 							<c:forEach var="s" items="${salesRecordsList }" varStatus="vs">
								<tr>
									<td>${index + vs.index }</td>	
									<td><fmt:formatDate value="${s.PRODUCT_ENROLLDATE}" pattern="yyyy-MM-dd"/> - <fmt:formatDate value="${s.PRODUCT_ENDDATE}" pattern="yyyy-MM-dd"/></td>
									<td><a href="javascript:void(0);" onclick="recordView('${s.SALESRECORDS_NO}');">${vs.count } 회차 판매이력</a></td>
								</tr>
							</c:forEach>
						</table>
					</div>

					<div class="col-sm-12 text-center">
						${pageBar }
					</div>
				</div>
			</div>
			
			<!-- 판매이력 확인 Modal -->
			<div class="modal fade" tabindex="-1" role="dialog" id="recordsViewModal">
			  <div class="modal-dialog">
			    <div class="modal-content">
			      <div class="modal-header">
			        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
			        	<span aria-hidden="true">×</span>
			        </button>
			        <h4 class="modal-title" id="modalTitle">판매이력 상세정보</h4>
			      </div>
			      <div class="modal-body" style="overflow: auto;">
					<div class="row">
						<div class="col-sm-12">
							<label class="control-label">판매기간</label> 
							<span class="form-control" id="input-sellingDate"></span>
						</div>
						<div class="col-sm-6 mt-10">
							<label class="control-label">상품가격</label> 
							<span class="form-control" id="input-productPrice"></span>
						</div>
						<div class="col-sm-6 mt-10">
							<label class="control-label">판매량</label> 
							<span class="form-control" id="input-sellingQty"></span>
						</div>
						<div class="col-sm-6 mt-10">
							<label class="control-label">총 매출액</label> 
							<span class="form-control" id="input-sellingTotPrice"></span>
						</div>
						<div class="col-sm-6 mt-10">
							<label class="control-label">정산금액</label> 
							<span class="form-control" id="input-sellingProfit"></span>
						</div>	
					</div>
				  </div>			  
			      <div class="modal-footer">
			      	<button type="button" class="btn btn-primary float-right" data-dismiss="modal" aria-label="Close">확인</button>      
			      </div>
			    </div>
			  </div>
			</div>
			
		</div>
	</div>
</section>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>