<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath }" />
<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
<style>
#tbl-board{
	font-size: 11px;
}
.tBtn{
	font-size: 9px;
	background-color: black;
	color:white;
}
.tBtn:hover{
	background-color: gray;
	color:black;
}
</style>

<section>
	<div class="container">
		<ul class="breadcrumb">
			<li><a href="${path }"><i class="fa fa-home"></i></a></li>
			<li><a href="${path }/member/myPage.do">마이페이지</a></li>
			<li><a href="${path }/member/manageOrder.do">주문/배송내역 조회</a></li>
			
		</ul>
		<br />
		<div class="row">
			<div class="col-sm-3 hidden-xs column-left" id="column-left">
				<div class="column-block">
					<div class="columnblock-title">마이페이지</div>
					<div class="account-block">
						<div class="list-group">
							<a class="list-group-item" href="${path }/member/myPage.do">홈</a>
							<a class="list-group-item"
								href="${path }/member/checkPassword.do?checkNo=2">내정보 관리</a> <a
								class="list-group-item"
								href="${path }/member/checkPassword.do?checkNo=3">배송지 설정</a> <a
								class="list-group-item"
								href="${path }/member/checkPassword.do?checkNo=1">비밀번호 변경</a> <a
								class="list-group-item" href="${path }/member/manageOrder.do">주문/배송내역
								조회</a> <a class="list-group-item"
								href="${path }/member/checkPassword.do?checkNo=0">회원탈퇴</a>
						</div>
					</div>
				</div>

				<div class="column-block">
					<c:if test="${brandList.size() != 0}">
						<div class="columnblock-title">판매자페이지</div>
					</c:if>
					<div class="account-block">

						<div class="list-group">
							<c:forEach items="${brandList }" var="b">
								<c:if test="${b.brandState.toString()!='4'}">
									<a class="list-group-item brand-list"
										href="javascript:selectBrand('${b.brandNo }', '${b.brandState }');">${b.brandTitle }
										<c:if test="${b.brandState.toString()=='0'}">
											<i class="fa fa-clock-o"
												style="font-size: 20px; float: right;"></i>
										</c:if> <c:if test="${b.brandState.toString()=='2'}">
											<i class="fa fa-exclamation-circle"
												style="font-size: 20px; color: firebrick; float: right;"></i>
										</c:if>
									</a>
								</c:if>
							</c:forEach>
						</div>
					</div>
				</div>


			</div>
			<!-- 정보 변경 전에 다시 비밀번호 확인 -->
			<div class="col-sm-9">
				<div class="row">
					<div class="col-sm-12">

						<table id='tbl-board' class='table table-striped table-hover'>
							<tr>
								<th>주문번호</th>
								<th>상품명</th>
								<th>옵션</th>
								<th>수량</th>								
								<th>총금액</th>
								<th>주문날짜</th>
								<th>배송상태</th>
								<th>주문상태</th>
								<th></th>
								
							</tr>
 							<c:forEach var="o" items="${oList }">
								<tr>
									<td>${o.orderNo }</td>
									<td>${o.productName }</td>
									<td>${o.productOption }</td>
									<td>${o.productOptionQty }</td>
									<td>${o.orderTotalPrice }</td>
									<td>${o.orderDate }</td>
									<c:choose>
										<c:when test="${o.orderState == '0' }">
											<td>배송준비중</td>					
										</c:when>
										<c:when test="${o.orderState == '1' }">
											<td>배송중</td>					
										</c:when>	
										<c:when test="${o.orderState == '2' }">
											<td>배송완료</td>					
										</c:when>						
									</c:choose>									
									<c:choose>
										<c:when test="${o.orderPayState == '0' }">
											<td>결제완료</td>					
										</c:when>
										<c:when test="${o.orderPayState == '1' }">
											<td>결제취소요청</td>					
										</c:when>	
										<c:when test="${o.orderPayState == '2' }">
											<td>결제취소완료</td>					
										</c:when>
										<c:when test="${o.orderPayState == '3' }">
											<td>구매확정</td>					
										</c:when>
										<c:when test="${o.orderPayState == '4' }">
											<td>반품요청</td>					
										</c:when>	
										<c:when test="${o.orderPayState == '5' }">
											<td>반품완료</td>					
										</c:when>
										<c:when test="${o.orderPayState == '6' }">
											<td>교환요청</td>					
										</c:when>	
										<c:when test="${o.orderPayState == '7' }">
											<td>교환완료</td>					
										</c:when>							
									</c:choose>								
									<c:choose>
										<c:when test="${o.orderState == '0' }">
											<td><a href="${path}/member/changeOrderState.do?orderNo=${o.orderNo}+,1"><button class="tBtn">주문취소</button></a></td>					
										</c:when>
										<c:when test="${o.orderState == '1' }">
											<td><a href="${path}/member/changeOrderState.do?orderNo=${o.orderNo}+,3"><button class="tBtn">구매확정</button></a></td>					
										</c:when>	
										<c:when test="${o.orderState == '2' }">
											<td><a href="${path}/member/changeOrderState.do?orderNo=${o.orderNo}+,3"><button class="tBtn">구매확정</button></a>
											<a href="${path}/member/changeOrderState.do?orderNo=${o.orderNo}+,4"><button class="tBtn">반품요청</button></a>
											<a href="${path}/member/changeOrderState.do?orderNo=${o.orderNo}+,6"><button class="tBtn">교환요청</button></a></td>					
										</c:when>						
									</c:choose>
														
								</tr>
							</c:forEach>
						</table>
						${pageBar }
						 
					</div> 		

				</div>
			</div>
		</div>
	</div>
</section>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>