<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath }" />
<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>

<script>
$(function() {
	$("#select-brand").change(function(){
		/* brandNo를 찾아서 이걸 가져가서 상품들을 해당 브랜드로 페이징 처리  */
		
		
		/* console.log("brandNo :"+brandNo);
		console.log("bcNo :"+bcNo);
		console.log("scNo :"+scNo); */
		
		manageProductAjax(1);
	});
	
	$("#select-smallCategory").change(function(){
		/* brandNo를 찾아서 이걸 가져가서 상품들을 해당 브랜드로 페이징 처리  */
		
		
		/* console.log("brandNo :"+brandNo);
		console.log("bcNo :"+bcNo);
		console.log("scNo :"+scNo); */
		
		manageProductAjax(1);
	});
	
	$("#select-bigCategory").change(function(){
		var bcNo = $("#select-bigCategory").find(":selected").val();
		/* 소카테고리 리스트 초기화  */
		$("#select-smallCategory")[0].options.length = 0;
		
		$.ajax({
			//${path}/admin/productEnrollB randSet.do
			url:"${path}/admin/productEnrollScSet.do",
			data:{"bcNo" : bcNo},
			success:function(data){
				for(var i=0; i<data.scList.length; i++)
				{
					$('#select-smallCategory').append($('<option>',
					{
				        value: data.scList[i]['scNo'],
				        text : data.scList[i]['scTitle']
				    }));
				}
				
				manageProductAjax(1);
				
			}
		});
	});
});

function manageProductAjax(cPage) {
	var brandNo = $("#select-brand").find(":selected").val();
	var bcNo = $("#select-bigCategory").find(":selected").val();
	var scNo = $("#select-smallCategory").find(":selected").val();
	console.log("scNo:" + scNo);
	var productState = "";
	var today = new Date();
	/* var productPageBar = $("#productPageBar").val(); */
	console.log("cPage : " + cPage);
	/* 빅카테고리, 소카테고리 리스트 초기화  */
	$.ajax({
		//${path}/admin/productEnrollB randSet.do
		url:"${path}/admin/selectRList.do",
		data:{"brandNo" : brandNo, "bcNo" : bcNo, "scNo" : scNo, "cPage": cPage},
		success:function(data){
			console.log(data);
			console.log(data.proc);
			var tr1 = $('<tr><th>카테고리(대)</th><th>카테고리(소)</th><th>상품명</th><th>브랜드명</th><th>상품상태</th><th>등록날짜</th><th>마감날짜</th><th></th></tr>	');
			var table = $('<table id="tbl-board" class="table table-striped table-hover"></table>');
			table.append(tr1);
			for(var i=0;i<data.proc.length;i++){
				if(data.proc[i].productState == '2'){
					productState = "판매중지";
				}else if(data.proc[i].productState == '3'){
					productState ="판매완료";
				}else if(data.proc[i].productState == '1'){
					productState ="판매중지요청";
				}
				
				/* console.log(data.adminProductList[i]); */
				var tr2 = $("<tr><th>" + data.proc[i].productBcTitle + "</th><th>" + data.proc[i].productScTitle + "</th><th>" + data.proc[i].productTitle + "</th><th>" + data.proc[i].productBrandTitle + "</th><th>" + productState + "</th><th>" + data.proc[i].updateDate + "</th><th>" + data.proc[i].productEndDate + "</th><th></th></tr>");
				
				
				
				table.append(tr2);
			}
			
			$("#oriProductListTable").html(table);
			$("#pagingcontainer").html(data.page);
		}
	});
}
</script>

<section>
	<div class="container">
		<ul class="breadcrumb">
			<li><a href="${path }"><i class="fa fa-home"></i></a></li>
			<li><a href="${path}/admin/adminPage.do">관리자페이지</a></li>
			<li><a href="${path}/admin/manageProduct.do">상품 종료/중지 목록</a></li>
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
					<div class="col-sm-3">
						<select class="form-control" id="select-brand" name="brandNo" required>
							<c:forEach items="${brandList }" var="b" varStatus="vs">
								<option ${vs.count==1? "selected" : ""} value="${b.brandNo }">${b.brandTitle}</option>
							</c:forEach>
						</select>
						</div>			
						<div class="col-sm-3">
						<select class="form-control" id="select-bigCategory" name="bcNo" required>
							<c:forEach items="${bcList }" var="b" varStatus="vs">
								<option ${vs.count==1? "selected" : ""} value="${b.bcNo }">${b.bcTitle}</option>
							</c:forEach>	
						</select>
						</div>
						<div class="col-sm-3">
						<select class="form-control" id="select-smallCategory" name="scNo" required>
							<c:forEach items="${scList }" var="s" varStatus="vs">
								<option ${vs.count==1? "selected" : ""} value="${s.scNo }">${s.scTitle}</option>
							</c:forEach>
						</select>
						</div>
						<div class="col-sm-3">
						</div>
					
					
					<div class="col-sm-12" id="oriProductListTable">				
						<table id='tbl-board' class='table table-striped table-hover'>
							<tr>
								<th>카테고리(대)</th>
								<th>카테고리(소)</th>								
								<th>상품명</th>
								<th>브랜드명</th>
								<th>상품상태</th>
								<th>등록날짜</th>
								<th>마감날짜</th>	
								<th></th>								
							</tr>
 							<c:forEach var="a" items="${adminProductList }">
 								<tr>
									<td>${a.productBcTitle }</td>
									<td>${a.productScTitle }</td>
									<td>${a.productTitle }</td>	
									<td>${a.productBrandTitle }</td>
									<c:choose>
										<c:when test="${a.productState == '1' }">
											<td>판매중지요청</td>
										</c:when>
										<c:when test="${a.productState == '2' }">
											<td>판매중지</td>
										</c:when>
										<c:when test="${a.productState == '3' }">
											<td>판매완료</td>
										</c:when>
							
									</c:choose>		
									<td>${a.updateDate }</td>	
									<td>${a.productEndDate }</td>
									<td></td>
							
															
											
								</tr>
							</c:forEach>
						</table>
						</div>
						
   					<div class="col-sm-12">
						<div class="col-sm-9">	
							<div id="pagingcontainer">
								${pageBar }
							</div>
						</div>
					
					</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</section>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>