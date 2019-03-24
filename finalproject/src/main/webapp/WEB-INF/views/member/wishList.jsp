<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath }" />
<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>

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
					<div class="col-md-1 text-right page-wrapper">
          <label class="control-label" for="input-limit">Show :</label>
          <div class="limit">
          <form name="numPerPagesFrm" id="numPerPagesFrm" action = "${path }/product/newList.do">
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
      <c:forEach items="${wishList }" var="wish" varStatus="vs">
      
	<div class="product-layout product-list col-xs-12">
          <div class="product-thumb">
         <div class="image product-imageblock" style="height:220px;">
         <a href="${path }/product/productView.do?productNo=${wish.PRODUCT_NO}">
         <img src="${path}/resources/image/product/${wish.PRODUCT_PROFILE }" alt="${wish.PRODUCT_TITLE }" title="${wish.PRODUCT_TITLE }" class="img-responsive" /></a>
              <div class="button-group">
              
              <!-- 이거 좀 봐야됨 해당 품목 클릭이 안됨! -->
              <input id="wishProductNo" type="hidden" value="${wish.PRODUCT_NO}"/>
                <button type="button" id="wishBtn" class="wishlist" title="Add to Wish List" onclick="deleteWish();">
                	<i class="fa fa-heart"></i>
                </button>
              </div>
            </div>

            <div class="caption product-detail">
              <h4 class="product-name">
              <a href="${path }/product/productView.do?productNo=${wish.PRODUCT_NO}" title="${wish.PRODUCT_TITLE }"> ${wish.PRODUCT_TITLE } </a> </h4>
                                    <p class="rating">${wish.PRODUCT_COMMENT }</p>
              
              <div class="product-desc">${wish.PRODUCT_COMMENT }</div>
              
              <%-- <p class="price product-price"><span class="price-old"></span> ${product.productPrice } <span class="price-tax"></span> </p> --%><!-- 원본 -->
              <p class="price product-price"><span class="price-old">${wish.PRODUCT_PRICE }</span> ${wish.PRODUCT_PRICE + wish.PRODUCT_DISCOUNT } <span class="price-tax"></span> </p>
              
              <div class="rating"> <span class="fa fa-stack"><i class="fa fa-star fa-stack-2x"></i><i class="fa fa-star-o fa-stack-2x"></i></span> <span class="fa fa-stack"><i class="fa fa-star fa-stack-2x"></i><i class="fa fa-star-o fa-stack-2x"></i></span> <span class="fa fa-stack"><i class="fa fa-star fa-stack-2x"></i><i class="fa fa-star-o fa-stack-2x"></i></span> <span class="fa fa-stack"><i class="fa fa-star-o fa-stack-2x"></i></span> <span class="fa fa-stack"><i class="fa fa-star-o fa-stack-2x"></i></span> </div>
              
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
function deleteWish(){
		var wishProductNo = $('#wishProductNo').val();
		location.href="${path}/member/deleteWish.do?productNo="+wishProductNo;
};

</script>

</section>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>