<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
<c:set var="path" value="${pageContext.request.contextPath }" />
<!-- 다음 주소검색 API -->
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script>
$(function(){
	/* 사업자 등록번호 입력 시 글자 제한 및 자동 하이픈 추가 */
	$('#input-license').on('keydown',function(){
     var key = event.charCode || event.keyCode || 0;
     $text = $(this); 
     if (key !== 8 && key !== 9) {
         if ($text.val().length === 3) {
             $text.val($text.val() + '-');
         }
         if ($text.val().length === 6) {
             $text.val($text.val() + '-');
         }
     }
     return (key == 8 || key == 9 || key == 46 || (key >= 48 && key <= 57) || (key >= 96 && key <= 105));
 	})
});

function validate(){
	/* 사업자 등록번호 길이 확인(12자리) */
	var license = $('#input-license').val();
	if(license.trim().length < 12)
	{
		alert("사업자 등록번호를 정확하게 입력해 주세요.");
		$('#input-license').focus();
		return false;
	}
	
	var brandTitle = $('#input-brandTitle').val();
	if(brandTitle.trim().length < 1)
	{
		alert("브랜드명을 정확하게 입력해 주세요.");
		$('#input-brandTitle').val('');
		$('#input-brandTitle').focus();
		return false;
	}
	
	var brandAddr = $('#input-brandAddr').val();
	if(brandAddr.trim().length < 1)
	{
		alert("사업장 주소를 입력해주세요.");
		return false;
	}
	
	return true;
}

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
</script>
<style>
.mt-1 {
	margin-top: 10px;
}
.float-right {
	float: right;
}
</style>
<section>
	<div class="container">
		<ul class="breadcrumb">
			<li><a href="${path}"><i class="fa fa-home"></i></a></li>
			<li><a href="#">문의하기</a></li>
			<li><a href="#">입점문의</a></li>
		</ul>
		<div class="row">
			<div class="col-sm-12" id="content">
					<div class="panel panel-default">
						<div class="panel-heading">
							<h4 class="panel-title">
								<a>Step 1: 브랜드 정보 등록</a>
							</h4>
						</div>
						<div class="panel-body">
							<form name="brandEnrollFrm" action="${path}/shop/brandEnrollEnd.do?memberNo=${member.memberNo}" method="post" onsubmit="return validate();">
								<div class="row">
									<div class="col-sm-6">
										<h2>브랜드 정보</h2>
										<p>* 표시는 필수 입력 사항입니다.</p> 
										<div class="form-group">
											<label for="input-license" class="control-label">사업자 등록번호 *</label>
											<input type="text" class="form-control" id="input-license" name="brandLicense" maxlength="12" required>
										</div>
										<div class="form-group">
											<label for="input-brandTitle" class="control-label">브랜드명 *</label>
											<input type="text" class="form-control" id="input-brandTitle" name="brandTitle" required>
										</div>
										
										<div class="row">
											<div class="col-sm-6">
												<label for="input-brandFormat" class="control-label">업태 *</label>
												<input type="text" class="form-control" id="input-brandFormat" name="brandFormat" value="제조업/전자상거래업" readonly>
											</div>
											<div class="col-sm-6">
												<label for="input-brandType" class="control-label">업종 *</label>
												<input type="text" class="form-control" id="input-brandType" name="brandType" placeholder="ex)의류">
											</div>
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
									<div class="col-sm-6">
										<h2>담당자 정보</h2>
										<p>연락이 가능한 담당자 정보를 확인해주세요.</p>
										<div class="form-group">
											<label class="control-label">이름</label>
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
									</div>
								</div>
								<input type="submit" class="btn btn-primary float-right" data-loading-text="Loading..." id="button-submit" value="등록하기">
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
</section>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>