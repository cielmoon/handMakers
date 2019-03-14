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
    <li><a href="#">Electronics</a></li>
  </ul>
  <div class="row">
    <div id="column-left" class="col-sm-3 hidden-xs column-left">
      <div class="column-block">
        <div class="columnblock-title">Categories</div>
        <div class="category_block">
          <ul class="box-category treeview-list treeview">
            <li><a href="#" class="activSub">Desktops</a>
              <ul>
                <li><a href="#">PC</a></li>
                <li><a href="#">MAC</a></li>
              </ul>
            </li>
            <li><a href="#" class="activSub">Laptops &amp; Notebooks</a>
              <ul>
                <li><a href="#">Macs</a></li>
                <li><a href="#">Windows</a></li>
              </ul>
            </li>
            <li><a href="#" class="activSub">Components</a>
              <ul>
                <li><a href="#">Mice and Trackballs</a></li>
                <li><a href="#" class="activSub" >Monitors</a>
                  <ul>
                    <li><a href="#"  >test 1</a></li>
                    <li><a href="#"  >test 2</a></li>
                  </ul>
                </li>
                <li><a href="#">Windows</a></li>
              </ul>
            </li>
            <li><a href="#">Tablets</a></li>
            <li><a href="#">Software</a></li>
            <li><a href="#">Phones & PDAs</a></li>
            <li><a href="#">Cameras</a></li>
            <li><a href="#">MP3 Players</a></li>
          </ul>
        </div>
      </div>
      <!-- start -->
      <!-- <div class="panel panel-default filter">
      <div class="panel-heading columnblock-title">Refine Search</div>
        <div class="filter-block">
          <div class="list-group"> <a class="list-group-item">Color</a>
            <div class="list-group-item">
              <div id="filter-group1">
                <label class="checkbox">
                  <input name="filter[]" type="checkbox" value="1" />
                  Black (7)</label>
                <label class="checkbox">
                  <input name="filter[]" type="checkbox" value="2" />
                  Blue (6)</label>
                <label class="checkbox">
                  <input name="filter[]" type="checkbox" value="3" />
                  Red (6)</label>
              </div>
            </div>
            <a class="list-group-item">Price</a>
            <div class="list-group-item">
              <div id="filter-group2">
                <label class="checkbox">
                  <input name="filter[]" type="checkbox" value="4" />
                  $100-$300 (6)</label>
                <label class="checkbox">
                  <input name="filter[]" type="checkbox" value="5" />
                  $301-$1000 (6)</label>
              </div>
            </div>
            <a class="list-group-item">Size</a>
            <div class="list-group-item">
              <div id="filter-group3">
                <label class="checkbox">
                  <input name="filter[]" type="checkbox" value="6" />
                  Big (3)</label>
                <label class="checkbox">
                  <input name="filter[]" type="checkbox" value="7" />
                  Medium (3)</label>
                <label class="checkbox">
                  <input name="filter[]" type="checkbox" value="8" />
                  Small (1)</label>
              </div>
            </div>
          </div>
          <div class="panel-footer text-right">
            <button type="button" id="button-filter" class="btn btn-primary">Refine Search</button>
          </div>
        </div>
      </div>
      <div class="banner" >
        <div class="item"> <a href="#"><img src="${path }/resources/image/banners/LeftBanner.jpg" alt="Left Banner" class="img-responsive" /></a> </div>
      </div>
      <h3 class="productblock-title">Specials</h3>
      <div class="row special-grid product-grid">
        <div class="col-lg-3 col-md-4 col-sm-6 col-xs-12 product-grid-item">
          <div class="product-thumb transition">
            <div class="image product-imageblock"> <a href="#"><img src="${path }/resources/image/product/5product50x59.jpg" alt="women's New Wine is an alcoholic" title="women's New Wine is an alcoholic" class="img-responsive" /></a>
              <div class="button-group">
                <button type="button" class="wishlist" data-toggle="tooltip" title="Add to Wish List" ><i class="fa fa-heart-o"></i></button>
                <button type="button" class="addtocart-btn" >Add to Cart</button>
                <button type="button" class="compare" data-toggle="tooltip" title="Compare this Product" ><i class="fa fa-exchange"></i></button>
              </div>
            </div>
            <div class="caption product-detail">
              <h4 class="product-name"> <a href="product.html" title="women's New Wine is an alcoholic">New Wine is an alcoholic</a> </h4>
              <p class="price product-price"> <span class="price-new">$254.00</span><span class="price-tax">Ex Tax: $210.00</span> </p>
            </div>
            <div class="button-group">
              <button type="button" class="wishlist" data-toggle="tooltip" title="Add to Wish List" ><i class="fa fa-heart-o"></i></button>
              <button type="button" class="addtocart-btn" >Add to Cart</button>
              <button type="button" class="compare" data-toggle="tooltip" title="Compare this Product" ><i class="fa fa-exchange"></i></button>
            </div>
          </div>
        </div>
        <div class="col-lg-3 col-md-4 col-sm-6 col-xs-12 product-grid-item">
          <div class="product-thumb transition">
            <div class="image product-imageblock"> <a href="#"><img src="${path }/resources/image/product/1product50x59.jpg" alt="women's New Wine is an alcoholic" title="women's New Wine is an alcoholic" class="img-responsive" /></a>
              <div class="button-group">
                <button type="button" class="wishlist" data-toggle="tooltip" title="Add to Wish List" ><i class="fa fa-heart-o"></i></button>
                <button type="button" class="addtocart-btn" >Add to Cart</button>
                <button type="button" class="compare" data-toggle="tooltip" title="Compare this Product" ><i class="fa fa-exchange"></i></button>
              </div>
            </div>
            <div class="caption product-detail">
              <h4 class="product-name"> <a href="product.html" title="women's New Wine is an alcoholic">New Wine is an alcoholic</a> </h4>
              <p class="price product-price"> <span class="price-new">$254.00</span><span class="price-tax">Ex Tax: $210.00</span> </p>
            </div>
            <div class="button-group">
              <button type="button" class="wishlist" data-toggle="tooltip" title="Add to Wish List" ><i class="fa fa-heart-o"></i></button>
              <button type="button" class="addtocart-btn" >Add to Cart</button>
              <button type="button" class="compare" data-toggle="tooltip" title="Compare this Product" ><i class="fa fa-exchange"></i></button>
            </div>
          </div>
        </div>
        <div class="col-lg-3 col-md-4 col-sm-6 col-xs-12 product-grid-item">
          <div class="product-thumb transition">
            <div class="image product-imageblock"> <a href="#"><img src="${path }/resources/image/product/4product50x59.jpg" alt="women's New Wine is an alcoholic" title="women's New Wine is an alcoholic" class="img-responsive" /></a>
              <div class="button-group">
                <button type="button" class="wishlist" data-toggle="tooltip" title="Add to Wish List" ><i class="fa fa-heart-o"></i></button>
                <button type="button" class="addtocart-btn" >Add to Cart</button>
                <button type="button" class="compare" data-toggle="tooltip" title="Compare this Product" ><i class="fa fa-exchange"></i></button>
              </div>
            </div>
            <div class="caption product-detail">
              <h4 class="product-name"> <a href="product.html" title="women's New Wine is an alcoholic">New Wine is an alcoholic</a> </h4>
              <p class="price product-price"> <span class="price-new">$254.00</span><span class="price-tax">Ex Tax: $210.00</span> </p>
            </div>
            <div class="button-group">
              <button type="button" class="wishlist" data-toggle="tooltip" title="Add to Wish List" ><i class="fa fa-heart-o"></i></button>
              <button type="button" class="addtocart-btn" >Add to Cart</button>
              <button type="button" class="compare" data-toggle="tooltip" title="Compare this Product" ><i class="fa fa-exchange"></i></button>
            </div>
          </div>
        </div>
      </div> -->
    <!-- end -->
    </div>
    <div id="content" class="col-sm-9">
      <h2 class="category-title">Desktops</h2>
      <!-- 카테고리배너 -->
      <%-- <div class="row category-banner">
        <div class="col-sm-12 category-image"><img src="${path }/resources/image/banners/category-banner.jpg" alt="Desktops" title="Desktops" class="img-thumbnail" /></div>
        <div class="col-sm-12 category-desc">Lorem ipsum dolomagna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate.</div>
      </div> --%>
      <!-- /카테고리배너 -->
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
            <select id="input-limit" class="form-control">
              <option value="8" selected="selected">8</option>
              <option value="25">25</option>
              <option value="50">50</option>
              <option value="75">75</option>
              <option value="100">100</option>
            </select>
          </div>
        </div>
        <!-- <div class="col-md-2 text-right sort-wrapper">
          <label class="control-label" for="input-sort">Sort By :</label>
          <div class="sort-inner">
            <select id="input-sort" class="form-control">
              <option value="ASC" selected="selected">Default</option>
              <option value="ASC">Name (A - Z)</option>
              <option value="DESC">Name (Z - A)</option>
              <option value="ASC">Price (Low &gt; High)</option>
              <option value="DESC">Price (High &gt; Low)</option>
              <option value="DESC">Rating (Highest)</option>
              <option value="ASC">Rating (Lowest)</option>
              <option value="ASC">Model (A - Z)</option>
              <option value="DESC">Model (Z - A)</option>
            </select>
          </div>
        </div> -->
      </div>
      <br />
      
      
      
      <div class="grid-list-wrapper">
      
      
      
       <!-- 작업중 -->
       <!-- 리스트는 input-limit 갯수 만큼. -->
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
              <p class="price product-price"><span class="price-old">$272.00</span> ${product.productPrice } <span class="price-tax">Ex Tax: $100.00</span> </p>
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
            <!-- <span>1</span></li>
            <li><a href="category.html">2</a></li>
            <li><a href="category.html">&gt;</a></li>
            <li><a href="category.html">&gt;|</a></li> -->
          </ul>
        </div>
        
      </div>
    </div>
  </div>
</div>
</section>


<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
