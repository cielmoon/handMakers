<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>

<section>
	<div class="container">
		<ul class="breadcrumb">
			<li><a href="${pageContext.request.contextPath }"><i
					class="fa fa-home"></i></a></li>
			<li><a href="#">MyAccount</a></li>
			<li><a href="#">회원가입</a></li>
		</ul>
		<div class="row">
			<div class="col-sm-12" id="content">
				<div class="row">
					<div class="col-sm-3"></div>
					<div class="col-sm-6">
						<div class="well">
							<form name="memberEnrollFrm" action="${pageContext.request.contextPath}/member/memberEnrollEnd.do" method="post" onsubmit="return validate();" >
								<div class="form-group">
									<input type="text" class="form-control" id="memberId"
										placeholder="아이디 (4글자이상)" name="memberId">
								</div>
								<div class="form-group">
									<input type="password" class="form-control" id="memberPwd"
										placeholder="패스워드 (영문숫자포함 6글자이상)" value="" name="memberPwd">
								</div>
								<div class="form-group">
									<input type="password" class="form-control" id="memberPwdCheck"
										placeholder="패스워드 확인" value="" name="memberPwdCheck">
								</div>
								<div class="form-group">
									<input type="text" class="form-control" id="memberName"
										placeholder="이름" name="memberName">
								</div>
								<div class="form-group">
									<input type="text" class="form-control" id="memberBirth"
										placeholder="나이 (1~100사이 숫자만)" name="memberBirth">
								</div>
								<div class="form-group">
									<input type="text" class="form-control" id="memberEmail"
										placeholder="이메일" name="memberEmail">
								</div>
								<div class="form-group">
									<input type="text" class="form-control" id="memberPhone"
										placeholder="핸드폰번호 (-제외)" name="memberPhone">
								</div>
								<input type="submit" class="btn btn-primary" value="회원가입">
							</form>
						</div>
					</div>
					<div class="col-sm-3"></div>
				</div>
			</div>
		</div>
	</div>
</section>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>