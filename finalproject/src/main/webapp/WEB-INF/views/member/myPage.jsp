<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath }" />
<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>

<section>
	<div class="container">
		<ul class="breadcrumb">
			<li><a href="<%=request.getContextPath()%>/index.jsp"><i
					class="fa fa-home"></i></a></li>
			<li><a href="<%=request.getContextPath()%>/memberMyPage">마이페이지</a></li>
		</ul>
		<br />
		<div class="row">
			<div class="col-sm-3 hidden-xs column-left" id="column-left">
				<div class="column-block">
					<div class="columnblock-title">마이페이지</div>
					<div class="account-block">
						<div class="list-group">
							<a class="list-group-item" href="#">홈</a> 
							<a class="list-group-item" href="#">내정보 관리</a>
							<a class="list-group-item" href="#">배송지 설정</a>				
							<a class="list-group-item" href="#">비밀번호 변경</a> 
							<a class="list-group-item" href="#">주문/배송내역 조회</a>			
							<a class="list-group-item" href="#">회원탈퇴</a>
						</div>
					</div>
				</div>
				
				<div class="column-block">
					<div class="columnblock-title">판매자페이지</div>
					<div class="account-block">
						<div class="list-group">
							<a class="list-group-item" href="#">홈</a> 
							<a class="list-group-item" href="#">내정보 관리</a>
							<a class="list-group-item" href="#">배송지 설정</a>				
							<a class="list-group-item" href="#">비밀번호 변경</a> 
							<a class="list-group-item" href="#">주문/배송내역 조회</a>			
							<a class="list-group-item" href="#">회원탈퇴</a>
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
						<div class="well">
							<div>
								<h2>프로필</h2>
								<!-- 라운드로 꾸며야함 style로 -->
								<div class="well">
									<%-- <a href="<%=request.getContextPath()%>/memberProfileChange"> --%>
									<a href="#" onclick="return false;"> 
										<img src="${path }/resources/image/profile/default.png" width="100" height="100" style="border-radius: 50%;"onclick="fileUpload()" />
									
									</a>


								</div>
							</div>
							<div>
								<input type="button" class="btn btn-primary" value="변경" onclick="fileUpload()">
<%-- 
								<form action="<%=request.getContextPath()%>/FileUpload"
									method="post" enctype="multipart/form-data" id="fileUploadForm">
									<input type="file" class="btn btn-primary" id="file"
										name="file" style="display: none;">

								</form> --%>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</section>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>