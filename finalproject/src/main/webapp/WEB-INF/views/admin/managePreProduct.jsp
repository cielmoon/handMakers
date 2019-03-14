<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath }" />

<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
<%-- <jsp:param value="" name="pageTitle"/> --%>
<<script >

$(function(){
	$("#select-bigCategory").change(function(){
		var bcNo = $("#select-bigCategory").find(":selected").val();
		/* 소카테고리 리스트 초기화  */
		$("#select-smallCategory")[0].options.length = 0;
		$.ajax({
			url:"${path}/admin/managePreProduct.do",
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
				//카테고리(소) 누르면 (소)를 가지고 있는 브랜드가 나옴
				var scNo = $("#select-smallCategory").find(":selected").val();
				/* 브랜드 리스트 초기화 */
				$("#select-brand")[0].options.length = 0;
				$.ajax({
					url:"${path}/admin/managePreProduct.do",
					data:{"scNo" : scNo},
					success:function(data){
						for(var i=0; i<data.brandList.length; i++)
						{
							$('#select-brand').append($('<option>',							{
						        value: data.brandList[i]['brandNo'],
						        text : data.brandList[i]['brandTitle']
						    }));
						}
					}
				});				
				
				
			}			
			
		});
	});	

});
</script>



<section>
	<div class="container">
		<ul class="breadcrumb">
			<li><a href="${path }"><i class="fa fa-home"></i></a></li>
			<li><a href="${path}/admin/adminPage.do">관리자페이지</a></li>
			<li><a href="${path}/admin/managePreProduct.do">입점문의 관리</a></li>
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
			<div class="col-sm-9" id="content">
				<div class="row">
					<div class="col-sm-12">
						<label class="control-label">카테고리 *</label>
<%-- 						<div class="row">
							<div class="col-sm-6">
								<select class="form-control" id="select-bigCategory" name="bcNo"
									required>
									<c:forEach items="${bcList }" var="b" varStatus="vs">
										<option ${vs.count==1? "selected" : ""} value="${b.bcNo }">${b.bcTitle}</option>
									</c:forEach>
								</select>
							</div>

							<div class="col-sm-6">
								<select class="form-control" id="select-smallCategory" name="scNo" required>
									<c:forEach items="${scList }" var="s" varStatus="vs">
										<option ${vs.count==1? "selected" : ""} value="${s.scNo }">${s.scTitle}</option>
									</c:forEach>
								</select>
							</div>
							
							<div class="col-sm-6">
								<select class="form-control" id="select-brand" name="brandNo" required>
									<c:forEach items="${brandList }" var="brand" varStatus="vs">
										<option ${vs.count==1? "selected" : ""} value="${brand.brandNo }">${brand.brandTitle}</option>
									</c:forEach>
								</select>
							</div>
						</div> --%>
						<table id='tbl-board' class='table table-striped table-hover'>
							<tr>
								<th>카테고리(대)</th>
								<th>카테고리(소)</th>								
								<th>제안 상품명</th>
								<th>브랜드명</th>
								<th>입점상태</th>
								<th>등록날짜</th>
								<th>요청관리</th>
							</tr>
							<c:forEach var="p" items="${preProductList }">
								<tr>
									<td>${p.preProductBcTitle }</td>
									<td>${p.preProductScTitle }</td>											
									<td><a href="${path}/admin/preProductView.do?preProductNo=${p.preProductNo}">${p.preProductTitle }</a></td>
									<td>${p.preProductBrandTitle }</td>		
									<c:choose>
										<c:when test="${p.preProductState.toString() == '1' }">
											<td>수락</td>
										</c:when>
										<c:when test="${p.preProductState.toString() == '2' }">
											<td>거절</td>
										</c:when>
										<c:otherwise>
											<td>검토</td>
										</c:otherwise>
									</c:choose>									
									<td>${p.preProductDate }</td>
									<c:choose>
										<c:when test="${p.preProductState.toString() == '1' }">
											<td><a
												href="${path}/admin/changePreProductState.do?preProductNo=${p.preProductNo}+,0"><button
														class="AgreeBtn">수락취소</button></a></td>
										</c:when>
										<c:when test="${p.preProductState.toString() == '2' }">
											<td><a
												href="${path}/admin/changePreProductState.do?preProductNo=${p.preProductNo}+,0"><button
														class="AgreeBtn">거절취소</button></a></td>
										</c:when>
										<c:otherwise>
											<td><a
												href="${path}/admin/changePreProductState.do?preProductNo=${p.preProductNo}+,1"><button
														class="AgreeBtn">수락</button></a> <a
												href="${path}/admin/changePreProductState.do?preProductNo=${p.preProductNo}+,2"><button
														class="AgreeBtn">거절</button></a></td>
										</c:otherwise>
									</c:choose>
									
<%-- 								<c:choose>
										<c:when test="${b.brandState.toString() == '1' }">
											<td>승인</td>
										</c:when>
										<c:when test="${b.brandState.toString() == '2' }">
											<td>반려</td>
										</c:when>
										<c:otherwise>
											<td>승인요청</td>
										</c:otherwise>
									</c:choose>

									<td>${b.brandEnrollDate}</td>
									<c:choose>
										<c:when test="${b.brandState.toString() == '1' }">
											<td><a
												href="${path}/admin/changeBrandState.do?brandNo=${b.brandNo}+,0"><button
														class="AgreeBtn">승인취소</button></a></td>
										</c:when>
										<c:when test="${b.brandState.toString() == '2' }">
											<td><a
												href="${path}/admin/changeBrandState.do?brandNo=${b.brandNo}+,0"><button
														class="AgreeBtn">반려취소</button></a></td>
										</c:when>
										<c:otherwise>
											<td><a
												href="${path}/admin/changeBrandState.do?brandNo=${b.brandNo}+,1"><button
														class="AgreeBtn">승인</button></a> <a
												href="${path}/admin/changeBrandState.do?brandNo=${b.brandNo}+,2"><button
														class="AgreeBtn">반려</button></a></td>
										</c:otherwise>
									</c:choose> --%>
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