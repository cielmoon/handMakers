<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
	<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath}"/>

<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>

<!-- 다음 주소검색 API -->
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<!-- jQuery -->
<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
<!-- iamport.payment.js -->
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>

<script>
$(function(){
	$('#myAddr').change(function(){
		alert('들어오니?');
		var myAddr = $('#myAddr').find(":selected").val();
		console.log(myAddr);
		$.ajax({
			url:"${path}/delivery/selectDelivery.do",
			data:{"deliveryNo":myAddr},
			success:function(data){
				console.log(data.delivery);
				console.log(data.delivery["deliveryAddr"]);
				$('#input-postCode').val(data.delivery["deliveryPostCode"]);
				$('#input-addr').val(data.delivery["deliveryAddr"]);
				$('#input-detailAddr').val(data.delivery["deliveryDetailAddr"]);
			}
		});
	});
});



/* 사업장 주소 검색 버튼 클릭 시 실행 */
function searchAddr(){
	var width = 500; //팝업의 너비
	var height = 600; //팝업의 높이
	new daum.Postcode({
           oncomplete: function(data) {
    	    if(data.autoRoadAddress) {
                var expRoadAddr = data.autoRoadAddress;
            } else {
            	var expRoadAddr = data.roadAddress;
            }
    	   document.getElementById('input-postCode').value = data.zonecode; //우편번호
           document.getElementById("input-addr").value = expRoadAddr; //주소
           },
           shorthand : false //'시','도' 부분을 축약 표시
        	}).open({
  				popupName: 'postcodePopup',
				left: (window.screen.width / 2) - (width / 2),
			    top: (window.screen.height / 2) - (height / 2)
      		});
}

function requestPay() {
	
	var productNo = $('input[name=product_no]').val();
	var name = $('input[name=productName]').val();
	var productPrice = $('input[name=productPrice]').val();
	var productOptionSubject = $('input[name=productOptionSubject]').val();
	var productOptionQty = $('input[name=productOptionQty]').val();
	var buyer_name = '${member.memberName}';
	var buyer_tel = ${member.memberPhone};
	var buyer_addr = $('input[name=addr]').val().concat($('input[name=detailAddr]'));
	var buyer_postcode = $('input[name=postCode]').val();
	
	var amount = productPrice * productOptionQty;
	
	var IMP=window.IMP;
	IMP.init('imp16711907');
    // IMP.request_pay(param, callback) 호출
	IMP.request_pay({
	    pg : 'kakao',
	    pay_method : 'card',
	    merchant_uid : 'merchant_' + new Date().getTime(),//환불시 필요한 정보
	    name : name,
	    amount : amount, //상품 가격
	    /* buyer_email : '123@naver.com', */
	    buyer_name : buyer_name,
	    buyer_tel : buyer_tel,
	    buyer_addr : buyer_addr,
	    buyer_postcode : buyer_postcode,
	    m_redirect_url : 'https://www.myservice.com/payments/complete'
	}, function(rsp) {
		console.log(rsp);
	    if ( rsp.success ) {
    			var msg = '결제가 완료되었습니다.';
    			msg += '\n고유ID : ' + rsp.imp_uid;
    			msg += '\n상점 거래ID : ' + rsp.merchant_uid;
    			msg += '\결제 금액 : ' + rsp.paid_amount;
    			msg += '카드 승인번호 : ' + rsp.apply_num;
    			msg += '결제수단 : ' + rsp.pg_type; 
    			msg += '결제여부 : ' + rsp.status;
    			
    			$('#imp_uid').val(rsp.imp_uid);//결제 고유번호
    			$('#merchant_uid').val(rsp.merchant_uid);//주문번호
    			$('#order_total_price').val(rsp.paid_amount);//결재 가격
    			$('#order_payType').val(rsp.pg_provider);//결제 승인된 PG사
    			if(rsp.status=='paid'){
    				$('#order_payStatus').val('0');//주문상태
    			}
    			
    			
    			$('form[name=orderEnrollFrm]').submit();
    			
	    	}		
	   	else {
	        var msg = '결제에 실패하였습니다.';
	        msg += '에러내용 : ' + rsp.error_msg;
	        
	        alert(msg);
	        
	        return;
	    }
	});

}

/* $(function(){
	$('#myAddrOption').on('onclick',function(){
		alert('들어오니?');
		var myAddr = $('#myAddrOption').find(":selected").val();
		console.log(myAddr);
		$.ajax({
			url:"${path}/delivery/selectDelivery.do",
			data:{"deliveryNo":myAddr},
			success:function(data){
				console.log(data);
			}
		});
	});
}); */

</script>

<section>
<div class="container">
  <ul class="breadcrumb">
    <li><a href="index.html"><i class="fa fa-home"></i></a></li>
    <li><a href="cart.html">상세or찜목록</a></li>
    <li><a href="checkout.html">결제</a></li>
  </ul>
  <!-- nav -->
  <div class="row">
    <div id="column-left" class="col-sm-3 hidden-xs column-left">
      <div class="column-block">
        <div class="column-block">
          <div class="columnblock-title">대분류카테고리(BC_TITLE)</div>
          <div class="category_block">
            <ul class="box-category treeview-list treeview">
              <li><a href="#">소분류카테고리1(SC_TITLE)</a></li>
              <li><a href="#">소분류카테고리2(SC_TITLE)</a></li>
              <li><a href="#">소분류카테고리3(SC_TITLE)</a></li>
            </ul>
          </div>
        </div>
       </div>
       </div>
 		<div class="col-sm-9" id="content">
					<div class="panel panel-default">
						<div class="panel-heading">
							<h4 class="panel-title">
								<a>상품 주문하기</a>
							</h4>
						</div>
						<div class="panel-body">
							<form name="orderEnrollFrm" action="${path}/order/orderEnrollEnd.do" method="post">
								<div class="row">
									<div class="col-sm-6">
										<h2>상품 정보</h2>
										<div class="form-group">
											<label class="control-label">상품명</label>
											<input type="text" class="form-control" id="input-productName" name="productName"value="${orderList.productTitle }" readonly>
										</div>
										<div class="form-group">
											<label class="control-label">가격</label>
											<input type="number" class="form-control" id="input-productPrice" name="productPrice" value="${orderList.productPrice }" readonly/>
										</div>
										<div class="form-group">
											<label class="control-label">옵션</label>
											<input type="text" class="form-control" id="input-productOptionSubject" name="productOption" value="${orderList.productOption }" readonly>
										</div>
										<div class="form-group">
											<label class="control-label">수량</label>
											<input type="number" class="form-control" id="input-productOptionQty" name="productOptionQty" value="${orderList.productQty }" required>
										</div>
										
										<!-- 배송지 주소 -->
										<label class="control-label mt-1">배송지</label>
										<c:if test="${deliveryList!=null }">
										<div class="form-group">
											<select class="form-control" id="myAddr" name="myAddr">
											<c:forEach items="${deliveryList }" var="delivery">
												<option value="list" selected>나의 배송지 주소</option>
												<option id="myAddrOption" value="${delivery.DELIVERY_NO }">${delivery.DELIVERY_POSTCODE }${delivery.DELIVERY_ADDR }${delivery.DELIVERY_DETAILADDR }
											</c:forEach>
											</select>
										</div>
										</c:if>
										<div class="row">
											<div class="col-sm-4">
												<input type="text" class="form-control" id="input-postCode" name="postCode" placeholder="우편번호" readonly>
											</div>
											<div class="col-sm-6">
												<input type="button" class="btn btn-primary" id="button-searchAddr" value="우편번호 조회" onclick="searchAddr();">
											</div>
										</div>							
										<div class="form-group">
											<input type="text" class="form-control" id="input-addr" name="addr" placeholder="주소" readonly>
										</div>
										<div class="form-group">
											<input type="text" class="form-control" id="input-detailAddr" name="detailAddr" placeholder="상세주소" required>
										</div>								
									</div>
									
									<div class="col-sm-6">
										<h2>회원 정보</h2>
										<!-- 회원 정보 -->
										<div class="form-group">
											<label class="control-label">회원명</label>
											<input type="text" class="form-control" id="input-name" value="${member.memberName }" readonly>
										</div>
										<div class="form-group">
											<label class="control-label">전화번호</label>
											<input type="text" class="form-control" id="input-phone" value="${member.memberPhone }" readonly>
										</div>		
										<div class="form-group">
											<label class="control-label">이메일</label>
											<input type="text" class="form-control" id="input-email" value="${member.memberEmail }" readonly>
										</div>
									</div>
										
										
									<!-- 상품 번호 받아서 저장 하는 곳 -->
									<input type="hidden" name="product_no" value="${orderList.productNo}"/>
									<input type="hidden" name="member_no" value="${member.memberNo }"/>
									<input type="hidden" name="imp_uid" id="imp_uid" value=""/>
									<input type="hidden" name="merchant_uid" id="merchant_uid" value=""/>
									<input type="hidden" name="order_total_price" id="order_total_price"/>
									<input type="hidden" name="order_payType" id="order_payType" value=""/>
									<input type="hidden" name="order_payStatus" id="order_payStatus" value=""/>
								</div>
								<!-- <input type="button" class="btn btn-primary float-right" data-loading-text="Loading..." id="button-submit" value="결제하기"> -->
						</form>
						<button id="payBtn" class="btn btn-primary float-right" onclick="requestPay();">결제하기</button>
					</div>
				</div>
			</div>
		</div>
  </div>

</section>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>