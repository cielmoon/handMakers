<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath }" />
<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
<style>
#memberUpdate, #memberId, #memberName, #memberEmail, #memberPhone {
	margin-bottom: 10px;
	margin-top: 10px;	
}

#labelMemberId, #labelMemberName, #labelMemberEmail, #labelMemberPhone {
	margin-top: 20px;
}
</style>

<script>
	function validate() {
		var memberEmail = $("#memberEmail").val();
		var emailRegex = /^([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/;
		var memberPhone = $("#memberPhone").val();
		var phoneRegex = /^[0-9]+$/;
		var memberName = $("#memberName").val();
		var nameRegex = /^[ㄱ-ㅎ|가-힣|a-z|A-Z|\*]+$/;
		
		if ($("#memberName").val() == "") {
			alert("이름을 입력해주세요.");
			$("#memberName").focus();
			return false;
		}
		
		if ($("#memberEmail").val() == "") {
			alert("이메일을 입력해주세요.");
			$("#memberEmail").focus();
			return false;
		}
		
		if ($("#memberPhone").val() == "") {
			alert("핸드폰번호를 입력해주세요.");
			$("#memberPhone").focus();
			return false;
		}
		
		if (!emailRegex.test(memberEmail)) {
			alert("잘못된 이메일 형식입니다. 다시 입력해주세요.")
			$("#memberEmail").focus();
			
			return false;
		}
		
		if (!phoneRegex.test(memberPhone)) {
			alert("핸드폰번호는 숫자만 입력해주세요.");
			$("#memberPhone").focus();
			
			return false;
		}
		
		if (!nameRegex.test(memberName)) {
			alert("이름은 한글 또는 영어로 입력해주세요.");
			$("#memberName").focus();
			
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
			<li><a href="#">내정보 관리</a></li>
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
					<div class="col-sm-3"></div>
					<div class="col-sm-6">
					<form name="memberUpdateFrm" action="${path}/member/memberUpdateEnd.do" method="post" onsubmit="return validate();">
						<div class="form-group required" id="memberInfo">
							<label for="input-id" class="col-sm-4 control-label" id="labelMemberId">아이디</label>
							<div class="col-sm-8">
									<input type="text" class="form-control"  name="memberId" id="memberId" 
									value="${member.memberId }" readonly>
							</div>
						</div>
						
						<div class="form-group required" id="memberInfo">
							<label for="input-id" class="col-sm-4 control-label" id="labelMemberName">이름</label>
							<div class="col-sm-8">
									<input type="text" class="form-control"  name="memberName" id="memberName"  
									value="${member.memberName }">
							</div>
						</div>
						<div class="form-group required" id="memberInfo">
							<label for="input-id" class="col-sm-4 control-label" id="labelMemberEmail">이메일</label>
							<div class="col-sm-8">
									<input type="text" class="form-control"  name="memberEmail" id="memberEmail" 
									value="${member.memberEmail } " readonly>
							</div>
						</div>
						<div class="form-group required" id="memberInfo">
							<label for="input-id" class="col-sm-4 control-label" id="labelMemberPhone" >핸드폰번호</label>
							<div class="col-sm-8">
									<input type="text" class="form-control"  name="memberPhone" id="memberPhone"  
									value="${member.memberPhone }" maxlength="11">
							</div>
						</div>
						<div class="form-group required" id="memberInfo">						
							<div class="col-sm-12">
									<input type="hidden" class="form-control"  name="memberNo" id="memberNo"  
									value="${member.memberNo }">
							</div>
						</div>
						<div class="form-group required" id="memberInfo">
							<div class="col-sm-4"></div>							
							<div class="col-sm-4">
									<input type="submit" class="form-control"  id="memberUpdate" name="memberUpdate"  
									value="수정하기">
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