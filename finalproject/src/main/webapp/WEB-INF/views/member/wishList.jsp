<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath }" />
<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>

<style>
.ellips{
	overflow:hidden;
	white-space:nowrap;
	text-overflow:ellipsis
}
</style>

<section>
<div class="container">
  <ul class="breadcrumb">
    <li><a href="${path }"><i class="fa fa-home"></i></a></li>
    <li><a href="${path }/member/wishList.do">WishList</a></li>
  </ul>
  <div class="row">
    <div id="content" class="col-sm-12">    

	<div class="category-page-wrapper">
					<div class="col-md-6 list-grid-wrapper">
						<div class="btn-group btn-list-grid">
							<div class="result-inner">(총 ${wishContentCount }건의 상품)</div>
							<div id="grid-view" class="btn btn-default grid"></div>
						</div>
					</div>
	</div>
     
     <div class="grid-list-wrapper">
      <c:forEach items="${wishList }" var="wish" varStatus="vs">
      
	<div class="product-layout product-list col-xs-12">
          <div class="product-thumb">
         <div class="image product-imageblock" style="height:220px;max-width:220px;">
         <a href="${path }/product/productView.do?productNo=${wish.PRODUCT_NO}">
         <img src="${path}/resources/image/product/${wish.PRODUCT_PROFILE }" alt="${wish.PRODUCT_TITLE }" title="${wish.PRODUCT_TITLE }" class="img-responsive" /></a>
              <div class="button-group">
              
              <!-- 이거 좀 봐야됨 해당 품목 클릭이 안됨! -->
              <input id="wishProductNo${vs.index }" type="hidden" value="${wish.PRODUCT_NO}"/>
                <button type="button" id="wishBtn" class="wishlist" title="Add to Wish List" onclick="deleteWish('wishProductNo${vs.index }');">
                	<i class="fa fa-heart"></i>
                </button>
              </div>
            </div>

            <div class="caption product-detail">
              <h4 class="product-name">
              <a href="${path }/product/productView.do?productNo=${wish.PRODUCT_NO}" title="${wish.PRODUCT_TITLE }"> ${wish.PRODUCT_TITLE } </a> </h4>
              
              <p class="price product-price">
              <c:choose>
	              <c:when test="${wish.PRODUCT_STEP eq 0}">
	             	 <span class="price-old">${wish.PRODUCT_PRICE }</span>
	              </c:when>
	              <c:when test="${wish.PRODUCT_STEP ne 0}">
	             	 <span class="price-old"></span>
	              </c:when> 
              </c:choose>
              <fmt:formatNumber value="${wish.SALEPRICE }" type="currency" currencySymbol="￦"/> 
              <span class="price-tax"></span> </p>
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
  </div>
</div>
<script>
function deleteWish(productNo){
		var wishProductNo = $('#'+productNo).val();
		location.href="${path}/member/deleteWish.do?productNo="+wishProductNo;
};

</script>

</section>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>