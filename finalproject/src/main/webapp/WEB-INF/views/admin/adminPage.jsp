<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath }" />
<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>

<style>
	#adminProfileTitle, #adminProfileArea {
		text-align: center;
	}
	
	#newProfileImg {
		width: 200px;
	}
	
	#submitBtn {
		margin-top: 10px !important;
	}
</style>

<script>
	$("#newProfileImg").on("change", enrollAdminImg);
	
	function enrollAdminImg(e) {
		var files = e.target.files;
		var filesArr = Array.prototype.slice.call(files);
		
		filesArr.forEach(function(f) {
			if (!f.type.match("image.*")) {
				alert("이미지 확장자만 등록해주세요.");
				
				return;
			}
			
			sel_file = f;
			
			var reader = new FileReader();
			reader.onload = function(e) {
				$("#adminProfile").attr("src", e.target.result).css('width', '100px').css('height', '100px');
			}
			
			reader.readAsDataURL(f);
		});
	}
	
	function validate() {
		if ($("#newProfileImg").val() == "") {
			alert("변경할 사진을 등록해주세요.");
			$("#newProfileImg").focus();
			
			return false;
		}
		
		return true;
	}
</script>

<section>
	<div class="container">
		<ul class="breadcrumb">
			<li><a href="${path }"><i class="fa fa-home"></i></a></li>
			<li><a href="${path}/admin/adminPage.do">관리자페이지</a></li>
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
							<a class="list-group-item"	href="${path}/admin/manageBrand.do">브랜드 등록관리</a>							
							<a class="list-group-item" href="${path}/admin/managePreProduct.do">입점 제안관리</a>
							<a class="list-group-item" href="${path}/admin/manageProduct.do">상품 등록/수정 관리</a>												 
							<a class="list-group-item" href="${path}/admin/manageReProduct.do">상품 종료/중지 목록</a>
							<a class="list-group-item"	href="${path}/admin/manageRequest.do">폐점신고/상품 판매중지 요청</a>					 
						</div>
					</div>
				</div>
			</div>
			<!-- 정보 변경 전에 다시 비밀번호 확인 -->
			<div class="col-sm-9" id="content">
				<div class="row">
					<div class="col-sm-8">
						<div class="well">
							<h1 style="vertical-align: middle; padding-top: 10px">관리자페이지 홈</h1>

						</div>

						<p style="text-align: center; width: 100%; margin-top: 50px;">
							<strong>&nbsp;</strong>
						</p>

					</div>
					<div class="col-sm-4">
						<form name="adminProfileFrm" action="${path}/member/changeProfile.do" method="post" onsubmit="return validate();" enctype="multipart/form-data">
						<div class="well">
							<div>
								<h2 id="adminProfileTitle">관리자 프로필</h2>
								<!-- 라운드로 꾸며야함 style로 -->
								<div class="well" id="adminProfileArea">
									<img src="${path }/resources/image/adminProfile/${member.memberProfile }" id="adminProfile" width="100" height="100" style="border-radius: 50%" />
								</div>
							</div>
							<div>
								
									<input type="file" name="newProfileImg" id="newProfileImg">
									<input type="submit" class="btn btn-primary" id="submitBtn" value="사진 변경하기">
								
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