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
			<li><a href="#">관리자페이지</a></li>
			<li><a href="#">상품 관리</a></li>
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
							<a class="list-group-item" href="#">입점문의 관리</a> 
							<a class="list-group-item" href="${path}/admin/manageProduct.do">상품 관리</a> 
							<a class="list-group-item" href="${path}/member/adminBrandCloseManage.do">브랜드 관리</a> 
							<a class="list-group-item" href="#">상품 판매 관리</a> 
							<a class="list-group-item" href="#">상품 재등록 관리</a>
						</div>
					</div>
				</div>
			</div>
			<!-- 정보 변경 전에 다시 비밀번호 확인 -->
			<div class="col-sm-9" id="content">
				<div class="row">
					<div class="col-sm-12">
						<table>
							<tr>
								<th>번호</th>
								<th>제목</th>
								<th>작성자</th>
								<th>작성일</th>
								<th>첨부파일</th>
								<th>조회수</th>
							</tr>
<%-- 							<c:forEach var="b" items="${list }">
								<tr>
									<td>${b.BOARDNO }</td>
									<td><a
										href="${path}/board/boardView.do?boardNo=${b.BOARDNO}">${b.BOARDTITLE }</a></td>
									<td>${b.BOARDWRITER }</td>
									<td>${b.BOARDDATE }</td>
									<td align="center"><c:if test="${b.ATTACHCOUNT>0 }">
											<img src="${path }/resources/images/file.png" width="16px" />
										</c:if></td>
									<td>${b.BOARDREADCOUNT }</td>
								</tr>
							</c:forEach> --%>
						</table>
						<%-- ${pageBar } --%>

					</div>
					<div class="col-sm-12">
						<div class="col-sm-9"></div>
						<div class="col-sm-3">
							<input type="button" class="btn btn-primary"
								onclick='location.href="${path}/admin/enrollProduct.do"'
								value="상품등록" />
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</section>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>