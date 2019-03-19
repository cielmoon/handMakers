<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath }" />
<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>

<style>
.inline {
	display: inline;
}
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

#input-productDiscript {
	min-height: 100px;
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

function deleteBrand()
{
	$.ajax({
		url:"${path}/shop/selectReqState.do",
		data:{"reqRef" : '${brand.brandNo}', "reqState": 'd'},
		success:function(data){
			var result = data.result;	
			if(result > 0)
			{
				alert("이미 요청 처리중 입니다.");
			}
			else
			{
				$("#modalTitle").text("폐점신고");
				$("#modalSubTitle").text("");
				$("#input-requestTitle").val("");
				$("#input-requestReason").val("");
				$("#input-requestType").val('B');
				$("#input-requestState").val('d');
				$("#input-requestRef").val('${brand.brandNo}');
				$("#input-requestLoc").val("/shop/brandHome.do?brandNo=");
				$("#frm-requestModal").attr("action", "${path}/shop/sellerRequest.do?brandNo=${brand.brandNo}");
				$("#requestModal").modal();
			}
		}
	});
}

function preProductView(preNo)
{
	$.ajax({
		url:"${path}/shop/preProductView.do",
		data:{"preNo" : preNo},
		success:function(data){
			var date = data.pre.preProductDate;
			var dateText = (date.year + 1900)  + "년" + (date.month + 1) + "월" + (date.date) + "일 " + date.hours + ":" + date.minutes;
			$("#input-productTitle").text(data.pre.preProductTitle);
			$("#input-productDate").text(dateText);
			$("#input-bcTitle").text(data.pre.bcTitle);
			$("#input-scTitle").text(data.pre.scTitle);
			$("#input-productDiscript").text(data.pre.preProductDiscript);
			
			var state = data.pre.preProductState;
			if(state == '0'){
				$("#input-productState").text("검토중");
				$("#input-productState").append("&nbsp; <i class='fa fa-clock-o' style='font-size:20px;'></i>");
			}else if(state == '1')
			{
				$("#input-productState").text("수락");
				$("#input-productState").append("&nbsp; <i class='fa fa-check-circle-o' style='font-size:20px; color:green;'></i>");
			}else
			{
				$("#input-productState").text("거절");
				$("#input-productState").append("&nbsp; <i class='fa fa-exclamation-circle' style='font-size:20px; color: firebrick; float: right;'></i>");
			}

			$("#preProductViewModal").modal();
			
		}
	}); 
	
}

</script>
<section>
	<div class="container">
		<ul class="breadcrumb">
			<li><a href="${path }/index.jsp"><i
					class="fa fa-home"></i></a></li>
			<li><a href="${path }/member/myPage.do">마이페이지</a></li>
			<li><a href="${path }/shop/brandHome.do?brandNo=${brand.brandNo}">${brand.brandTitle}</a></li>
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
							<div class="bottom-0">
							<a class="list-group-item inline" href="javascript:deleteBrand();">폐점신고&nbsp;<i class="fa fa-trash-o" style="font-size:24px;"></i></a>						
								<span id="brandState" class="list-group-item inline">
									<c:forEach items="${reqList }" var="r">
										<c:if test="${r.SELLER_REQ_REF == brand.brandNo && r.SELLER_REQ_PROCESS eq '0'}">(처리중)</c:if>
									</c:forEach>
								</span>
							</div>
						</div>
					</div>
				</div>
			</div>
			
			<div class="col-sm-9" id="content">
				<div class="row">
					<div class="col-sm-12">			
						<label>입점제안 목록</label>
					</div>
					<div class="tbl-header">
						<div class="col-sm-3">
							<select class="form-control" id="select-bigCategory">
								<option value="allList" selected>전체 카테고리</option>
								<c:forEach items="${bcList }" var="b" varStatus="vs">
										<option value="${b.bcNo }">${b.bcTitle}</option>
								</c:forEach>	
							</select>
						</div>
						<div class="col-sm-9">
							<button class="btn btn-primary float-right" onclick="location.href='${path}/shop/productEnroll.do?brandNo=${brand.brandNo }'">상품 제안하기</button>
						</div>
					</div>
					<div class="col-sm-12 mt-10">					
						<table id='tbl-board' class='table table-striped table-hover'>
							<tr>
								<th>번호</th>					
								<th>카테고리(대)</th>
								<th>카테고리(소)</th>								
								<th>상품명</th>
								<th>제안일</th>
								<th>상태</th>					
							</tr>
							<c:if test="${preList.size() == 0 }">
								<tr>
									<td colspan="6" style="text-align: center;">입점제안 상품이 없습니다.</td>
								</tr>
							</c:if>
 							<c:forEach var="p" items="${preList }" varStatus="vs">
								<tr>
									<td>${vs.count }</td>							
									<td>${p.bcTitle }</td>
									<td>${p.scTitle }</td>
									<td><a href="javascript:void(0);" onclick="preProductView('${p.preProductNo}');">${p.preProductTitle }</a></td>	
									<td><fmt:formatDate value="${p.preProductDate }" pattern="yyyy-MM-dd HH:mm"/></td>
									<td>${p.preProductState.toString()=='0'? "검토중" : p.preProductState.toString()=='1'? '수락' : '거절'}</td>
								</tr>
							</c:forEach>
						</table>
					</div>
					<div class="col-sm-12 text-center">
					<c:if test="${preList.size() != 0 }">
						${pageBar }
					</c:if>
					</div>
				</div>
			</div>
			
			<!-- 상품제안 상태 Modal -->
			<div class="modal fade" tabindex="-1" role="dialog" id="preProductViewModal">
			  <div class="modal-dialog">
			    <div class="modal-content">
			      <div class="modal-header">
			        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
			        	<span aria-hidden="true">×</span>
			        </button>
			        <h4 class="modal-title" id="modalTitle">상품제안 상세정보</h4>
			      </div>
			      <div class="modal-body" style="overflow: auto; height: 250px;">
					<div class="row">
						<div class="col-sm-6">
							<label class="control-label">상품명</label> 
							<span class="form-control" id="input-productTitle"></span>
						</div>
						<div class="col-sm-6">
							<label class="control-label">제안일</label> 
							<span class="form-control" id="input-productDate"></span>
						</div>
					</div>
					
					<label class="control-label">카테고리 </label>
					<div class="row">
						<div class="col-sm-6"><span class="form-control" id="input-bcTitle"></span></div>
						<div class="col-sm-6"><span class="form-control" id="input-scTitle"></span></div>
					</div>
					
					<div class="form-group">
						<label class="control-label">특징 소개 </label>
						<span class="form-control" id="input-productDiscript"></span>
					</div>
				  </div>
				  
			      <div class="modal-footer">
			      	<span id="input-productState" class="float-left"></span>
			      	<button type="button" class="btn btn-primary float-right" data-dismiss="modal" aria-label="Close">확인</button>      
			      </div>
			    </div>
			  </div>
			</div>
			
			<!-- 폐점신고  Modal -->
			<div class="modal fade" tabindex="-1" role="dialog" id="requestModal">
			  <div class="modal-dialog">
			    <div class="modal-content">
			      <form name="requestFrm" id="frm-requestModal" action="${path}/shop/sellerRequest.do?brandNo=${brand.brandNo}" method="post">
			      <div class="modal-header">
			        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
			        	<span aria-hidden="true">×</span>
			        </button>
			        <h4 class="modal-title" id="modalTitle">폐점신고</h4>
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
			      	<input type="hidden" name="requestRef" id="input-requestRef"/>
			      	<input type="hidden" name="requestType" id="input-requestType"/> 
			      	<input type="hidden" name="requestState" id="input-requestState"/>
			      	<input type="hidden" name="requestLoc" id="input-requestLoc"/>
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