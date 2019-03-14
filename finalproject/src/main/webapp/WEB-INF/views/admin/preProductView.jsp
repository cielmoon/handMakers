<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath }" />

<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
<%-- <jsp:param value="" name="pageTitle"/> --%>


<section>
	<div class="container">
		<ul class="breadcrumb">
			<li><a href="${path }"><i class="fa fa-home"></i></a></li>
			<li><a href="${path}/admin/adminPage.do">관리자페이지</a></li>
			<li><a href="${path}/admin/managePreProduct.do">입점문의 관리</a></li>
			<li><a href="#">${preProduct.preProductTitle }</a></li>
		</ul>
		<br />
		<div class="row">
			<div class="col-sm-3 hidden-xs column-left" id="column-left">
				<div class="column-block">
					<div class="columnblock-title">관리자페이지</div>
					<div class="account-block">
						<div class="list-group">
							<a class="list-group-item" href="${path}/admin/adminPage.do">홈</a>
							<a class="list-group-item" href="#">공지사항 관리</a> <a
								class="list-group-item" href="#">메인배너 관리</a> <a
								class="list-group-item" href="${path}/admin/manageMember.do">회원
								관리</a> <a class="list-group-item"
								href="${path}/admin/manageBrand.do">브랜드 관리</a> <a
								class="list-group-item" href="${path}/admin/managePreProduct.do">입점문의
								관리</a> <a class="list-group-item"
								href="${path}/admin/manageProduct.do">상품 관리</a> <a
								class="list-group-item" href="${path}/admin/manageEndProduct.do">상품
								재등록 관리</a>
						</div>
					</div>
				</div>
			</div>
			<!-- 정보 변경 전에 다시 비밀번호 확인 -->
    		<div id="content" class="col-sm-9">
    			<div class="blog1 blog">
    				<h4 class="p-name">${preProduct.preProductTitle}</h4>
        			<ul class="blog-meta">
          				<li><i class="far fa-clock"></i><span class="dt-published">${preProduct.preProductDate }</span></li>            			
        			</ul>
        			<p class="p-summary"></p>
        			<p>${preProduct.preProductDiscript }</p>
       			</div>
			</div>

		</div>
	</div>
</section>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>