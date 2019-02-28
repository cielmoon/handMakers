<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>

<section>
	<div class="container">
		<ul class="breadcrumb">
			<li><a href="${pageContext.request.contextPath }"><i class="fa fa-home"></i></a></li>
			<li><a href="#">MyAccount</a></li>
			<li><a href="#">로그인</a></li>
		</ul>
		<div class="row">
			<div class="col-sm-12" id="content">
				<div class="row">
					<div class="col-sm-3"></div>
					<div class="col-sm-6">
						<div class="well">						
							<form ename="memberLoginFrm" action="${pageContext.request.contextPath}/member/memberLoginEnd.do" method="post" onsubmit="return validate();" >
								<div class="form-group">							
									<input type="text" class="form-control" id="memberId" placeholder="아이디" name="memberId">
								</div>
								<div class="form-group">							
									<input type="password" class="form-control" id="memberPwd" placeholder="패스워드" value="" name="memberPwd"> 
									<a href="#">아이디 찾기</a>	
									<a> / </a>								
									<a href="#">비밀번호 찾기</a>
								</div>
								<input type="submit" class="btn btn-primary" value="로그인">
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