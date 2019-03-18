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
	//전체 체크박스 선택해제 숨기기
	$("#uncheck-all-order").css("display", "none");	
	
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
		
		if(productState == '1')
		{
			document.getElementById("d-day").innerHTML = "";
		}
		else
		{
			document.getElementById("d-day").innerHTML = d +"일 " + h + "시간  남았습니다.";
		}
	});
});
function checkAllOrder(state)
{
	if(state == 0)
	{
		$("input[type=checkbox]").prop("checked",false);
		$("#uncheck-all-order").css("display", "none");	
		$("#check-all-order").css("display", "inline");	
	}
	else
	{		
		$("input[type=checkbox]").prop("checked",true);
		$("#uncheck-all-order").css("display", "inline");	
		$("#check-all-order").css("display", "none");	
	}
}
function exportOrders()
{
	var orders = new Array();
	$("input[type=checkbox]:checked").each(function(){
		orders.push($(this).val());
	});

	if(orders.length == 0)
	{
		alert("처리할 주문을 선택해주세요.");
	}
	else
	{
		var result = confirm("상품을 출고하셨나요?");
		if(result)
		{
			location.href="${path}/shop/exportOrders.do?orders=" + orders + "&productNo=" + '${product.PRODUCT_NO}' + "&brandNo=" + '${brand.brandNo}';
		}
 	}
}

function cancelExport()
{
	var orderNo = $("#input-orderNo").val();
	var result = confirm("출고처리를 취소할까요?");
	if(result)
	{
		location.href="${path}/shop/cancelExportOrder.do?orderNo=" + orderNo + "&productNo=" + '${product.PRODUCT_NO}' + "&brandNo=" + '${brand.brandNo}';
	}
}

function orderView(orderNo)
{
	$("#button-cancel-export").css("display", "none");
	$.ajax({
		url:"${path}/shop/orderView.do",
		data:{"orderNo" : orderNo},
		success:function(data){
			var date = data.order.ORDER_DATE;
			var dateText = (date.year + 1900)  + "년" + (date.month + 1) + "월" + (date.date) + "일 " + date.hours + "시 " + date.minutes + "분";
			$("#input-orderDate").text(dateText);
			$("#input-orderPostCode").text(data.order.DELIVERY_POSTCODE);
			$("#input-orderAddr").text(data.order.DELIVERY_ADDR);
			$("#input-orderDetailAddr").text(data.order.DELIVERY_DETAILADDR);
			$("#input-orderOption").text(data.order.PRODUCT_OPTION);
			$("#input-orderQty").text(data.order.PRODUCT_OPTION_QTY + "개");
			$("#input-orderPrice").text(data.order.ORDER_TOTAL_PRICE + "원");
			if(data.order.ORDER_STATE == '1')
			{
				$("#button-cancel-export").css("display", "inline");
			}
			
			$("#input-orderNo").val(data.order.ORDER_NO);
			$("#orderViewModal").modal();
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
								<c:if test="${product.PRODUCT_STATE == '1' && product.PRODUCT_CURSELL >= product.PRODUCT_MIN}">
									<th>
										<a id="check-all-order" href="javascript:void(0);" onclick="checkAllOrder(1);"><i class="fa fa-check" style="color: gray;"></i></a>
										<a id="uncheck-all-order" href="javascript:void(0);" onclick="checkAllOrder(0);"><i class="fa fa-check" style="color: lightgray;"></i></a>	
									</th>
								</c:if>
								<th>번호</th>
								<th>주문자</th>
								<th>옵션</th>								
								<th>수량</th>
								<th>주문일</th>
								<th>상태</th>					
							</tr>
							<c:if test="${orderList.size()==0 }">
								<tr>
									<td colspan="7" style="text-align: center;">상품 주문이 없습니다.</td>
								</tr>
							</c:if>
 							<c:forEach var="o" items="${orderList }" varStatus="vs">
								<tr>
									<c:if test="${product.PRODUCT_STATE == '1' && product.PRODUCT_CURSELL >= product.PRODUCT_MIN}">
										<td><input type="checkbox" name="checkOrders" id="check-order" value="${o.ORDER_NO }"/></td>
									</c:if>
									<td>${vs.count }</td>
									<td>${fn:replace(o.MEMBER_ID, fn:substring(o.MEMBER_ID, o.MEMBER_ID.length()-3, o.MEMBER_ID.length()), '***')}</td>
									<td>${o.PRODUCT_OPTION }</td>
									<td>${o.PRODUCT_OPTION_QTY }개</td>
									<td><fmt:formatDate value="${o.ORDER_DATE}" pattern="yyyy-MM-dd HH:mm"/></td>
									<td><a href="javascript:void(0);" onclick="orderView('${o.ORDER_NO}');">
										<c:if test="${o.ORDER_STATE == '0'}">배송준비중</c:if>
										<c:if test="${o.ORDER_STATE == '1'}">출고완료</c:if>
										<c:if test="${o.ORDER_STATE == '2'}">구매확정</c:if>	
										</a>
									</td>
								</tr>
							</c:forEach>
						</table>
					</div>
					<div class="col-sm-2 float-right">
						<button class="btn btn-primary" onclick="exportOrders();">출고처리</button>
					</div>
					<div class="col-sm-12 text-center">
						${pageBar }
					</div>
				</div>
			</div>
			
			<!-- 주문 확인 Modal -->
			<div class="modal fade" tabindex="-1" role="dialog" id="orderViewModal">
			  <div class="modal-dialog">
			    <div class="modal-content">
			      <div class="modal-header">
			        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
			        	<span aria-hidden="true">×</span>
			        </button>
			        <h4 class="modal-title" id="modalTitle">주문 상세정보</h4>
			      </div>
			      <div class="modal-body" style="overflow: auto; height: 250px;">
					<div class="row">
						<div class="col-sm-12">
							<label class="control-label">주문일</label> 
							<span class="form-control" id="input-orderDate"></span>
						</div>
						
						<div class="col-sm-12 mt-10">배송지</div>
						<div class="col-sm-4">
							<span class="form-control" id="input-orderPostCode"></span>
						</div>
						<div class="col-sm-8">
							<span class="form-control" id="input-orderAddr"></span>
						</div>
						<div class="col-sm-12 mt-10">
							<span class="form-control" id="input-orderDetailAddr"></span>
						</div>
						
						
						<div class="col-sm-12 mt-10">
							<label class="control-label">선택옵션</label> 
							<span class="form-control" id="input-orderOption"></span>
						</div>
						<div class="col-sm-6 mt-10">
							<label class="control-label">수량</label> 
							<span class="form-control" id="input-orderQty"></span>
						</div>
						<div class="col-sm-6 mt-10">
							<label class="control-label">합계금액</label> 
							<span class="form-control" id="input-orderPrice"></span>
						</div>
					</div>
				  </div>
				  
			      <div class="modal-footer">
			      	<input type="hidden" id="input-orderNo"/>
			      	<button type="button" class="btn btn-primary" onclick="cancelExport();" id="button-cancel-export">출고취소</button>      
			      	<button type="button" class="btn btn-primary float-right" data-dismiss="modal" aria-label="Close">확인</button>      
			      </div>
			    </div>
			  </div>
			</div>
			
		</div>
	</div>
</section>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>