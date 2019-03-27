<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
   <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
   <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
<style>
.ellips{
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
}
</style>
<section class="product col-2 left-col">
<div class="container">
  <ul class="breadcrumb">
    <li><a href="/makers"><i class="fa fa-home"></i></a></li>
    <li><a href="${path }/product/bestList.do">베스트</a></li>
  </ul>
  <div class="row">
    <div id="column-left" class="col-sm-3 hidden-xs column-left">
      <div class="column-block">
        <div class="columnblock-title"><a href="${path }/product/bestList.do?category=${category}&tab=b">${bcTitle }</a></div>
        <div class="category_block">
          <%-- <h1>${sCategoryList}</h1> --%>
          <ul class="box-category treeview-list treeview">
            <div id = bestMenuList>
            
            <c:forEach items="${sCategoryList}" var="scList" varStatus="vs">
            <li><a href="${path }/product/bestList.do?category=${category}&sc=${scList.SC_NO}&tab=b">${scList.SC_TITLE }</a></li>
            </c:forEach>
            
            </div>
          </ul>
        </div>
      </div>
    </div>
    <c:if test="${productList.size() != 0 }">
    <div id="content" class="col-sm-9">
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
          <form name="numPerPagesFrm" id="numPerPagesFrm" action = "${path }/product/bestList.do">
            <select id="input-limit" name="numPerPage" class="form-control">
            <c:set var="numper" value="${numPerPage }" />
			<c:choose>
    		<c:when test="${numper eq '18'}">
        	<option value="9">9</option>
             <option value="18" selected="selected">18</option>
             <option value="27">27</option>
    		</c:when>
    		<c:when test="${numper eq '27'}">
        	<option value="9">9</option>
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

       <c:forEach items="${productList }" var="product" varStatus="vs">
       
		<div class="product-layout product-list col-xs-12">
          <div class="product-thumb">
          <div onclick="location.href='${path }/product/productView.do?productNo=${product.productNo}&best=best&tab=b'"	class="image product-imageblock" style="height : 220px; background-size : cover; background-image : url(${path}/resources/image/product/${product.productProfile }); cursor : pointer;">
                       
               <div class="button-group">
               <c:if test="${member==null }">
               <button type="button" id="${product.productNo}" data-toggle="tooltip" class="btn btn-default wishlist" title="Add to Wish List" value="${product.productNo}" onclick="fn_wishLoginChk();">
                	<i class="fa fa-heart-o"></i>
               </button>
               </c:if>
                <c:if test="${member.memberNo != null and product.wishChk eq member.memberNo }">
                <button type="button" id="${product.productNo}" data-toggle="tooltip" class="btn btn-default wishlist" title="Remove to Wish List" value="${product.productNo}" onclick="fn_wishChk(this.value);">
                	<i class="fa fa-heart"></i>
               	</button>
               </c:if>
               <c:if test="${member.memberNo != null and product.wishChk eq null }">
                <button type="button" id="${product.productNo}" data-toggle="tooltip" class="btn btn-default wishlist" title="Add to Wish List" value="${product.productNo}" onclick="fn_wishChk(this.value);">
                	<i class="fa fa-heart-o"></i>
               	</button>
               </c:if>
              </div>
            </div>
            
            <div class="caption product-detail">
              <h4 class="product-name ellips">
              <a href="${path }/product/productView.do?productNo=${product.productNo}&best=best&tab=b" title="${product.productTitle }"> ${product.productTitle } </a> </h4>
			<div style="width : 200px; height : 24px;" class="rating ellips">${product.productComment }</div>
                <!-- product_comment -->
                <div style="width : 200px; height : 24px;">
                <p class="price product-price" style="margin-bottom: 0px;"><span class="price-old"></span> <fmt:formatNumber value="${product.productPrice }" type="currency" currencySymbol="￦"/>원 <span class="price-tax"></span> </p>
                </div><br>
              <!-- product_price -->
              <div style="float: right;">
              <%-- ${ product.score }평점 : --%>
			<c:if test="${product.score ge 0 and product.score lt 0.5 }">
               <i class="far fa-star"></i><i class="far fa-star"></i><i class="far fa-star"></i><i class="far fa-star"></i><i class="far fa-star"></i>
            </c:if>
            <c:if test="${product.score ge 0.5 and product.score lt 1}">
            	<i class="fas fa-star-half-alt"></i><i class="far fa-star"></i><i class="far fa-star"></i><i class="far fa-star"></i><i class="far fa-star"></i>
            </c:if>
            <c:if test="${product.score ge 1 and product.score lt 1.5}">
            	<i class="fas fa-star"></i><i class="far fa-star"></i><i class="far fa-star"></i><i class="far fa-star"></i><i class="far fa-star"></i>
            </c:if>
            <c:if test="${product.score ge 1.5 and product.score lt 2}">
            	<i class="fas fa-star"></i><i class="fas fa-star-half-alt"></i><i class="far fa-star"></i><i class="far fa-star"></i><i class="far fa-star"></i>
            </c:if>
            <c:if test="${product.score ge 2 and product.score lt 2.5}">
            	<i class="fas fa-star"></i><i class="fas fa-star"></i><i class="far fa-star"></i><i class="far fa-star"></i><i class="far fa-star"></i>
            </c:if>
            <c:if test="${product.score ge 2.5 and product.score lt 3}">
            	<i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star-half-alt"></i><i class="far fa-star"></i><i class="far fa-star"></i>
            </c:if>
            <c:if test="${product.score ge 3 and product.score lt 3.5}">
            	<i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="far fa-star"></i><i class="far fa-star"></i>
            </c:if>
            <c:if test="${product.score ge 3.5 and product.score lt 4}">
            	<i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star-half-alt"></i><i class="far fa-star"></i>
            </c:if>
            <c:if test="${product.score ge 4 and product.score lt 4.5}">
            	<i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="far fa-star"></i>
            </c:if>
            <c:if test="${product.score ge 4.5 and product.score lt 5}">
            	<i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star-half-alt"></i>
            </c:if>
            <c:if test="${product.score eq 5}">
            	<i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i>
            </c:if>
               </div>
              <!-- totalProductPoint 별-->
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
$('#numPerPagesFrm').submit();
});

function fn_wishChk(productNo){
	event.stopPropagation();
	$.ajax({
		url:"${path}/product/selectWishYewon.do",
		data: {"productNo":productNo},
		success:function(data){
        if(data == 1){	
        	$('#' + productNo).html('<i class="fa fa-heart"></i>');
        	alert('위시리스트에 추가 되었습니다.');
        	return true;
        }
        else
        $('#' + productNo).html('<i class="fa fa-heart-o"></i>');
        alert('위시리스트에서 제거 되었습니다.');
        return false;

        }
	});
}

function fn_wishLoginChk(){
event.stopPropagation();
alert('위시리스트 추가는 로그인이 필요합니다.');
}
</script>
<script type="text/javascript">
	$(function(){
		var a = '${sCategoryList}';
		if(a == ""){
		$.ajax({
			url:"${path}/common/menuList.do",
			success: function(data){
				for(var i = 0 ; i < data.length ; i++){
					$('#bestMenuList').append('<li><a href="${path }/product/bestList.do?category='+data[i].BC_NO+'">'+data[i].BC_TITLE+'</a></li>');
				}
			}
		});
		}
	});
</script>


<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>