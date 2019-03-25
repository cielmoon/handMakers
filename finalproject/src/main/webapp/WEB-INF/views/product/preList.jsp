<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath }" />
<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
<%-- <jsp:param value="handMakers - 신규" name="pageTitle"/> --%>
<section>
<div class="container">
  <ul class="breadcrumb">
    <li><a href="${path }"><i class="fa fa-home"></i></a></li>
    <li><a href="${path }/product/preList.do">입점예정</a></li>
  </ul>
  <div class="row">
  <c:if test="${productList.size() != 0 }">
    <div id="content" class="col-sm-12">    

<div class="category-page-wrapper">
					<div class="col-md-6 list-grid-wrapper">
						<div class="btn-group btn-list-grid">
							<div class="result-inner">(총 ${contentCount }건의 상품)</div>
							<div id="grid-view" class="btn btn-default grid"></div>
						</div>
					</div>
					
					
					<div class="col-md-1 text-right page-wrapper">
          <label class="control-label" for="input-limit">Show :</label>
          <div class="limit">
          <form name="numPerPagesFrm" id="numPerPagesFrm" action = "${path }/product/preList.do">
            <select id="input-limit" name="numPerPage" class="form-control">
            <c:set var="numper" value="${numPerPage }" />
			<c:choose>
    		<c:when test="${numper eq '16'}">
        	<option value="8">8</option><!-- selected="selected" -->
              <option value="16" selected="selected">16</option>
              <option value="24">24</option>
              <option value="32">32</option>
    		</c:when>
    		<c:when test="${numper eq '24'}">
        	<option value="8">8</option><!-- selected="selected" -->
              <option value="16">16</option>
              <option value="24" selected="selected">24</option>
              <option value="32">32</option>
    		</c:when>
    		<c:when test="${numper eq '32'}">
        	<option value="8">8</option><!-- selected="selected" -->
              <option value="16">16</option>
              <option value="24">24</option>
              <option value="32" selected="selected">32</option>
    		</c:when>
    		<c:otherwise>
       		<option value="8" selected="selected">8</option>
              <option value="16">16</option>
              <option value="24">24</option>
              <option value="32">32</option>
    		</c:otherwise>
			</c:choose>
            
            </select>
          </form>
          </div>
        </div>
					
				</div>
            <div class="grid-list-wrapper">
      <c:forEach items="${productList }" var="product" varStatus="vs">
      
	<div class="product-layout product-list col-xs-12">
          <div class="product-thumb">

									<div
										onclick="location.href='${path }/product/productView.do?productNo=${product.productNo}'"
										class="image product-imageblock"
										style="height : 220px; background-size : cover; background-image : url(${path}/resources/image/product/${product.productProfile }); cursor : pointer;">
										<%--  <a href="${path }/product/productView.do?productNo=${product.productNo}"> --%>
										<!-- 상품상세페이지 ? product_no  -->
										<!-- </a> -->
										<!-- <div class="image product-imageblock" style="height:220px;"> -->
										<%-- <img src="${path}/resources/image/product/${product.productProfile }" alt="${product.productTitle }" title="${product.productTitle }" class="img-responsive" /> --%>
										<!-- </a> -->
										<%-- <img src="${path}/resources/image/product/${product.productProfile }" alt="${product.productTitle }" title="${product.productTitle }" class="img-responsive" /></a> --%>
										<div class="button-group">
											<c:if test="${member==null }">
												<button type="button" id="${product.productNo}"
													data-toggle="tooltip" class="btn btn-default wishlist"
													title="Wish List" value="${product.productNo}"
													onclick="fn_wishLoginChk();">
													<i class="fa fa-heart-o"></i>
												</button>
											</c:if>
											<c:if
												test="${member.memberNo != null and product.wishChk eq member.memberNo }">
												<button type="button" id="${product.productNo}"
													data-toggle="tooltip" class="btn btn-default wishlist"
													title="Wish List" value="${product.productNo}"
													onclick="fn_wishChk(this.value);">
													<i class="fa fa-heart"></i>
												</button>
											</c:if>
											<c:if
												test="${member.memberNo != null and product.wishChk eq null }">
												<button type="button" id="${product.productNo}"
													data-toggle="tooltip" class="btn btn-default wishlist"
													title="Wish List" value="${product.productNo}"
													onclick="fn_wishChk(this.value);">
													<i class="fa fa-heart-o"></i>
												</button>
											</c:if>


											<!-- <button type="button" class="addtocart-btn">Add to Cart</button> -->
										</div>
									</div>

									<div class="caption product-detail">
              <h4 class="product-name ellips">
              <a href="${path }/product/productView.do?productNo=${product.productNo}" title="${product.productTitle }"> ${product.productTitle } </a> </h4>
              <div style="width : 200px; height : 24px;" class="rating ellips">
                                    ${product.productComment }
                                    </div>
              <!-- 상품상세페이지 링크 , title=product_title , value = product_title -->
              <%-- <div class="product-desc">${product.productComment }</div> --%>
                <!-- product_comment -->
              <%-- <p class="price product-price"><span class="price-old"></span> ${product.productPrice } <span class="price-tax"></span> </p> --%><!-- 원본 -->
              <%-- <p class="price product-price"><span class="price-old">${product.productPrice }</span> ${product.productPrice + product.productDiscount } <span class="price-tax"></span> </p> --%>
              <div style="width : 200px; height : 24px;" class="price product-price">
              <span class="price-old"><fmt:formatNumber value="${product.productPrice * product.productDiscount }" type="currency" currencySymbol="￦"/>원</span> <fmt:formatNumber value="${product.productPrice }" type="currency" currencySymbol="￦"/>원<span class="price-tax"></span>
              </div>
              <!-- product_price -->
              <div class="rating"> <span class="fa fa-stack"><i class="fa fa-star fa-stack-2x"></i><i class="fa fa-star-o fa-stack-2x"></i></span> <span class="fa fa-stack"><i class="fa fa-star fa-stack-2x"></i><i class="fa fa-star-o fa-stack-2x"></i></span> <span class="fa fa-stack"><i class="fa fa-star fa-stack-2x"></i><i class="fa fa-star-o fa-stack-2x"></i></span> <span class="fa fa-stack"><i class="fa fa-star-o fa-stack-2x"></i></span> <span class="fa fa-stack"><i class="fa fa-star-o fa-stack-2x"></i></span> </div>
              <!-- totalProductPoint 별이 다섯개  이부분은 좀더 고민-->
            </div>
 
          </div>
        </div>
	</c:forEach>  
      </div>
      <div class="category-page-wrapper">
 
        <div class="pagination-inner">
		<ul class="pagination">
            <li class="active">
            ${pageBar }
          </ul>


        </div>
      </div>
    </div>
    </c:if>
    <c:if test="${productList.size() == 0 }">
       <h1>해당하는 조건의 상품이 없습니다.</h1>
       </c:if>
  </div>
</div>
</section>
<script>
$('#input-limit').on('change', function(){
/* console.log($('#input-limit').val()); */
$('#numPerPagesFrm').submit();
});

function fn_wishChk(productNo){
		event.stopPropagation();
		/* console.log(event); */
		$.ajax({
			url:"${path}/product/selectWishYewon.do",
			data: {"productNo":productNo},
			success:function(data){
            if(data > 0){	
            	$('#' + productNo).html('<i class="fa fa-heart"></i>');
            	$('#' + productNo).attr( "title" , "Remove to Wish List");
            }
            else
            	$('#' + productNo).html('<i class="fa fa-heart-o"></i>');
            $('#' + productNo).attr( "title" , "Add to Wish List");
            }
		});
}

function fn_wishLoginChk(){
	event.stopPropagation();
	alert('위시리스트 추가는 로그인이 필요합니다.');
}
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>