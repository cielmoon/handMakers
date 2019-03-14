<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
<c:set var="path" value="${pageContext.request.contextPath }" />

<script>
$(function(){
	$("#select-bigCategory").change(function(){
		var bcNo = $("#select-bigCategory").find(":selected").val();
		/* 소카테고리 리스트 초기화  */
		$("#select-smallCategory")[0].options.length = 0;
		$.ajax({
			url:"${path}/shop/productEnrollScSet.do",
			data:{"bcNo" : bcNo},
			success:function(data){
				for(var i=0; i<data.scList.length; i++)
				{
					$('#select-smallCategory').append($('<option>',
					{
				        value: data.scList[i]['scNo'],
				        text : data.scList[i]['scTitle']
				    }));
				}
			}
		});
	});
	
	//상품 특징 입력 글자수 제한
	$('#input-productDiscript').on('keyup', function() {
		if (this.value.length > 200) {
			alert("상품 특징은 최대 100자 까지만 입력해 주세요.");
			this.value = this.value.substring(0, 200);
			this.focus();
		}
	});
	
	/* 약관 동의 완료 후 상품등록 버튼 클릭 */
	$( "#button-enroll" ).click(function() {
		  $( "#frm-productEnroll" ).submit();
	});
});

function validate() {
	var pTitle = $('#input-productTitle').val();
	if(pTitle.trim().length < 1)
	{
		alert("상품명을 정확하게 입력해 주세요.");
		$('#input-productTitle').val('');
		$('#input-productTitle').focus();
		return false;
	}
	
	var pDiscript = $('#input-productDiscript').val();
	if(pDiscript.trim().length < 1)
	{
		alert("상품 특징을 정확하게 입력해 주세요.");
		$('#input-productDiscript').val('');
		$('#input-productDiscript').focus();
		return false;
	}
		
 	$("#productEnrollModal").modal();
}

function changeAgree(){
	var checkAgree = $("#check-agree");
	var btnEnroll = $("#button-enroll");
	if(checkAgree.is(":checked") == true)
	{
		btnEnroll.prop("disabled", false);
	}else 
	{
		btnEnroll.prop("disabled", true);
	}
}
</script>

<style>
.mt-1 {
	margin-top: 10px;
}
.float-right {
	float: right;
}
#input-productFeature {
	resize: none;
}
.modal-dialog {z-index: 1050;}
</style>

<section>
	<div class="container">
		<ul class="breadcrumb">
			<li><a href="${path}"><i class="fa fa-home"></i></a></li>
			<li><a href="#">문의하기</a></li>
			<li><a href="${path}/shop/shopEnroll.do">입점문의</a></li>
			<li><a href="${path}/shop/productEnroll.do?brandNo=${brand.brandNo}">상품제안</a></li>	
		</ul>
		<div class="row">
			<div class="col-sm-12" id="content">
					<div class="panel panel-default">
						<div class="panel-heading">
							<h4 class="panel-title">
								<a>Step 2: 상품 제안하기</a>
							</h4>
						</div>
						<div class="panel-body">
							<form name="productEnrollFrm" id="frm-productEnroll" action="${path}/shop/productEnrollEnd.do" method="post">
								<div class="row">
									<div class="col-sm-6">
										<h2>상품 정보</h2>
										<p>* 표시는 필수 입력 사항입니다.</p> 
										<div class="form-group">
											<label class="control-label">브랜드 *</label>
											<input type="text" class="form-control" id="input-brandTitle" value="${brand.brandTitle }" readonly>	
											<input type="hidden" name="brandNo" value="${brand.brandNo }"/>										
										</div>
										
										<label class="control-label">카테고리 *</label>
										<div class="row">
										 	<div class="col-sm-6">
												<select class="form-control" id="select-bigCategory" name="bcNo" required>
													<c:forEach items="${bcList }" var="b" varStatus="vs">
															<option ${vs.count==1? "selected" : ""} value="${b.bcNo }">${b.bcTitle}</option>
													</c:forEach>	
												</select>
											</div>
										
											<div class="col-sm-6">
												<select class="form-control" id="select-smallCategory" name="scNo" required>
													<c:forEach items="${scList }" var="s" varStatus="vs">
															<option ${vs.count==1? "selected" : ""} value="${s.scNo }">${s.scTitle}</option>
													</c:forEach>
												</select>
											</div> 
										</div>
										
										<div class="form-group">
											<label for="input-productName" class="control-label">상품명 *</label>
											<input type="text" class="form-control" id="input-productTitle" name="preProductTitle" maxlength="25" required>										
										</div>
										
										<div class="form-group">
											<label for="input-productFeature" class="control-label">특징 소개 *</label>
											<textarea class="form-control" id="input-productDiscript" name="preProductDiscript"
											rows="5" placeholder="ex) 브랜드에서 자체적으로 개발한 가죽 PML과 최고급 원단 해리스 트위드를 이용했습니다." required></textarea>										
										</div>
									</div>
									<div class="col-sm-6">
										<h2>담당자 정보</h2>
										<p>연락이 가능한 담당자 정보를 확인해주세요.</p>
										<div class="form-group">
											<label class="control-label">이름</label>
											<input type="text" class="form-control" id="input-name" value="${member.memberName }" name="memberName" readonly>
										</div>
										<div class="form-group">
											<label class="control-label">전화번호</label>
											<input type="text" class="form-control" id="input-phone" value="${member.memberPhone }" name="memberPhone" readonly>
										</div>		
										<div class="form-group">
											<label class="control-label">E-Mail</label>
											<input type="text" class="form-control" id="input-email" value="${member.memberEmail }" name="memberEmail" readonly>
										</div>								
									</div>
								</div>
								<input type="button" class="btn btn-primary float-right" data-loading-text="Loading..." id="button-submit" value="등록하기" onclick="return validate();">
						</form>
					</div>
				</div>
				
				<!-- Modal -->
				<div class="modal fade" tabindex="-1" role="dialog" id="productEnrollModal">
				  <div class="modal-dialog">
				    <div class="modal-content">
				      <div class="modal-header">
				        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
				        <h4 class="modal-title">핸드메이커스 판매회원 약관</h4>
				      </div>
				      <div class="modal-body" style="overflow: auto; height: 180px;">
								<h4>제1조 (목적)</h4> 
								<span>본 약관은 핸드메이커스 주식회사(이하 “회사”)와 회사가 운영하는 웹사이트에 판매회원으로 등록하여 사이트에서 판매회원에게 제공하는 전자상거래 관련 서비스와 기타 서비스(이하 “서비스”)를 이용하는 자 간의 권리, 의무를 확정하고 이를 이행하여 상호 발전을 도모하는 것을 목적으로 합니다.</span>
								<h4>제2조 (용어의 정의)</h4> 
								<p>본 약관에서 사용되는 용어의 정의는 본 약관에서 별도로 규정하는 경우를 제외하고 핸드메이커스 구매회원 이용약관 제2조를 따릅니다.</p>
								<p>① 서비스이용료는 회사가 제공하는 서비스를 이용하는 데 따른 대가로 판매회원이 회사에 지급해야 하는 금액을 의미하며, 회사는 판매대금 또는 구매회원으로부터 예치받은 금액에서 서비스이용료를 공제하는 등으로 판매회원에게 정산합니다.</p>
								<p>② 서비스이용료는 판매가(판매회원이 정한 최초의 상품가격을 말합니다 이하 “판매가”)에 회사가 정한 비율(이하 “서비스이용료율”이라 합니다)을 곱한 금액과 각종 판매촉진서비스(회사가 진행하는 광고 및 프로모션, 검색 등) 이용료를 포함합니다.</p>
								<p>③ 판매회원은 최초 상품 등록 후 판매가의 10% 할인된 가격으로 10개의 상품을 판매해야합니다.</p>
					  </div>
				      <div class="modal-footer">
				        <div class="checkbox text-left"> 
							<label>
							  <input class="form-control" name="checkAgree" id="check-agree" type="checkbox" onchange="changeAgree();">위 이용약관에 동의합니다.
							</label>
							<button type="button" class="btn btn-primary float-right" id="button-enroll" disabled>등록하기</button>
						</div>					
				      </div>
				    </div>
				  </div>
				</div>
				
			</div>
		</div>
	</div>
</section>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>