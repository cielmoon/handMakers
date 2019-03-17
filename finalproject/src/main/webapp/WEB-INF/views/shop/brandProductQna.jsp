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
.text-right{
	text-align: right;
}
</style>
<script>
	$(function(){
		//디데이 종료 일자 설정 
		var countDownDate = new Date('${product.PRODUCT_ENDDATE }').getTime(); 

		var x = setInterval(function() { 
			// 오늘 날짜 
			var now = new Date().getTime(); 
			// 종료일자에서 현재일자를 뺀 시간 
			var distance = countDownDate - now; 
	
			var d = Math.floor(distance / (1000 * 60 * 60 * 24)); 
			var h = Math.floor((distance % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
			
			document.getElementById("d-day").innerHTML = d +"일 " + h + "시간  남았습니다.";
		});
	});
	function qnaView(qnaNo, qnaWriter, qnaContent, qnaDate)
	{
		$("#btn-answer").text("작성");
		$("#input-content").val("");
		$("#state").val("insert");
		$("#commentRef").val(qnaNo);
		$("#qnaWriter").text(qnaWriter);
		$("#qnaContent").text(qnaContent);
		$("#qnaDate").text(qnaDate);
		
		$.ajax({
			url:"${path}/shop/selectProductQnaAnswer.do",
			data:{"refNo" : qnaNo},
			success:function(data){
				$("#input-content").val(data.answer['COMMENT_CONTENT']);
				$("#btn-answer").text("수정");
				$("#state").val("update");
			}
		});

		$('#answerModal').modal();
	}
	
	function answerSubmit()
	{
		var state = $("#state").val();	
		var answer = $('#input-content').val();
		if(answer.trim().length < 1)
		{
			$('#input-answer').focus();
		}else
		{
			$('#frm-answerModal').attr('action', "${path }/shop/productQnaAnswer.do?state=" + state);
			$('#frm-answerModal').submit();	
		}
	}
	
	//상품 특징 입력 글자수 제한
	$('#input-content').on('keyup', function() {
		if (this.value.length > 1000) {
			alert("답변은 최대 500자 까지만 입력해 주세요.");
			this.value = this.value.substring(0, 500);
			this.focus();
		}
	});

</script>
<section>
	<div class="container">
		<ul class="breadcrumb">
			<li><a href="${path }/index.jsp"><i
					class="fa fa-home"></i></a></li>
			<li><a href="${path }/member/myPage.do">마이페이지</a></li>
			<li><a href="${path }/shop/brandHome.do?brandNo=${brand.brandNo}">${brand.brandTitle}</a></li>
			<li><a href="${path }/shop/brandProductHome.do?productNo=${product.PRODUCT_NO }&brandNo=${brand.brandNo}">${product.PRODUCT_TITLE }</a></li>
		</ul>
		<br />
		<div class="row">
			<div class="col-sm-3 hidden-xs column-left" id="column-left">
				<div class="min-height-400">
					<div class="columnblock-title">${product.PRODUCT_TITLE }</div>
					<div class="account-block">
						<div class="list-group">
							<a class="list-group-item" href="${path }/shop/brandProductHome.do?productNo=${product.PRODUCT_NO }&brandNo=${brand.brandNo}">주문목록</a>						
							<a class="list-group-item" href="${path }/shop/brandProductQna.do?productNo=${product.PRODUCT_NO }&brandNo=${brand.brandNo}">문의관리</a>
						</div>
						<div id="list-group">
							<span id="d-day-title">판매종료&nbsp;<i class="fa fa-bell" style="font-size: 18px; color: gold;" aria-hidden="true"></i></span>
							<div id="d-day"></div>
						</div>
					</div>
				</div>
			</div>
			
			<div class="col-sm-9" id="content">
				<div class="row">
					<div class="col-sm-4">			
						<label>문의관리</label>
					</div>
					<div class="col-sm-3"></div>
					<div class="col-sm-5 float-right text-right">		
						<c:if test="${product.PRODUCT_CURSELL < product.PRODUCT_MIN}">
							<label>최소 주문수량 미달 <i class="fa fa-times" style="font-size:18px; color: firebrick;"></i></label>&nbsp;&nbsp;							
							<label>현재 ${product.PRODUCT_MIN - product.PRODUCT_CURSELL}개 남음</label>
						</c:if>
						<c:if test="${product.PRODUCT_CURSELL >= product.PRODUCT_MIN}">	
							<label>최소 주문수량 달성 <i class="fa fa-check" style="font-size:18px; color: lightgreen;"></i></label>&nbsp;&nbsp;	
							<label>현재 ${product.PRODUCT_CURSELL}개 주문중</label>
						</c:if>
					</div>
					<div class="col-sm-12 mt-10">					
						<table id='tbl-board' class='table table-striped table-hover'>
							<tr>
								<th>번호</th>
								<th>제목</th>
								<th>작성자</th>
								<th>작성일</th>
								<th>답변여부</th>					
							</tr>
							<c:if test="${qnaList.size()==0 }">
								<tr>
									<td colspan="6" style="text-align: center;">상품 문의가 없습니다.</td>
								</tr>
							</c:if>
 							<c:forEach var="q" items="${qnaList }" varStatus="vs">
								<tr>
									<td>${vs.count }</td>
									<td><a href="javascript:void(0);" onclick="qnaView('${q.COMMENT_NO}', '${q.MEMBER_ID}','${q.COMMENT_CONTENT }','<fmt:formatDate value="${q.COMMENT_DATE}" pattern="yyyy-MM-dd HH:mm"/>');">상품 문의입니다.</a></td>
									<td>${fn:replace(q.MEMBER_ID, fn:substring(q.MEMBER_ID, q.MEMBER_ID.length()-3, q.MEMBER_ID.length()), '***')}</td>
									<td><fmt:formatDate value="${q.COMMENT_DATE}" pattern="yyyy-MM-dd HH:mm"/></td>
									<td>
									<c:forEach var="a" items="${answerList }">
										<c:choose>
											<c:when test="${q.COMMENT_NO == a.COMMENT_REF}">완료</c:when>
										</c:choose>
									</c:forEach>
									</td>
								</tr>
							</c:forEach>
						</table>
					</div>
					<div class="col-sm-12 text-center">
						${pageBar }
					</div>
				</div>
			</div>
			
			<!-- 상품문의 답변  Modal -->
			<div class="modal fade" tabindex="-1" role="dialog" id="answerModal">
			  <div class="modal-dialog">
			    <div class="modal-content">
			      <div class="modal-header">
			        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
			        	<span aria-hidden="true">×</span>
			        </button>
			        <h4 class="modal-title" id="modalTitle" style="display: inline;">문의내용</h4>
			      </div>
			      <div class="modal-body">
			      	<div class="row">
						<div class="col-sm-6">
							<label class="control-label">작성자</label> 
							<span class="form-control" id="qnaWriter"></span>
						</div>
						<div class="col-sm-6">
							<label class="control-label">작성일</label> 
							<span class="form-control" id="qnaDate"></span>
						</div>
						<div class="col-sm-12">
							<label class="control-label">내용</label> 
							<span class="form-control" id="qnaContent" style="min-height: 100px;"></span>									
						</div>
	
					    <form name="answerFrm" id="frm-answerModal" method="post">
							<input type="hidden" name="commentRef" id="commentRef"/>
							<input type="hidden" name="sellerNo" id="sellerNo" value="${product.MEMBER_NO}"/>
							<input type="hidden" name="productNo" id="productNo" value="${product.PRODUCT_NO}"/>
							<input type="hidden" name="brandNo" id="brandNo" value="${brand.brandNo}"/>
							<input type="hidden" id="state"/>
							<div class="col-sm-12">
								<label class="control-label">답변</label> 
								<textarea class="form-control" id="input-content" name="content" rows="4" placeholder="답변을 입력해주세요." style="resize: none;"></textarea>									
							</div>
						</form>
				  	</div>
				  </div>
			      <div class="modal-footer"> 	
			      	<button type="button" id="btn-answer" class="btn btn-primary float-right" onclick="answerSubmit();">작성</button>     
			      </div>
			      
			    </div>
			  </div>
			</div>
			
		</div>
	</div>
</section>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>