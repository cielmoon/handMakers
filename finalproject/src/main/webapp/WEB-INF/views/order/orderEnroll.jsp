<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
	<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath}"/>

<!-- 다음 주소검색 API -->
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<!-- jQuery -->
<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
<!-- iamport.payment.js -->
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>

<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
<script>
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
    	   document.getElementById('input-brandZipCode').value = data.zonecode;
           document.getElementById("input-brandAddr").value = expRoadAddr;
           },
           shorthand : false //'시','도' 부분을 축약 표시
        	}).open({
  				popupName: 'postcodePopup',
				left: (window.screen.width / 2) - (width / 2),
			    top: (window.screen.height / 2) - (height / 2)
      		});
}

function requestPay() {
	var IMP=window.IMP;
	IMP.init('imp16711907');
    // IMP.request_pay(param, callback) 호출
	IMP.request_pay({
	    pg : 'kakaopay',
	    pay_method : 'card',
	    merchant_uid : 'merchant_' + new Date().getTime(),//환불시 필요한 정보
	    name : '테스트상품',
	    amount : '1',
	    buyer_email : 'pjun127@naver.com',
	    buyer_name : '박종언',
	    buyer_tel : '010-1234-5678',
	    buyer_addr : '서울특별시 강남구 삼성동',
	    buyer_postcode : '123-456',
	    m_redirect_url : 'https://www.myservice.com/payments/complete'
	}, function(rsp) {
		console.log(rsp);
	    if ( rsp.success ) {
	    	//[1] 서버단에서 결제정보 조회를 위해 jQuery ajax로 imp_uid 전달하기
	    	console.log(rsp);
	    	jQuery.ajax({
	    		url: "${path}/test/pay", //cross-domain error가 발생하지 않도록 주의해주세요
	    		type: 'POST',
	    		dataType: 'json',
	    		data: {
		    		imp_uid : rsp.imp_uid
		    		
		    		//기타 필요한 데이터가 있으면 추가 전달
	    		}
	    		
	    	}).done(function(data) {
	    		console.log(data);
	    		//[2] 서버에서 REST API로 결제정보확인 및 서비스루틴이 정상적인 경우
	    		if ( everythings_fine ) {
	    			var msg = '결제가 완료되었습니다.';
	    			msg += '\n고유ID : ' + rsp.imp_uid;
	    			msg += '\n상점 거래ID : ' + rsp.merchant_uid;
	    			msg += '\결제 금액 : ' + rsp.paid_amount;
	    			msg += '카드 승인번호 : ' + rsp.apply_num;
	    			
	    			alert(msg);
	    		} else {
	    			//[3] 아직 제대로 결제가 되지 않았습니다.
	    			//[4] 결제된 금액이 요청한 금액과 달라 결제를 자동취소처리하였습니다.
	    		}
	    	});
	    } else {
	        var msg = '결제에 실패하였습니다.';
	        msg += '에러내용 : ' + rsp.error_msg;
	        
	        alert(msg);
	    }
	});

}
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
							<form name="brandEnrollFrm" action="${path}/order/orderEnrollEnd.do" method="post" onsubmit="return validate();">
								<div class="row">
									<div class="col-sm-12">
										<h2>담당자 정보</h2>
										<p>연락이 가능한 담당자 정보를 확인해주세요.</p>
										<div class="form-group">
											<label class="control-label">구입자ID</label>
											<input type="text" class="form-control" id="input-name" value="${member.memberName }" readonly>
										</div>
										<div class="form-group">
											<label class="control-label">전화번호</label>
											<input type="text" class="form-control" id="input-phone" value="${member.memberPhone }" readonly>
										</div>		
										<div class="form-group">
											<label class="control-label">E-Mail</label>
											<input type="text" class="form-control" id="input-email" value="${member.memberEmail }" readonly>
										</div>
										<div class="form-group">
											<label class="control-label">상품명</label>
											<input type="text" class="form-control" id="input-email" value="${member.memberEmail }" readonly>
										</div>
										<label class="control-label mt-1">사업장 소재지 *</label>
										<div class="row">
											<div class="col-sm-4">
												<input type="text" class="form-control" id="input-brandZipCode" name="brandZipCode" placeholder="우편번호" readonly>
											</div>
											<div class="col-sm-6">
												<input type="button" class="btn btn-primary" id="button-searchAddr" value="우편번호 조회" onclick="searchAddr();">
											</div>
										</div>							
										<div class="form-group">
											<input type="text" class="form-control" id="input-brandAddr" name="brandAddr" placeholder="주소" readonly>
										</div>
										<div class="form-group">
											<input type="text" class="form-control" id="input-brandDetailAddr" name="brandDetailAddr" placeholder="상세주소" required>
										</div>								
									</div>
								</div>
								<!-- HTML -->
								<button onclick="requestPay()">결제하기</button>
								<input type="button" class="btn btn-primary float-right" data-loading-text="Loading..." id="button-submit" value="결제하기">
						</form>
					</div>
				</div>
			</div>
		</div>
  </div>

</section>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>