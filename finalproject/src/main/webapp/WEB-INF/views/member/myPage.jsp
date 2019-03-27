<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath }" />
<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>

<style>
	#memberProfileTitle, #memberProfileArea {
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
	$(function() {
		$("#newProfileImg").on("change", enrollMemberImg);
	})
	
	function selectBrand(brandNo, brandState) {
		if (brandState == 'a' || brandState == 'c') {
			alert("승인되지 않은 브랜드입니다.");
		} else {
			location.href = "${path}/shop/brandHome.do?brandNo=" + brandNo;
		}
	}

	function enrollMemberImg(e) {
		var files = e.target.files;
		var filesArr = Array.prototype.slice.call(files);

		filesArr.forEach(function(f) {
			if (!f.type.match("image/*")) {
				alert("이미지 확장자만 등록해주세요.");
				$("#newProfileImg").val('');
				$("#memberProfile").attr("src", "${path }/resources/image/memberProfile/${member.memberProfile }").css('width', '100px').css('height', '100px');
				
				return;
			}

			sel_file = f;

			var reader = new FileReader();
			reader.onload = function(e) {
				$("#memberProfile").attr("src", e.target.result).css('width',
						'100px').css('height', '100px');
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
			<li><a href="${path}/member/myPage.do">마이페이지</a></li>
		</ul>
		<br />
		<div class="row">
			<div class="col-sm-3 hidden-xs column-left" id="column-left">
				<div class="column-block">
					<div class="columnblock-title">마이페이지</div>
					<div class="account-block">
						<div class="list-group">
							<a class="list-group-item" href="${path }/member/myPage.do">홈</a> 
							<a class="list-group-item" href="${path }/member/checkPassword.do?checkNo=2">내정보 관리</a>
							<a class="list-group-item" href="${path }/member/checkPassword.do?checkNo=3">배송지 설정</a>				
							<a class="list-group-item" href="${path }/member/checkPassword.do?checkNo=1">비밀번호 변경</a> 
							<a class="list-group-item" href="${path }/member/manageOrder.do">주문/배송내역 조회</a>			
							<a class="list-group-item" href="${path }/member/checkPassword.do?checkNo=0">회원탈퇴</a>
						</div>
					</div>
				</div>
				
				<div class="column-block">
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
				</div>

			
			</div>
			<!-- 정보 변경 전에 다시 비밀번호 확인 -->
			<div class="col-sm-9" id="content">
				<div class="row">
					<div class="col-sm-8">
						<div class="well">
							<h1 style="vertical-align: middle; padding-top: 10px">홈</h1>

						</div>

						<p style="text-align: center; width: 100%; margin-top: 50px;">
							<strong>&nbsp;</strong>
						</p>

					</div>
					<div class="col-sm-4">
						<form name="memberProfileFrm" action="${path}/member/changeProfile.do" method="post" onsubmit="return validate();" enctype="multipart/form-data">
						<div class="well">
							<div>
								<h2 id="memberProfileTitle">프로필</h2>
								<!-- 라운드로 꾸며야함 style로 -->
								<div class="well" id="memberProfileArea">
										<img src="${path }/resources/image/memberProfile/${member.memberProfile }" id="memberProfile" width="100" height="100" style="border-radius: 50%" />
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