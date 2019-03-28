<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath }" />

<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
<%-- <jsp:para value="" name="pageTitle"/> --%>

<!-- include libraries(jQuery, bootstrap) -->

<!-- <script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.4/jquery.js"></script> -->
<!-- <script src="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.js"></script> -->
<!-- include summernote css/js-->
<link href="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.2/summernote.css" rel="stylesheet">
<script src="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.2/summernote.js"></script>






<!-- 
<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
<link href="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.11/summernote-lite.css" rel="stylesheet">
<script src="http://code.jquery.com/jquery-3.2.1.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.11/summernote-lite.js"></script>
 -->

<!-- <script src="http://jonthornton.github.io/Datepair.js/dist/datepair.js"></script>
<script src="http://jonthornton.github.io/Datepair.js/dist/jquery.datepair.js"></script> -->
<style>
#select-brand, #select-bigcategory, #select-smallcategory {
	margin-bottom: 10px;
}

#newProductDetailImg, #newProductOption {
	width: 500px;
}

#adminProductProfileMainImg {
	padding-top: 7px;
	border: none;
	max-height: 350px;
	max-width: 350px;
}

#newProductOptionList {
	width: 300px;
}

#newProductDetailComments {
	width: 800px;
	height: 600px;
}
</style>

<script>
	$(document).ready(function() {
		var today = new Date();
		  var year = today.getFullYear();
		  var month = ("0" + (today.getMonth() + 1)).slice(-2);
		  var day = ("0" + (today.getDate() + 1)).slice(-2);
			
		  var minDate = (year + "-" + month + "-" + day);
			
		  $("#productNewEndDate").attr("min", minDate);
		  
		  function fn_setDatePickerMax(){
    		var datePicker = $('#productNewEndDate');
    		datePicker.min = new Date(new Date().getTime() - new Date().getTimezoneOffset() * 60000).toISOString().split("T")[0];
 		  }
	});

	function validate() {
		var date = new Date();
		var selectedEndDate = $("#productNewEndDate").val();
		var selectedEndDateArr = selectedEndDate.split('-');
		var endDate = new Date(selectedEndDateArr[0], parseInt(selectedEndDateArr[1]) -1, selectedEndDateArr[2]);
		
		if ($("#productNewPrice").val() == "") {
			alert("상품 가격을 입력해주세요.");
			$("#productNewPrice").focus();

			return false;
		}
	
		if ($("#productNewMin").val() == "") {
			alert("최소 주문량을 입력해주세요.");
			$("#productNewMin").focus();

			return false;
		}
	
		if ($("#productNewMax").val() == "") {
			alert("최대 주문량을 입력해주세요.");
			$("#productNewMax").focus();

			return false;
		}
		
		if ($("#productNewEndDate").val() == "") {
			alert("상품 마감 날짜를 입력해주세요.");
			$("#productNewEndDate").focus();
			
			return false;
		}
		
		return true;
	};
	
	$(function() {
		var numberRegex = /^[0-9]+$/;
		
		$("#productNewPrice").on('change keyup paste', (function () {
			var productNewPrice = $("#productNewPrice").val();
			if (productNewPrice.length > 0) {
				if(!numberRegex.test(productNewPrice)) {
					alert("상품 가격은 숫자만 입력해주세요.");
					$("#productNewPrice").val('');
					/* $("#newProductPrice").focus(); */

					return;
				}
			}
			if(productNewPrice.length > 7 ){
				alert("상품은 1천원 ~ 1천만원 사이의 금액만 입력 가능합니다.");
				$("#productNewPrice").val('');
				
				return;	
			}
		}))
		
		$("#productNewMin").keyup(function() {
			var productNewMin = $("#productNewMin").val();
			if (productNewMin.length > 0) {
				if(!numberRegex.test(productNewMin)) {
					alert("최소 주문량은 숫자만 입력해주세요.");
					$("#productNewMin").val('');
					/* $("#newProductPrice").focus(); */

					return;
				}
			}
			
			if (parseInt($("#productNewMin").val()) < 1 || parseInt($("#productNewMin").val()) > 10000) {
				alert("최소 주문량은 1 ~ 10000 사이의 숫자만 입력해주세요.");
				$("#productNewMin").val('');
				/* $("#newProductSale").focus(); */
				
				return;
			}
		})
		
		$("#productNewMax").keyup(function() {
			var productNewMax = $("#productNewMax").val();
			
			if (productNewMax.length > 0) {
				if(!numberRegex.test(productNewMax)) {
					alert("최대 주문량은 숫자만 입력해주세요.");
					$("#productNewMax").val('');
					/* $("#newProductPrice").focus(); */

					return;
				}
			}
			
			if (parseInt($("#productNewMax").val()) < 1 || parseInt($("#productNewMax").val()) > 10000) {
				alert("최대 주문량은 1 ~ 10000 사이의 숫자만 입력해주세요.");
				$("#productNewMax").val('');
				/* $("#newProductSale").focus(); */
				
				return;
			}
		})
		
		$("#productNewMin").blur(function() {			
				if (parseInt($("#productNewMin").val()) > parseInt($("#productNewMax").val())) {
					alert("최대 주문량은 최소 주문량보다 크게 입력해주세요.")
					$("#productNewMin").val('');
					$("#productNewMax").val('');
					$("#productNewMax").focus();
				}
			});
		
		$("#productNewMax").blur(function() {			
			if (parseInt($("#productNewMin").val()) >= parseInt($("#productNewMax").val())) {
				alert("최대 주문량은 최소 주문량보다 크게 입력해주세요.")
				$("#productNewMin").val('');
				$("#productNewMax").val('');
				$("#productNewMin").focus();
			}
		});
	});
</script>

<section>
	<div class="container">
		<ul class="breadcrumb">
			<li><a href="${path }"><i class="fa fa-home"></i></a></li>
			<li><a href="${path}/admin/adminPage.do">관리자페이지</a></li>
			<li><a href="${path}/admin/manageProduct.do">상품 등록/수정 관리</a></li>
			<li><a href="#">상품 수정</a></li>
		</ul>
		<br />
		<div class="row">
			<div class="col-sm-3 hidden-xs column-left" id="column-left">
				<div class="column-block">
					<div class="columnblock-title">관리자페이지</div>
					<div class="account-block">
						<div class="list-group">
							<a class="list-group-item" href="${path}/admin/adminPage.do">홈</a>
							<a class="list-group-item" href="${path}/admin/memberList.do">회원목록</a>
							<a class="list-group-item" href="${path}/admin/manageBrand.do">브랜드
								등록관리</a> <a class="list-group-item"
								href="${path}/admin/managePreProduct.do">입점 제안관리</a> <a
								class="list-group-item" href="${path}/admin/manageProduct.do">상품
								등록/수정 관리</a> <a class="list-group-item"
								href="${path}/admin/manageReProduct.do">상품 종료/중지 목록</a> <a
								class="list-group-item" href="${path}/admin/manageRequest.do">폐점신고/상품
								판매중지 요청</a>
						</div>
					</div>
				</div>
			</div>
			<!-- 정보 변경 전에 다시 비밀번호 확인 -->
			<div class="col-sm-9" id="content">
				<div class="row">
					<div class="col-sm-6">
						<div class="thumbnails">
							<div>
								<a class="thumbnail"
									href="${path }/resources/image/product/${product.PRODUCT_PROFILE}"
									><img
									src="${path }/resources/image/product/${product.PRODUCT_PROFILE}"
									/></a>
							</div>
							<div id="product-thumbnail" class="owl-carousel">
								<div class="item">
									<div class="image-additional">
										<a class="thumbnail  "
											href="${path }/resources/image/product/${product.PRODUCT_PROFILE}"
											> <img
											src="${path }/resources/image/product/${product.PRODUCT_PROFILE}"											
											/></a>
									</div>
								</div>

								<c:forEach items="${productImg }" var="pi">
									<div class="item">
										<div class="image-additional">
											<a class="thumbnail  "
												href="${path }/resources/image/product/${pi.productSubImg}"
												title="lorem ippsum dolor dummy"> <img
												src="${path }/resources/image/product/${pi.productSubImg}"
												title="lorem ippsum dolor dummy"
												alt="lorem ippsum dolor dummy" /></a>
										</div>
									</div>
								</c:forEach>
							</div>
						</div>
					</div>
					<div class="col-sm-6">
						<form id="updateProductInfoEndFrm" action="${path }/admin/updateProductInfoEnd.do"
							method="post" onsubmit="return validate();" >
							<h1 class="productpage-title">${product.PRODUCT_TITLE }</h1>
							<ul class="list-unstyled productinfo-details-top">
								<li>
									<!-- 가격 -->
									<h2>(상품 재등록시 신규 카테고리에 상품이 등록됩니다.)</h2>
									<input type="hidden" name="productNo" value="${product.PRODUCT_NO }"/>
								</li>
							</ul>
							<hr>
							<ul class="list-unstyled productinfo-details-top">
								<li><label>가격:</label> <span>
										<input type="text" class="form-control" id="productNewPrice" name="productNewPrice" min="1000" max="10000000" placeholder="상품가격을 적어주세요(원)"/></span>
								
								</li>
							
							</ul>
							<hr>

							<ul class="list-unstyled product_info">
								<li><label>최소수량:</label> <span>
										<input type="text" id="productNewMin" name="productNewMin" placeholder="최소 수량" min='1' max='10000' placeholder="1부터 10000까지 입력해주세요."/></span></li>
								<li><label>최대수량:</label> <span>
										<input type="text" id="productNewMax" name="productNewMax" placeholder="최대 수량" min='1' max='10000' placeholder="1부터 10000까지 입력해주세요."/></span></li>
										
								<li><label>판매 종료일:</label> <span>
										<input type="date" class="form-control" id="productNewEndDate" name="productNewEndDate" placeholder="마감날짜"/></span></li>
								
							</ul>
							<hr />


							<div class="buttons">																
								<div class="pull right">									
									<c:if test="${member!=null }">
										<input type="submit" class="btn btn-primary" value="상품 재등록하기" />
										<!-- <button type="button" data-toggle="tooltip" class="btn btn-default compare" title="Compare this Product" ><i class="fa fa-exchange"></i></button> -->
									</c:if>
								</div>								
							</div>
						</form>
					</div>

				</div>
			</div>


		</div>
	</div>
</section>


<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>