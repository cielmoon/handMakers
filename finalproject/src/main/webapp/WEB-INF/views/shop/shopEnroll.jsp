<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.2/css/all.css" integrity="sha384-fnmOCqbTlWIlj8LyTjo7mOUStjsKC4pOpQbqyi7RrhN7udi9RwhKkMHpvLbHG9Sr" crossorigin="anonymous">
<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
<c:set var="path" value="${pageContext.request.contextPath }" />
<style>
.mt-1 {
	margin-top: 10px;
}
.mr-1 {
	margin-right: 10px;
}
.float-right {
	float: right;
}
.f-circle {
	font-weight: bold;
	display: block;
	border: 1px solid #860000;
	border-radius: 999px;
	padding: 6px 12px;
}
.i-contact {
	font-size: 20px;
}
</style>

<script>
	$(function(){
		/* 선택 브랜드 변경 시 사업자등록번호 변경 */
		$("#select-brand").change(function(){
			var brandNo = $("#select-brand").find(":selected").index();
			
			/* $.ajax({
				url:"${path}/shop/selectBrand.do",
				data:{"brandNo" : brandNo},
				success:function(data){
					$("#input-license").val(data);
					
					
				}
			});  */
		}); 
	});
</script>

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
					<div class="panel-body">
						<div class="row">
							<div class="col-sm-5">
								<h2>내 브랜드 정보</h2>
								<p>상품을 제안할 브랜드를 선택해 주세요.</p>
								<div class="form-group">
									<label for="input-license" class="control-label">브랜드</label>
									<select class="form-control" name="brandNo" id="select-brand">
										<c:if test="${list }.size() < 1">
											<option selected>등록된 브랜드 없음</option>		
										</c:if>
										<c:forEach items="${list }" var="b" varStatus="vs">
											<option ${vs.count==1? "selected" : ""} value="${b.brandNo }">${b.brandTitle }</option>
										</c:forEach>
									</select>
								</div>
								<div class="form-group">
									<label for="input-brandLicense" class="control-label">사업자 등록번호</label>
									<input type="text" class="form-control" id="input-license" name="brandLicense" value='${list!=null? list[0].brandLicense : ""}' readonly>
								</div>
							</div>
							<div class="col-sm-1"></div>
							<div class="col-sm-6">
							    <h2>입점문의 | handmakers</h2>
							    <br/>
								<p>핸드메이커스에서는 훌륭한 제품이나 아이디어를 기다립니다.</p>
								<p>소비자와 소통할 수 있는 채널이 여러분께 항상 열려있습니다.</p>
								<p>새로운 브랜드나 제품의 많은 제안을 기대하고 있으며</p>
								<p>소비자를 만날 수 있는 좋은 소개의 기회로 만들어가기를 바랍니다.</p>
					      	</div>
						</div>
						<div class="row mt-1">
							<div class="col-sm-12">
								<input type="button" class="btn btn-primary float-right" data-loading-text="Loading..." 
								id="button-product" value="상품 제안하기" onclick='location.href="${path }/shop/productEnroll.do"'>						
								<input type="button" class="btn btn-primary float-right mr-1" data-loading-text="Loading..." 
								id="button-brand" value="브랜드 등록하기" onclick='location.href="${path}/shop/brandEnroll.do"'>					
							</div>
						</div>
					</div>    
				</div>
			</div>
		</div>
	</div>
</section>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>