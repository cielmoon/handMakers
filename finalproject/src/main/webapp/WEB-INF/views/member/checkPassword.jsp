<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath }" />
<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
<style>
#memberPwd, #pwdCheck{
	margin-bottom: 10px;
	margin-top: 10px;	
}

#labelMemberPwd {
	margin-top: 20px;
}
</style>
<section>
	<div class="container">
		<ul class="breadcrumb">
			<li><a href="${path }"><i class="fa fa-home"></i></a></li>
			<li><a href="${path}/member/myPage.do">마이페이지</a></li>
			<li><a href="#">비밀번호 확인</a></li>
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
					<form name="memberUpdateFrm" action="${path}/member/checkPasswordEnd.do?checkNo=${checkNo}" method="post" onsubmit="return validate();">
						<div class="form-group required" id="memberInfo">
					 		<h1 class="col-sm-3"></h1>
							<h1 class="col-sm-6">비밀번호 확인하기</h1>
							<h1 class="col-sm-3"></h1>
				
						</div>
						<div class="form-group required" id="memberInfo">							
							<div class="col-sm-12">
									<input type="hidden" class="form-control"  name="memberId" id="memberId" value="${member.memberId }" >
							</div>
						</div>	
						<div class="form-group required" id="memberInfo">
							<label for="input-id" class="col-sm-4 control-label" id="labelMemberPwd">비밀번호</label>
							<div class="col-sm-8">
									<input type="password" class="form-control"  name="memberPwd" id="memberPwd" >
							</div>
						</div>
			
						<div class="form-group required" id="memberInfo">
							<div class="col-sm-4"></div>							
							<div class="col-sm-4">
								<input type="submit" class="form-control"  id="pwdCheck" name="pwdCheck" value="확인하기">
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