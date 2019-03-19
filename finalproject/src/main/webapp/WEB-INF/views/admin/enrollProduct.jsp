<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath }" />

<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
<%-- <jsp:param value="" name="pageTitle"/> --%>

<style>
#inputAdminProductProfileImg {
	padding-top: 7px;
	border: none;
}
</style>

<script>
	$(document).ready(function() {
		$("#inputAdminProductProfileImg").on("change", enrollMainImg);
	});
	
	function validate() {
		if ($("#adminProductName").val() == "") {
			alert("상품명을 입력해주세요.");
			$("#adminProductName").focus();

			return false;
		}

		if ($("#adminProductComment").val() == "") {
			alert("한줄설명을 입력해주세요.");
			$("#adminProductComment").focus();

			return false;
		}

		if ($("#adminProductMemberId").val() == "") {
			alert("판매자의 아이디를 입력해주세요.");
			$("#adminProductMemberId").focus();

			return false;
		}

		if ($("#adminProductPrice").val() == "") {
			alert("상품가격을 입력해주세요.");
			$("#adminProductPrice").focus();

			return false;
		}

		if ($("#adminProductSale").val() == "") {
			alert("할인율을 입력해주세요.");
			$("#adminProductSale").focus();

			return false;
		}

		/*
		등록, 마감날짜
		if ($("#adminProductSale").val() == "") {
			alert("할인율을 입력해주세요.");
			$("#adminProductSale").focus();
			
			return false;
		}
		
		if ($("#adminProductSale").val() == "") {
			alert("할인율을 입력해주세요.");
			$("#adminProductSale").focus();
			
			return false;
		}
		 */

		if ($("#adminProductMin").val() == "") {
			alert("최소주문량을 입력해주세요.");
			$("#adminProductMin").focus();

			return false;
		}

		if ($("#adminProductMax").val() == "") {
			alert("최대주문량을 입력해주세요.");
			$("#adminProductMax").focus();

			return false;
		}
	
		return true;
	};
	
	// 메인사진 등록
	function enrollMainImg(e) {
		var files = e.target.files;
		var filesArr = Array.prototype.slice.call(files);
		
		filesArr.forEach(function(f) {
			if (!f.type.match("image.*")) {
				alert("이미지 확장자만 등록해주세요.")
				
				return;
			}
			
			sel_file = f;
			
			var reader = new FileReader();
			reader.onload = function(e) {
				$("#adminProductProfileMainImg").attr("src", e.target.result).css('width', '100%').css('height', '100%');
				console.log("메인사진" + $("#adminProductProfileMainImg").val());
			}
			
			reader.readAsDataURL(f);
		});
	}
</script>

<section>
	<div class="container">
		<ul class="breadcrumb">
			<li><a href="${path }"><i class="fa fa-home"></i></a></li>
			<li><a href="${path}/admin/adminPage.do">관리자페이지</a></li>
			<li><a href="${path}/admin/manageProduct.do">상품 관리</a></li>
			<li><a href="${path}/admin/enrollProduct.do">상품 등록</a></li>
		</ul>
		<br />
		<div class="row">
			<div class="col-sm-3 hidden-xs column-left" id="column-left">
				<div class="column-block">
					<div class="columnblock-title">관리자페이지</div>
					<div class="account-block">
						<div class="list-group">
							<a class="list-group-item" href="${path}/admin/adminPage.do">홈</a> 
							<a class="list-group-item" href="#">공지사항 관리</a> 
							<a class="list-group-item" href="#">메인배너 관리</a> 
							<a class="list-group-item" href="${path}/admin/memberList.do">회원목록</a>
							<a class="list-group-item"	href="${path}/admin/manageBrand.do">브랜드 등록관리</a>
							<a class="list-group-item"	href="${path}/admin/manageBrandClose.do">브랜드 폐점관리</a>  
							<a class="list-group-item" href="${path}/admin/managePreProduct.do">입점 제안관리</a>
							<a class="list-group-item" href="${path}/admin/manageEnrollProduct.do">상품 등록</a>
							<a class="list-group-item"	href="${path}/admin/managProduct.do">상품 판매관리</a>							 
							<a class="list-group-item" href="${path}/admin/manageEndProduct.do">상품 재등록 관리</a>
						</div>
					</div>
				</div>
			</div>
			<!-- 정보 변경 전에 다시 비밀번호 확인 -->
			<div class="col-sm-9" id="content">
				<div class="row">
					<div class="col-sm-12">
						<form class="form-horizontal" enctype="multipart/form-data"	method="post" action="#" onsubmit="return validate();">
						
							<fieldset id="productField0">
							</fieldset>
							
							
							<fieldset id="productField1">	
								<!-- 상품명 -->							
								<div class="form-group required">
									<label for="adminProductName" class="col-sm-2 control-label">상품명</label>
									<div class="col-sm-10">
										<input type="text" class="form-control" id="adminProductName" name="adminProductName" placeholder="상품명을 입력하세요">
									</div>
								</div>
								<!-- 상품 코멘트 -->
								<div class="form-group required">
									<label for="adminProductComment" class="col-sm-2 control-label">한줄설명</label>
									<div class="col-sm-10">
										<input type="text" class="form-control" id="adminProductComment" name="adminProductComment" placeholder="상품의 간단한 설명을 입력하세요">
									</div>
								</div>
								<!-- 상품 관리자 + 판매자 아이디 -->
								<div class="form-group required">
									<label for="adminProductId" class="col-sm-2 control-label">상품등록자</label>
									<div class="col-sm-4">
										<h4>${member.memberName }</h4>										
									</div>
									<label for="adminProductMemberId" class="col-sm-2 control-label">판매자</label>
									<div class="col-sm-4">
										<input type="text" class="form-control" id="adminProductMemberId" name="adminProductMemberId" placeholder="판매자의 아이디를 적어주세요">
									</div>
								</div>
							</fieldset>

							
							<fieldset id="productField2">
								<!-- 상품가격 -->
								<div class="form-group required">
									<label for="adminProductPrice" class="col-sm-2 control-label">상품가격</label>
									<div class="col-sm-4">
										<input type="text" class="form-control" id="adminProductPrice" name="adminProductPrice" placeholder="상품가격을 적어주세요(원)">								
									</div>
									<label for="adminProductSale" class="col-sm-2 control-label">할인율</label>
									<div class="col-sm-4">									
										<input type="number" class="form-control" id="adminProductSale" name="adminProductSale"  min='1' max='100' step='4'>
									</div>
								</div>
								<!-- 등록날짜 ~ 마감날짜 -->
								<div class="form-group required">
									<label for="adminProductId" class="col-sm-2 control-label">등록날짜</label>
									<div class="col-sm-4">
										<input type="text" class="form-control" id="adminProductSale" name="adminProductSale" placeholder="">						
									</div>								
									<label for="adminProductMemberId" class="col-sm-2 control-label">마감날짜</label>
									<div class="col-sm-4">
										<input type="text" class="form-control" id="adminProductSale" name="adminProductSale" placeholder="">
									</div>
								</div>
								<!-- 최소주문량 ~ 최대주문량 -->
								<div class="form-group required">
									<label for="adminProductMin" class="col-sm-2 control-label">최소주문량</label>
									<div class="col-sm-4">
										<input type="number" class="form-control" id="adminProductMin" name="adminProductMin"  min='1' max='10000' step='5'>						
									</div>							
									<label for="adminProductMax" class="col-sm-2 control-label">최대주문량</label>
									<div class="col-sm-4">
										<input type="number" class="form-control" id="adminProductMax" name="adminProductMax"  min='1' max='10000' step='5'>
									</div>
								</div>						
							</fieldset>
							
							<fieldset id="productField2">
								<div class="form-group required">
									<label for="adminProductProfile" class="col-sm-2 control-label">메인사진</label>
									<div class="col-sm-2">
									<input type="file" name="inputAdminProductProfileImg" id="inputAdminProductProfileImg" >
									</div>	
								</div>
								<div class="col-sm-3">
								</div>
								<div class="col-sm-6">
										<img id="adminProductProfileMainImg" src="${path }/resources/image/noImg.png">										
								</div>
								<div class="col-sm-3">
								</div>
								<!-- <div class="form-group required" id="adminProductFiles">
									<label for="inputAdminProductProfileImg" class="inputSrc1">메인사진 추가하기</label>
                 					<input type="file" name="inputAdminProductProfileImg" id="inputAdminProductProfileImg" >
								</div> -->
								<!-- <div class="form-group required" id="filesAddBtn">
									<input type="button" class="btn btn-primary" value="파일추가하기">
								</div> -->
								
							</fieldset>
							
							
							<div class="buttons">
								<div class="pull-right">
									<input type="submit" class="btn btn-primary" value="등록하기">
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