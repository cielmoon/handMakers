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
		/* 소카테고리 리스트 초기화 */
		$("#select-smallCategory")[0].options.length = 0;
		$.ajax({
			url:"${path}/shop/productEnrollScSet.do",
			data:{"bcNo" : bcNo},
			success:function(data){
				for(var i=0; i<data.list.length; i++)
				{
					$('#select-smallCategory').append($('<option>',
					{
				        value: data.list[i]['scNo'],
				        text : data.list[i]['scTitle']
				    }));
				}
			}
		});
	});
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
	
	return true;
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
								<a>Step 2: 상품 제안하기</a>
							</h4>
						</div>
						<div class="panel-body">
							<form name="productEnrollFrm" action="${path}/shop/productEnrollEnd.do" method="post" onsubmit="return validate();">
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
											<input type="text" class="form-control" id="input-productTitle" name="preProductTitle" required>										
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
								<input type="submit" class="btn btn-primary float-right" data-loading-text="Loading..." id="button-submit" value="등록하기">
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
</section>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>