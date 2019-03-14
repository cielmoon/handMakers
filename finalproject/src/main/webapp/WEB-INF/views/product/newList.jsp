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
    <li><a href="${path }/product/newList.do">신규</a></li>
  </ul>
  <div class="row">
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
							<select id="input-limit" class="form-control">
								<option value="8" selected="selected">8</option>
								<option value="25">25</option>
								<option value="50">50</option>
								<option value="75">75</option>
								<option value="100">100</option>
							</select>
						</div>
					</div>
					
					
				</div>
      <!-- <div class="category-page-wrapper">
        <div class="col-md-6 list-grid-wrapper">
          <div class="btn-group btn-list-grid">          
          	스타일줘야함 이버튼 흰색으로 바궈놔야함
            <button type="button" id="grid-view" class="btn btn-default grid" data-toggle="tooltip" title="Grid"><i class="fa fa-th"></i></button>
          </div>         
        <div class="col-md-1 text-right page-wrapper">
          
          <div class="limit">
            <select id="input-limit" class="form-control">
              <option value="8" selected="selected">8</option>
              <option value="25">25</option>
              <option value="50">50</option>
              <option value="75">75</option>
              <option value="100">100</option>
            </select>
          </div>
        </div>

      </div>
      <br /> -->
      <div class="grid-list-wrapper">
      
      <div class="product-layout product-list col-xs-12">
						<div class="product-thumb">
							<div class="image product-imageblock">
								<a href="product.html"> <img
									src="${path }/resources/image/product/pro-2-220x294.jpg"
									alt="women's New Wine is an alcoholic stores"
									title="lorem ippsum dolor dummy" class="img-responsive" />
								</a>
								<div class="button-group">
									<button type="button" class="wishlist" data-toggle="tooltip"
										title="주문하기">주문하기</button>
								</div>
							</div>
							<div class="caption product-detail">
								<h4 class="product-name">
									<a href="product.html" title="상품명 위치"> 상품명 </a>
								</h4>
								<p class="product-desc">상품 간략 설명</p>
								<p class="price product-price">
									<span class="price-old">$272.00</span> $122.00 <span
										class="price-tax">Ex Tax: $100.00</span>
								</p>
								<div class="rating">
									<span class="fa fa-stack"><i
										class="fa fa-star fa-stack-2x"></i><i
										class="fa fa-star-o fa-stack-2x"></i></span> <span
										class="fa fa-stack"><i class="fa fa-star fa-stack-2x"></i><i
										class="fa fa-star-o fa-stack-2x"></i></span> <span
										class="fa fa-stack"><i class="fa fa-star fa-stack-2x"></i><i
										class="fa fa-star-o fa-stack-2x"></i></span> <span
										class="fa fa-stack"><i class="fa fa-star-o fa-stack-2x"></i></span>
									<span class="fa fa-stack"><i
										class="fa fa-star-o fa-stack-2x"></i></span>
								</div>
							</div>
						</div>
					</div>
					<div class="product-layout product-list col-xs-12">
						<div class="product-thumb">
							<div class="image product-imageblock">
								<a href="product.html"> <img
									src="${path }/resources/image/product/pro-2-220x294.jpg"
									alt="women's New Wine is an alcoholic stores"
									title="lorem ippsum dolor dummy" class="img-responsive" />
								</a>
								<div class="button-group">
									<button type="button" class="wishlist" data-toggle="tooltip"
										title="주문하기">주문하기</button>
								</div>
							</div>
							<div class="caption product-detail">
								<h4 class="product-name">
									<a href="product.html" title="상품명 위치"> 상품명 </a>
								</h4>
								<p class="product-desc">상품 간략 설명</p>
								<p class="price product-price">
									<span class="price-old">$272.00</span> $122.00 <span
										class="price-tax">Ex Tax: $100.00</span>
								</p>
								<div class="rating">
									<span class="fa fa-stack"><i
										class="fa fa-star fa-stack-2x"></i><i
										class="fa fa-star-o fa-stack-2x"></i></span> <span
										class="fa fa-stack"><i class="fa fa-star fa-stack-2x"></i><i
										class="fa fa-star-o fa-stack-2x"></i></span> <span
										class="fa fa-stack"><i class="fa fa-star fa-stack-2x"></i><i
										class="fa fa-star-o fa-stack-2x"></i></span> <span
										class="fa fa-stack"><i class="fa fa-star-o fa-stack-2x"></i></span>
									<span class="fa fa-stack"><i
										class="fa fa-star-o fa-stack-2x"></i></span>
								</div>
							</div>
						</div>
					</div>
					<div class="product-layout product-list col-xs-12">
						<div class="product-thumb">
							<div class="image product-imageblock">
								<a href="product.html"> <img
									src="${path }/resources/image/product/pro-2-220x294.jpg"
									alt="women's New Wine is an alcoholic stores"
									title="lorem ippsum dolor dummy" class="img-responsive" />
								</a>
								<div class="button-group">
									<button type="button" class="wishlist" data-toggle="tooltip"
										title="주문하기">주문하기</button>
								</div>
							</div>
							<div class="caption product-detail">
								<h4 class="product-name">
									<a href="product.html" title="상품명 위치"> 상품명 </a>
								</h4>
								<p class="product-desc">상품 간략 설명</p>
								<p class="price product-price">
									<span class="price-old">$272.00</span> $122.00 <span
										class="price-tax">Ex Tax: $100.00</span>
								</p>
								<div class="rating">
									<span class="fa fa-stack"><i
										class="fa fa-star fa-stack-2x"></i><i
										class="fa fa-star-o fa-stack-2x"></i></span> <span
										class="fa fa-stack"><i class="fa fa-star fa-stack-2x"></i><i
										class="fa fa-star-o fa-stack-2x"></i></span> <span
										class="fa fa-stack"><i class="fa fa-star fa-stack-2x"></i><i
										class="fa fa-star-o fa-stack-2x"></i></span> <span
										class="fa fa-stack"><i class="fa fa-star-o fa-stack-2x"></i></span>
									<span class="fa fa-stack"><i
										class="fa fa-star-o fa-stack-2x"></i></span>
								</div>
							</div>
						</div>
					</div>
      
      
        <div class="product-layout product-list col-xs-12">
          <div class="product-thumb">
            <div class="image product-imageblock"> <a href="product.html"> <img src="${path }/resources/image/product/pro-2-220x294.jpg" alt="women's New Wine is an alcoholic stores" title="lorem ippsum dolor dummy" class="img-responsive" /> </a>
              <div class="button-group">
                <button type="button" class="wishlist" data-toggle="tooltip" title="주문하기">주문하기</button>
              </div>
            </div>
            <div class="caption product-detail">
              <h4 class="product-name"> <a href="product.html" title="상품명 위치"> 상품명 </a> </h4>
              <p class="product-desc">상품 간략 설명</p>

              <p class="price product-price"><span class="price-old">$272.00</span> $122.00 <span class="price-tax">Ex Tax: $100.00</span> </p>
              <div class="rating"> <span class="fa fa-stack"><i class="fa fa-star fa-stack-2x"></i><i class="fa fa-star-o fa-stack-2x"></i></span> <span class="fa fa-stack"><i class="fa fa-star fa-stack-2x"></i><i class="fa fa-star-o fa-stack-2x"></i></span> <span class="fa fa-stack"><i class="fa fa-star fa-stack-2x"></i><i class="fa fa-star-o fa-stack-2x"></i></span> <span class="fa fa-stack"><i class="fa fa-star-o fa-stack-2x"></i></span> <span class="fa fa-stack"><i class="fa fa-star-o fa-stack-2x"></i></span> </div>
            </div>

          </div>
        </div>
        
        
        <div class="product-layout product-list col-xs-12">
          <div class="product-thumb">
            <div class="image product-imageblock"> 
          		<a href="product.html"> 
           			<img src="${path }/resources/image/product/pro-3-220x294.jpg" alt="lorem ippsum dolor dummy" title="lorem ippsum dolor dummy" class="img-responsive" /> 
           	  	</a>
              <div class="button-group">
                <button type="button" class="wishlist" data-toggle="tooltip" title="Add to Wish List"><i class="fa fa-heart-o"></i></button>        
              </div>
            </div>
            <div class="caption product-detail">
              <h4 class="product-name"> <a href="product.html" title="상품명 위치"> 상품명 </a> </h4>
              <p class="product-desc">상품 간략 설명</p>
              <p class="price product-price"><span class="price-old">$272.00</span> $122.00 <span class="price-tax">Ex Tax: $100.00</span> </p>
              <div class="rating"> <span class="fa fa-stack"><i class="fa fa-star fa-stack-2x"></i><i class="fa fa-star-o fa-stack-2x"></i></span> <span class="fa fa-stack"><i class="fa fa-star fa-stack-2x"></i><i class="fa fa-star-o fa-stack-2x"></i></span> <span class="fa fa-stack"><i class="fa fa-star fa-stack-2x"></i><i class="fa fa-star-o fa-stack-2x"></i></span> <span class="fa fa-stack"><i class="fa fa-star-o fa-stack-2x"></i></span> <span class="fa fa-stack"><i class="fa fa-star-o fa-stack-2x"></i></span> </div>
            </div>
 
          </div>
        </div>
  
      </div>
      <div class="category-page-wrapper">
 
        <div class="pagination-inner">



        </div>
      </div>
    </div>
  </div>
</div>
</div>
</section>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>