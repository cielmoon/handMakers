<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath }" />
<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>

<style>
.bottom-0 {
	position: absolute;
	bottom: 0;
}

.min-height-400 {
	min-height: 400px;
}

.modal-dialog {
	z-index: 1050;
}

.modal-body {
	padding-top: 5px;
}

.float-left {
	float: left;
}

.float-right {
	float: right;
}

.mt-10 {
	margin-top: 10px;
}

.mt-0 {
	margin-top: 0px;
}
#input-requestReason {
	resize: none;
}
</style>

<script>
$(function(){
	$("#select-bigCategory").change(function(){
		var bcNo = $("#select-bigCategory").find(":selected").val();
		
		
	});
});

function stopSale(productNo, productTitle)
{
	$("#modalTitle").text("판매중단 요청");
	$("#modalSubTitle").text("(" + productTitle + ")");
	$("#input-requestTitle").val("");
	$("#input-requestReason").val("");
	$("#frm-requestModal").attr("action", "${path}/shop/sellerRequest.do?productNo=" + productNo);
	$("#requestModal").modal();
}

function deleteBrand()
{
	$("#modalTitle").text("폐점신고");
	$("#modalSubTitle").text("");
	$("#input-requestTitle").val("");
	$("#input-requestReason").val("");
	$("#frm-requestModal").attr("action", "${path}/shop/sellerRequest.do?brandNo=${brand.brandNo}");
	$("#requestModal").modal();
}
</script>

<section>
	<div class="container">
		<ul class="breadcrumb">
			<li><a href="${path }/index.jsp"><i
					class="fa fa-home"></i></a></li>
			<li><a href="${path }/member/myPage.do">마이페이지</a></li>
			<li><a href="${path }/shop/brandHome.do?brandNo=${brand.brandNo}">${brand.brandTitle}</a></li>
			<li><a href="${path }/shop/brandSaleProduct.do?brandNo=${brand.brandNo}">판매중</a></li>
		</ul>
		<br />
		<div class="row">
			<div class="col-sm-3 hidden-xs column-left" id="column-left">
				<div class="min-height-400">
					<div class="columnblock-title">${brand.brandTitle }</div>
					<div class="account-block">
						<div class="list-group">
							<a class="list-group-item" href="${path }/shop/brandHome.do?brandNo=${brand.brandNo}">입점제안</a>						
							<a class="list-group-item" href="${path }/shop/brandSaleProduct.do?brandNo=${brand.brandNo}">판매중</a>	
							<a class="list-group-item" href="${path }/shop/brandStopProduct.do?brandNo=${brand.brandNo}">판매중지</a>	
							<a class="list-group-item" href="${path }/shop/brandEndProduct.do?brandNo=${brand.brandNo}">판매종료</a>	
							<a class="list-group-item bottom-0" href="javascript:deleteBrand();">폐점신고&nbsp;<i class="fa fa-trash-o" style="font-size:24px;"></i>
							</a>	
						</div>
					</div>
				</div>
			</div>
			
			<div class="col-sm-9" id="content">
				<div class="row">
					<div class="col-sm-12">			
						<label>판매중</label>
					</div>
					<div class="col-sm-3">
						<select class="form-control" id="select-bigCategory">
							<option value="allList" selected>전체</option>
							<c:forEach items="${bcList }" var="b" varStatus="vs">
									<option value="${b.bcNo }">${b.bcTitle}</option>
							</c:forEach>	
						</select>
					</div>
					<div class="col-sm-6"></div>
					<div class="col-sm-3">
						<span class="float-right">(총 ${productList.size() }건의 상품)</span>				
					</div>
					<div class="col-sm-12">
						<div class="category-page-wrapper">
							<div class="col-md-6 list-grid-wrapper">
								<div class="btn-group btn-list-grid">
									<div id="grid-view" class="btn btn-default grid"></div>
								</div>
							</div>
						</div>
						<div class="grid-list-wrapper mt-0">
							<c:forEach items="${productList }" var="p">
								<div class="product-layout product-list col-xs-4">
									<div class="product-thumb">
										<div class="image product-imageblock">
											<a href="${path }/shop/brandProductHome.do?productNo=${p.PRODUCT_NO}&brandNo=${brand.brandNo}"> 
												<img src="${path }/resources/image/product/${p.PRODUCT_PROFILE}" class="img-responsive" />
											</a>
											<div class="button-group">
												<button type="button" class="wishlist" data-toggle="tooltip" title="판매중단 요청" onclick="stopSale('${p.PRODUCT_NO}','${p.PRODUCT_TITLE }');">
													<i class="fas fa-ban"></i>
												</button>
											</div>
										</div>
										<div class="caption product-detail">
											<h4 class="product-name">
												<a href="${path }/shop/brandProductHome.do?productNo=${p.PRODUCT_NO}&brandNo=${brand.brandNo}">${p.PRODUCT_TITLE }</a>
											</h4>
											<p>
												<span>${p.BC_TITLE}/${p.SC_TITLE}</span><br/>
												<span>마감일 <fmt:formatDate value="${p.PRODUCT_ENDDATE}" pattern="yyyy-MM-dd HH:mm"/></span>
											</p>
										</div>
									</div>
								</div>
							</c:forEach>	
						</div>
					</div>
					<div class="col-sm-12 text-center">
						${pageBar }
					</div>
				</div>
			</div>
			
			<!-- 폐점신고  Modal -->
			<div class="modal fade" tabindex="-1" role="dialog" id="requestModal">
			  <div class="modal-dialog">
			    <div class="modal-content">
			      <form name="requestFrm" id="frm-requestModal" method="post">
			      <div class="modal-header">
			        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
			        	<span aria-hidden="true">×</span>
			        </button>
			        <h4 class="modal-title" id="modalTitle" style="display: inline;"></h4>
			        <h4 class="modal-title" id="modalSubTitle" style="display: inline;"></h4>
			      </div>
			      <div class="modal-body" style="height: 250px;">
					<div class="form-group">
						<label class="control-label">제목</label> 
						<input type="text" class="form-control" id="input-requestTitle" name="requestTitle" maxlength="25" 
						placeholder="제목을 입력해주세요." required>										
					</div>
					<div class="form-group">
						<label class="control-label">사유</label> 
						<textarea class="form-control" id="input-requestReason" name="requestReason" rows="4" 
						placeholder="사유를 입력해주세요." required></textarea>
					</div>
				  </div>
			      <div class="modal-footer">
			      	<button type="button" class="btn btn-primary" data-dismiss="modal" aria-label="Close">취소</button>      
			      	<button type="submit" class="btn btn-primary float-right">완료</button>     
			      </div>
			      </form>
			    </div>
			  </div>
			</div>
			
		</div>
	</div>
</section>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>