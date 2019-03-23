<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
   <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
   <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
<style>
<!--
.ellips{
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
}
-->
</style>
<section class="product col-2 left-col">
<div class="container">
  <ul class="breadcrumb">
    <li><a href="/makers"><i class="fa fa-home"></i></a></li>
    <li><a href="${path }/product/category.do?category=${category}">${bcTitle }</a></li>
  </ul>
  <div class="row">
    <div id="column-left" class="col-sm-3 hidden-xs column-left">
      <div class="column-block">
        <div class="columnblock-title"><a href="${path }/product/category.do?category=${category}">${bcTitle }</a></div>
        <div class="category_block">
          <%-- <h1>${sCategoryList}</h1> --%>
          <ul class="box-category treeview-list treeview">
            <c:forEach items="${sCategoryList}" var="scList" varStatus="vs">
            <li><a href="${path }/product/category.do?category=${category}&sc=${scList.SC_NO}">${scList.SC_TITLE }</a></li>
            </c:forEach>
          </ul>
        </div>
      </div>
    </div>
    <div id="content" class="col-sm-9">
      <div class="category-page-wrapper">
        <div class="col-md-6 list-grid-wrapper">
          <div class="btn-group btn-list-grid">
            <div class="result-inner">(총 ${contentCount }건의 상품)</div>
            <div id="grid-view" class="btn btn-default grid"></div><!-- <i class="fa fa-th"></i> -->
          </div>
          </div>
        <div class="col-md-1 text-right page-wrapper">
          <label class="control-label" for="input-limit">Show :</label>
          <div class="limit">
          <form name="numPerPagesFrm" id="numPerPagesFrm" action = "${path }/product/category.do">
            <select id="input-limit" name="numPerPage" class="form-control">
            <c:set var="numper" value="${numPerPage }" />
			<c:choose>
    		<c:when test="${numper eq '18'}">
        	<option value="9">9</option><!-- selected="selected" -->
             <option value="18" selected="selected">18</option>
             <option value="27">27</option>
    		</c:when>
    		<c:when test="${numper eq '27'}">
        	<option value="9">9</option><!-- selected="selected" -->
              <option value="18">18</option>
              <option value="27" selected="selected">27</option>
    		</c:when>
    		<c:otherwise>
       		<option value="9" selected="selected">9</option>
              <option value="18">18</option>
              <option value="27">27</option>
    		</c:otherwise>
			</c:choose>
            
            </select>
          </form>
          </div>
        </div>
      </div>
      <br />
      
      <div class="grid-list-wrapper">
      
      
       <!-- 리스트는 input-limit 갯수 만큼. -->
       <c:forEach items="${productList }" var="product" varStatus="vs">
       
		<div class="product-layout product-list col-xs-12">
          <div class="product-thumb">
         <div class="image product-imageblock" style="height:220px;">
         <%-- <h1>${product.productNo}</h1> 확인용 --%>
         <a href="${path }/product/productView.do?productNo=${product.productNo}"><!-- 상품상세페이지 ? product_no  -->
         <img src="${path}/resources/image/product/${product.productProfile }" alt="${product.productTitle }" title="${product.productTitle }" class="img-responsive" /></a>
               <div class="button-group">
               <c:if test="${member==null }">
               <button type="button" id="${product.productNo}" data-toggle="tooltip" class="btn btn-default wishlist" title="Wish List" value="${product.productNo}" onclick="alert('위시리스트 추가는 로그인이 필요합니다.')">
                	<i class="fa fa-heart-o"></i>
               </button>
               </c:if>
                <c:if test="${member.memberNo != null and product.wishChk eq member.memberNo }">
                <button type="button" id="${product.productNo}" data-toggle="tooltip" class="btn btn-default wishlist" title="Wish List" value="${product.productNo}" onclick="fn_wishChk(this.value);">
                	<i class="fa fa-heart"></i>
               	</button>
               </c:if>
               <c:if test="${member.memberNo != null and product.wishChk eq null }">
                <button type="button" id="${product.productNo}" data-toggle="tooltip" class="btn btn-default wishlist" title="Wish List" value="${product.productNo}" onclick="fn_wishChk(this.value);">
                	<i class="fa fa-heart-o"></i>
               	</button>
               </c:if>
               
               
                <!-- <button type="button" class="addtocart-btn">Add to Cart</button> -->
              </div>
            </div>
            
            <div class="caption product-detail">
              <h4 class="product-name ellips">
              <a href="${path }/product/productView.do?productNo=${product.productNo}" title="${product.productTitle }"> ${product.productTitle } </a> </h4>
			<div style="width : 200px; height : 24px;" class="rating ellips">${product.productComment }</div>
              <!-- 상품상세페이지 링크 , title=product_title , value = product_title -->
                <!-- product_comment -->
                <p class="price product-price"><span class="price-old"></span> <fmt:formatNumber value="${product.productPrice }" type="currency" currencySymbol="￦"/>원 <span class="price-tax"></span> </p>
              <!-- product_price -->
              <div class="rating"> <span class="fa fa-stack"><i class="fa fa-star fa-stack-2x"></i><i class="fa fa-star-o fa-stack-2x"></i></span> <span class="fa fa-stack"><i class="fa fa-star fa-stack-2x"></i><i class="fa fa-star-o fa-stack-2x"></i></span> <span class="fa fa-stack"><i class="fa fa-star fa-stack-2x"></i><i class="fa fa-star-o fa-stack-2x"></i></span> <span class="fa fa-stack"><i class="fa fa-star-o fa-stack-2x"></i></span> <span class="fa fa-stack"><i class="fa fa-star-o fa-stack-2x"></i></span> </div>
              <!-- totalProductPoint 별-->
            </div>
            <%-- <div class="button-group"><!-- 리스트형식으로 볼때의 추가 버튼들 -->
              <button type="button" class="wishlist" data-toggle="tooltip" title="Add to Wish List" value="${product.productNo}"><i class="fa fa-heart-o"></i></button>
              <button type="button" class="addtocart-btn">Add to Cart</button>
            </div> --%>
          </div>
        </div>
       
       </c:forEach>
          
      </div>
      <div class="category-page-wrapper">
        <%-- <div class="result-inner">Showing 1 to 8 of 10 (${cPage } Pages)</div> --%>
        
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
</section>


<script>
$('#input-limit').on('change', function(){
/* console.log($('#input-limit').val()); */
$('#numPerPagesFrm').submit();
});


function fn_wishChk(productNo){
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
</script>



<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
