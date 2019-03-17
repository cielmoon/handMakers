<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
   <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
   <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>

<section class="product col-2 left-col">
<div class="container">
  <ul class="breadcrumb">
    <li><a href="/makers"><i class="fa fa-home"></i></a></li>
    <li><a href="#b?">${numPerPage } 대 카테고리 ${numPerPages }</a></li>
  </ul>
  <div class="row">
    <div id="column-left" class="col-sm-3 hidden-xs column-left">
      <div class="column-block">
        <div class="columnblock-title">Categories</div>
        <div class="category_block">
          
          <ul class="box-category treeview-list treeview">
            <li><a href="#s1" class="activSub">Desktops</a>
            <li><a href="#s2">Tablets</a></li>
            <li><a href="#s3">Software</a></li>
            <li><a href="#s4">Phones & PDAs</a></li>
            <li><a href="#s5">Cameras</a></li>
            <li><a href="#s6">MP3 Players</a></li>
          </ul>
        </div>
      </div>
    </div>
    <div id="content" class="col-sm-9">
      <h2 class="category-title">Desktops</h2>
      <div class="category-page-wrapper">
        <div class="col-md-6 list-grid-wrapper">
          <div class="btn-group btn-list-grid">
            <!-- <button type="button" id="list-view" class="btn btn-default list" data-toggle="tooltip" title="List"><i class="fa fa-th-list"></i></button>
            <button type="button" id="grid-view" class="btn btn-default grid" data-toggle="tooltip" title="Grid"><i class="fa fa-th"></i></button> -->
            <div class="result-inner">(총 ${contentCount }건의 상품)</div>
            <div id="grid-view" class="btn btn-default grid"></div><!-- <i class="fa fa-th"></i> -->
          </div>
          <!-- <a href="#" id="compare-total">Product Compare (0)</a> -->
          </div>
        <div class="col-md-1 text-right page-wrapper">
          <label class="control-label" for="input-limit">Show :</label>
          <div class="limit">
          <form name="numPerPagesFrm" id="numPerPagesFrm" action = "${path }/product/category.do">
            <select id="input-limit" name="numPerPages" class="form-control">
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
            
            
              <!-- <option value="9">9</option>selected="selected"
              <option value="18">18</option>
              <option value="27">27</option> -->
            </select>
          </form>
          </div>
        </div>
      </div>
      <br />
      
      
      
      <div class="grid-list-wrapper">
      
      
      
       <!-- 작업중 --><!-- 리스트는 input-limit 갯수 만큼. -->
       <c:forEach items="${productList }" var="product" varStatus="vs">
       
		<div class="product-layout product-list col-xs-12">
          <div class="product-thumb">
         <div class="image product-imageblock" style="height:220px;">
         <a href="${path }/product/productView.do?productNo=${product.productNo}"><!-- 상품상세페이지 ? product_no  -->
         <img src="${path}/resources/image/product/${product.productProfile }" alt="${product.productTitle }" title="${product.productTitle }" class="img-responsive" /></a>
        <!-- 상품 프로필 사진 product_profile, alt=? product_title, title=product_title -->
              <div class="button-group">
                <button type="button" class="wishlist" data-toggle="tooltip" title="Add to Wish List">
                <i class="fa fa-heart-o"></i></button><!-- title 툴팁정보 -->
                <button type="button" class="addtocart-btn">Add to Cart</button>
              </div>
            </div>
            
            <div class="caption product-detail">
              <h4 class="product-name">
              <a href="${path }/product/productView.do?productNo=${product.productNo}" title="${product.productTitle }"> ${product.productTitle } </a> </h4>
                                    <p class="rating">${product.productComment }</p><!-- div? -->
              <!-- 상품상세페이지 링크 , title=product_title , value = product_title -->
              <div class="product-desc">${product.productComment }</div>
                <!-- product_comment -->
              <%-- <p class="price product-price"><span class="price-old"></span> ${product.productPrice } <span class="price-tax"></span> </p> --%><!-- 원본 -->
              <p class="price product-price"><span class="price-old">${product.productPrice }</span> ${product.productPrice + product.productDiscount } <span class="price-tax"></span> </p>
              <!-- product_price -->
              <div class="rating"> <span class="fa fa-stack"><i class="fa fa-star fa-stack-2x"></i><i class="fa fa-star-o fa-stack-2x"></i></span> <span class="fa fa-stack"><i class="fa fa-star fa-stack-2x"></i><i class="fa fa-star-o fa-stack-2x"></i></span> <span class="fa fa-stack"><i class="fa fa-star fa-stack-2x"></i><i class="fa fa-star-o fa-stack-2x"></i></span> <span class="fa fa-stack"><i class="fa fa-star-o fa-stack-2x"></i></span> <span class="fa fa-stack"><i class="fa fa-star-o fa-stack-2x"></i></span> </div>
              <!-- totalProductPoint 별이 다섯개  이부분은 좀더 고민-->
            </div>
            <div class="button-group"><!-- 리스트형식으로 볼때의 추가 버튼들 -->
              <button type="button" class="wishlist" data-toggle="tooltip" title="Add to Wish List"><i class="fa fa-heart-o"></i></button>
              <button type="button" class="addtocart-btn">Add to Cart</button>
            </div>
          </div>
        </div>
        
        <!-- 여기까지가 상품 한사이클 패이징방식에따라서 채워주어야함. 어떤식으로 걸러서 몇개를 들고올것인가? -->
		
       
       </c:forEach>
       <!-- 작업중 -->
          
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

<!-- <script type="text/javascript">
window.onload=function()
{
	 var numPerPages = document.querySelector('#input-limit');
	 input-limit.addEventListener("change",function(){
   	 document.numPerPageFrm.submit(); 
     });
}
</script> -->

<script>
$('#input-limit').on('change', function(){
/* console.log($('#input-limit').val()); */
$('#numPerPagesFrm').submit();
});
</script>


<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
