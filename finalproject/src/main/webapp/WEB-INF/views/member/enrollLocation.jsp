<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath }" />
<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
<!-- 다음 주소검색 API -->
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
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
            	var postCode = data.zonecode;
            }
    	   
    	   document.getElementById("input-deliveryPostCode").value = postCode;
           document.getElementById("input-deliveryAddr").value = expRoadAddr;
           },
           shorthand : false //'시','도' 부분을 축약 표시
        	}).open({
  				popupName: 'postcodePopup',
				left: (window.screen.width / 2) - (width / 2),
			    top: (window.screen.height / 2) - (height / 2)
      		});
}

function validate() {
	if ($("#input-deliveryPostCode").val() == "") {
		alert("우편번호(배송지)를 입력해주세요.");
		$("#input-deliveryPostCode").focus();

		return false;
	}

	if ($("#input-deliveryAddr").val() == "") {
		alert("우편번호(배송지)를 입력해주세요.");
		$("#input-deliveryAddr").focus();

		return false;
	}
	
	if ($("#input-deliveryDetailAddr").val() == "") {
		alert("상세주소를 입력해주세요.");
		$("#input-deliveryDetailAddr").focus();

		return false;
	}
	
	return true;
}
</script>
<style>
#input-deliveryDetailAddr, #enrollBtn{
	margin-top: 10px;
	margin-bottom: 10px;
}
.mt-1 {
	margin-top: 10px;
}

.float-right {
	float: right;
}

.pr-0 {
	padding-right: 0;
}

.btn-120 {
	width: 120px;
}
</style>
<section>
	<div class="container">
		<ul class="breadcrumb">
			<li><a href="${path }"><i class="fa fa-home"></i></a></li>
			<li><a href="${path}/member/myPage.do">마이페이지</a></li>
			<li><a href="${path }/member/checkPassword.do?checkNo=3">배송지 설정</a></li>
			<li><a href="#">배송지 등록</a></li>
		</ul>
		<br />
		<div class="row">
			<div class="col-sm-3 hidden-xs column-left" id="column-left">
				<div class="column-block">
					<div class="columnblock-title">마이페이지</div>
					<div class="account-block">
						<div class="list-group">
							<a class="list-group-item" href="${path }/member/myPage.do">홈</a>
							<a class="list-group-item"
								href="${path }/member/checkPassword.do?checkNo=2">내정보 관리</a> <a
								class="list-group-item"
								href="${path }/member/checkPassword.do?checkNo=3">배송지 설정</a> <a
								class="list-group-item"
								href="${path }/member/checkPassword.do?checkNo=1">비밀번호 변경</a> <a
								class="list-group-item" href="${path }/member/manageOrder.do">주문/배송내역
								조회</a> <a class="list-group-item"
								href="${path }/member/checkPassword.do?checkNo=0">회원탈퇴</a>
						</div>
					</div>
				</div>

<%-- 				<div class="column-block">
					<c:if test="${member.memberAuthority == 'S'}">		
						<div class="columnblock-title">판매자페이지</div>
					</c:if>
					<div class="account-block">
					
						<div class="list-group">
							<c:forEach items="${brandList }" var="b">
								<c:if test="${b.brandState.toString()!='e'}"> <!-- 폐점완료 상태 -->
								<a class="list-group-item brand-list" href="javascript:selectBrand('${b.brandNo }', '${b.brandState }');">${b.brandTitle }				
									<c:if test="${b.brandState.toString()=='a'}"> <!-- 승인요청 상태 -->
										<i class="fa fa-clock-o" style="font-size:20px; float: right;"></i>
									</c:if>
									<c:if test="${b.brandState.toString()=='c'}"> <!-- 브랜드 등록 반려상태 -->
										<i class="fa fa-exclamation-circle" style="font-size:20px; color: firebrick; float: right;"></i>
									</c:if>
								</a>
								</c:if>
							</c:forEach>
						</div>	
					</div>					
				</div> --%>


			</div>
			<!-- 정보 변경 전에 다시 비밀번호 확인 -->
			<div class="col-sm-9" id="content">
				<div class="row">
					<div class="col-sm-2 pr-0"></div>
					<div class="col-sm-8 pr-0">
					<label class="control-label mt-1">배송지 </label>
					<form name="enrollLocationFrm"
						action="${path}/member/enrollLocationEnd.do" method="post"
						onsubmit="return validate();">
						<div class="form-group required">
							<div class="col-sm-4 pr-0">
								<input type="text" class="form-control"
									id="input-deliveryPostCode" name="deliveryPostCode"
									placeholder="우편번호" readonly> 
							</div>
							<div class="col-sm-6 pr-0">
								<input type="text"
									class="form-control" id="input-deliveryAddr"
									name="deliveryAddr" placeholder="주소" readonly>
							</div>
							<div class="col-sm-2 text-right">
								<input type="button" class="btn btn-primary btn-120"
									id="button-searchAddr" value="주소검색" onclick="searchAddr();">
							</div>
						</div>
						<div class="form-group required">
							<div class="col-sm-10 pr-0">
								<input type="text" class="form-control"	id="input-deliveryDetailAddr" 
								name="deliveryDetailAddr" placeholder="상세주소" maxlength="30">
							</div>
							<div class="col-sm-2 pr-0">
								<input type="submit" class="btn btn-primary btn-120" id="enrollBtn" value="등록하기" />
							</div>							
						</div>
					
					</form>
					</div>
					<div class="col-sm-2 pr-0"></div>
				</div>


			</div>
		</div>
	</div>
	</div>
</section>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>