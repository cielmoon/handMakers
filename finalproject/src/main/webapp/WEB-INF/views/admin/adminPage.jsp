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
			<li><a href="${path }"><i class="fa fa-home"></i></a></li>
			<li><a href="#">관리자페이지</a></li>
		</ul>
		<br />
		<div class="row">
		
		
			<div class="col-sm-3 hidden-xs column-left" id="column-left">
				<div class="column-block">
					<div class="columnblock-title">관리자페이지</div>
					<div class="account-block">
						<div class="list-group">
							<a class="list-group-item" href="#">홈</a> 
							<a class="list-group-item" href="#">공지사항 관리</a>
							<a class="list-group-item" href="#">메인배너 관리</a>
							<a class="list-group-item" href="#">회원 관리</a>	
							<a class="list-group-item" href="${path}/admin/adminBrandCloseManage.do">브랜드 관리</a>			
							<a class="list-group-item" href="#">입점문의 관리</a>	
							<a class="list-group-item" href="${path}/admin/manageProduct.do">상품 관리</a>						
							<!-- <a class="list-group-item" href="#">상품 판매 관리</a> -->
							<a class="list-group-item" href="#">상품 재등록 관리</a>		
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
						<div class="well">
							<div>
								<h2>관리자 프로필</h2>
								<!-- 라운드로 꾸며야함 style로 -->
								<div class="well">
									<%-- <a href="<%=request.getContextPath()%>/memberProfileChange"> --%>
									<a href="#" onclick="return false;"> 
										<img src="${path }/resources/image/profile/admin.png" width="100" height="100" style="border-radius: 50%;"onclick="fileUpload()" />
									
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