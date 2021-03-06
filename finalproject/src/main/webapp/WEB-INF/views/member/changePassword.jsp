<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath }" />
<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
<style>
#memberPwd, #pwdCheck, #memberPwdCheck{
	margin-bottom: 10px;
	margin-top: 10px;	
}
#labelMemberPwd, #labelMemberPwdCheck {
	margin-top: 20px;
}
</style>

<script>
	function validate() {
		var passwordRegex = /^.*(?=.{6,20})(?=.*[0-9])(?=.*[a-zA-Z]).*$/; // 영문, 숫자 혼합하여 6~20자리 이내
		var memberPwd = $("#memberPwd").val();
		
		if ($("#memberPwd").val() == "") {
			alert("비밀번호를 입력해주세요.");
			$("#memberPwd").focus();
			return false;
		}
		
		if ($("#memberPwdCheck").val() == "") {
			alert("비밀번호 확인을 해주세요.");
			$("#memberPwd").focus();
			return false;
		}
		
		if (!passwordRegex.test(memberPwd)) {
			alert("비밀번호는 영문, 숫자, 특수문자를 사용하여 6~20자리 이내로 입력해주세요.");
			$("#memberPwd").val("");
			$("#memberPwdCheck").val("");
			$("#memberPwd").focus();
			
			return false;
		}
		
		return true;
	}
	
	$(function() {
		$("#memberPwdCheck").blur(function() {
			var p1 = $("#memberPwd").val(), p2 = $("#memberPwdCheck").val();
			
			if (p1 != p2) {
				alert("패스워드가 일치하지 않습니다.");
				$("#memberPwdCheck").val('');
				$("#memberPwd").focus();
			}
		});
	});
</script>
<section>
	<div class="container">
		<ul class="breadcrumb">
			<li><a href="${path }"><i class="fa fa-home"></i></a></li>
			<li><a href="${path}/member/myPage.do">마이페이지</a></li>
			<li><a href="#">비밀번호 변경</a></li>
		</ul>
		<br />
		<div class="row">
			<div class="col-sm-3 hidden-xs column-left" id="column-left">
				<div class="column-block">
					<div class="columnblock-title">마이페이지</div>
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
			<!-- 정보 변경 전에 다시 비밀번호 확인 -->
			<div class="col-sm-9" id="content">
				<div class="row">
					<div class="col-sm-3"></div>
					<div class="col-sm-6">				
					<form name="memberPwdUpdateFrm" action="${path}/member/changePasswordEnd.do" method="post" onsubmit="return validate();">
						<div class="form-group required" id="memberInfo">
					 		<h1 class="col-sm-3"></h1>
							<h1 class="col-sm-6"></h1>
							<h1 class="col-sm-3"></h1>
				
						</div>
						<div class="form-group required" id="memberInfo">							
							<div class="col-sm-12">
									<input type="hidden" class="form-control"  name="memberNo" id="memberNo" value="${member.memberNo }" >
							</div>
						</div>	
						<div class="form-group required" id="memberInfo">
							<label for="input-id" class="col-sm-5 control-label" id="labelMemberPwd">비밀번호</label>
							<div class="col-sm-7">
									<input type="password" class="form-control"  name="memberPwd" id="memberPwd" >
							</div>
						</div>
						<div class="form-group required" id="memberInfo">
							<label for="input-id" class="col-sm-5 control-label" id="labelMemberPwdCheck">비밀번호 확인하기</label>
							<div class="col-sm-7">
									<input type="password" class="form-control"  name="memberPwdCheck" id="memberPwdCheck" >
							</div>
						</div>
						<div class="form-group required" id="memberInfo">
							<div class="col-sm-4"></div>							
							<div class="col-sm-4">
								<input type="submit" class="form-control"  id="pwdCheck" name="pwdCheck" value="비밀번호 변경">
							</div>
							<div class="col-sm-4"></div>
						</div>
					</form>
					</div>
					<div class="col-sm-3"></div>
					
				</div>
			</div>
		</div>
	</div>
</section>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>