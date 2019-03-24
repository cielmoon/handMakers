<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath }" />
<style>
#srBtn{
	margin-bottom: 13px;
	background-color: black;
	color:white;
}
#srBtn:hover{
	background-color: gray;
	color:black;
}
</style>
<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
<%-- <jsp:param value="" name="pageTitle"/> --%>
<section>
	<div class="container">
		<ul class="breadcrumb">
			<li><a href="${path }"><i class="fa fa-home"></i></a></li>
			<li><a href="${path}/admin/adminPage.do">관리자페이지</a></li>
			<li><a href="${path}/admin/manageRequest.do">폐점신고 및 상품 판매중지 요청</a></li>
		</ul>
		<br />
		<div class="row">
			<div class="col-sm-3 hidden-xs column-left" id="column-left">
				<div class="column-block">
					<div class="columnblock-title">관리자페이지</div>
					<div class="account-block">
						<div class="list-group">
							<a class="list-group-item" href="${path}/admin/adminPage.do">홈</a>					
							<a class="list-group-item" href="${path}/admin/memberList.do">회원목록</a>
							<a class="list-group-item"	href="${path}/admin/manageBrand.do">브랜드 등록관리</a>							
							<a class="list-group-item" href="${path}/admin/managePreProduct.do">입점 제안관리</a>
							<a class="list-group-item" href="${path}/admin/manageProduct.do">상품 등록/수정 관리</a>												 
							<a class="list-group-item" href="${path}/admin/manageReProduct.do">상품 종료/중지 목록</a>
							<a class="list-group-item"	href="${path}/admin/manageRequest.do">폐점신고/상품 판매중지 요청</a>					 
						</div>
					</div>
				</div>
			</div>
			<!-- 정보 변경 전에 다시 비밀번호 확인 -->
			<div class="col-sm-9" id="content">
				<div class="row">
					<div class="col-sm-12">	
						<input type="button" class="btn btn-primary" id="srBtn" onclick='location.href="${path}/admin/manageRequest.do?sellerReqState="+"B"' value="브랜드" />		
						<input type="button" class="btn btn-primary" id="srBtn" onclick='location.href="${path}/admin/manageRequest.do?sellerReqState="+"P"' value="상품" />			
						<table id='tbl-board' class='table table-striped table-hover'>
							<tr>
								<th>요청번호</th>
								<th>요청(브랜드/상품)</th>
								<th>요청제목</th>
								<th>발신자</th>								
								<th>요청상태</th>
								<th>처리상태</th>
								<th>요청일</th>
								<th></th>								
							</tr>
 							<c:forEach var="r" items="${requestList }"> 								
								<tr>
								<c:choose>
									<c:when test="${r.sellerReqType == 'B' }">
										<td>${r.sellerReqNo }</td>
										<td>${r.sellerReqRef }</td>
										<td>${r.sellerReqTitle }</td>
										<td>${r.memberId }</td>
										<c:choose>
											<c:when test="${r.sellerReqState == 'd' }">
												<td>폐점신고요청</td>		
											</c:when>
											<c:when test="${r.sellerReqState == 'e' }">
												<td>폐점완료</td>											
											</c:when>		
											<c:when test="${r.sellerReqState == 'f' }">
												<td>폐점반려</td>											
											</c:when>												
										</c:choose>	
										<c:choose>
											<c:when test="${r.sellerReqProcess == '0' }">
												<td>처리중</td>		
											</c:when>
											<c:when test="${r.sellerReqProcess == '1' }">
												<td>수락</td>											
											</c:when>	
											<c:when test="${r.sellerReqProcess == '2' }">
												<td>반려</td>											
											</c:when>													
										</c:choose>
										<td>${r.sellerReqDate }</td>
										<c:choose>
											<c:when test="${r.sellerReqProcess == '0' }">
												<td><a href="${path}/admin/changeReqProcess.do?sellerReqNo=${r.sellerReqNo}+,1,e,+${r.sellerReqType}+,+${r.sellerReqRef}"><button class="AgreeBtn">수락</button></a>
												<a href="${path}/admin/changeReqProcess.do?sellerReqNo=${r.sellerReqNo}+,2,f,+${r.sellerReqType}+,+${r.sellerReqRef}"><button class="AgreeBtn">반려</button></a></td>					
											</c:when>						
										</c:choose>										
									</c:when>
									<c:when test="${r.sellerReqType == 'P' }">
										<td>${r.sellerReqNo }</td>
										<td>${r.sellerReqRef }</td>
										<td>${r.sellerReqTitle }</td>
										<td>${r.memberId }</td>
										<c:choose>
											<c:when test="${r.sellerReqState == '4' }">
												<td>재판매요청</td>		
											</c:when>
											<c:when test="${r.sellerReqState == '0' }">
												<td>정상등록</td>											
											</c:when>
											<c:when test="${r.sellerReqState == '1' }">
												<td>판매중단요청</td>		
											</c:when>
											<c:when test="${r.sellerReqState == '2' }">
												<td>판매중지</td>											
											</c:when>	
											<c:when test="${r.sellerReqState == '3' }">
												<td>판매종료</td>											
											</c:when>														
										</c:choose>	
										<c:choose>
											<c:when test="${r.sellerReqProcess == '0' }">
												<td>처리중</td>		
											</c:when>
											<c:when test="${r.sellerReqProcess == '1' }">
												<td>수락</td>											
											</c:when>	
											<c:when test="${r.sellerReqProcess == '2' }">
												<td>반려</td>											
											</c:when>													
										</c:choose>
										<td>${r.sellerReqDate }</td>
 										<c:choose>
											<c:when test="${r.sellerReqProcess == '0' and r.sellerReqState == '4'}">												
													<td><a href="${path}/admin/changeReqProcess.do?sellerReqNo=${r.sellerReqNo}+,1,0,+${r.sellerReqType}+,+${r.sellerReqRef}"><button class="AgreeBtn">수락</button></a>
													<a href="${path}/admin/changeReqProcess.do?sellerReqNo=${r.sellerReqNo}+,2,2,+${r.sellerReqType}+,+${r.sellerReqRef}"><button class="AgreeBtn">반려</button></a></td>	
															
											</c:when>
											<c:when test="${r.sellerReqProcess == '0' and r.sellerReqState == '1'}">											
													<td><a href="${path}/admin/changeReqProcess.do?sellerReqNo=${r.sellerReqNo}+,1,3,+${r.sellerReqType}+,+${r.sellerReqRef}"><button class="AgreeBtn">수락</button></a>
													<a href="${path}/admin/changeReqProcess.do?sellerReqNo=${r.sellerReqNo}+,2,0,+${r.sellerReqType}+,+${r.sellerReqRef}"><button class="AgreeBtn">반려</button></a></td>		
																
											</c:when>
											<c:otherwise>
											<td></td>
											</c:otherwise>								
										</c:choose>								
									</c:when>
								
								</c:choose>		

								</tr>
							</c:forEach>
						</table>
						${pageBar }
					</div>
<%-- 					<div class="col-sm-12">
						<div class="col-sm-9"></div>
						<div class="col-sm-3">
							<input type="button" class="btn btn-primary"
								onclick='location.href="${path}/admin/enrollProduct.do"'
								value="상품등록" />
						</div>
					</div> --%>
				</div>
			</div>
			
			
		</div>
	</div>
</section>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>