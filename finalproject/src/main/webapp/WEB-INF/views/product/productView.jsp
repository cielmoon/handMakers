<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
<script>
	$(function(){
		var cartBtn=$('#cartBtn');
		cartBtn.on('click',function(){
			location.href="${path}/shop/shopCart.do";
		});
	});
</script>
<section class="product col-2 left-col">
<div class="preloader loader" style="display: block; background:#f2f2f2;"> <img src="image/loader.gif"  alt="#"/></div>

<div class="container">
  <ul class="breadcrumb">
    <li><a href="index.html"><i class="fa fa-home"></i></a></li>
    <li><a href="${path }/product/category.do">대분류카테고리(BC_TITLE)</a></li>
    <li><a href="${path }/product/productView.do">소분류카테고리(SC_TITLE)</a></li>
  </ul>
  <!-- nav -->
  <div class="row">
    <div id="column-left" class="col-sm-3 hidden-xs column-left">
      <div class="column-block">
        <div class="column-block">
          <div class="columnblock-title">대분류카테고리(BC_TITLE)</div>
          <div class="category_block">
            <ul class="box-category treeview-list treeview">
              <li><a href="#">소분류카테고리1(SC_TITLE)</a></li>
              <li><a href="#">소분류카테고리2(SC_TITLE)</a></li>
              <li><a href="#">소분류카테고리3(SC_TITLE)</a></li>
            </ul>
          </div>
        </div>
       </div>
       </div>
        
    <div id="content" class="col-sm-9">
      <div class="row">
        
        <!-- 상세 상품 사진 넣는 곳 시작 -->
        <div class="col-sm-6">
          
          <div class="thumbnails">
            
            <div><a class="thumbnail" href="image/product/product8.jpg" title="lorem ippsum dolor dummy"><img src="${path }/resources/image/product/product1.jpg" title="lorem ippsum dolor dummy" alt="lorem ippsum dolor dummy" /></a></div>
            
            <div id="product-thumbnail" class="owl-carousel">

              <div class="item">
                <div class="image-additional"><a class="thumbnail  " href="image/product/product1.jpg" title="lorem ippsum dolor dummy"> <img src="${path }/resources/image/product/ciel1.png" title="lorem ippsum dolor dummy" alt="lorem ippsum dolor dummy" /></a></div>
              </div>
              
              <div class="item">
                <div class="image-additional"><a class="thumbnail  " href="image/product/product2.jpg" title="lorem ippsum dolor dummy"> <img src="${path }/resources/image/product/pro-2-220x294.jpg" title="lorem ippsum dolor dummy" alt="lorem ippsum dolor dummy" /></a></div>
              </div>
              
              <div class="item">
                <div class="image-additional"><a class="thumbnail  " href="image/product/product3.jpg" title="lorem ippsum dolor dummy"> <img src="${path }/resources/image/product/pro-3-220x294.jpg" title="lorem ippsum dolor dummy" alt="lorem ippsum dolor dummy" /></a></div>
              </div>
              
              <div class="item">
                <div class="image-additional"><a class="thumbnail  " href="image/product/product4.jpg" title="lorem ippsum dolor dummy"> <img src="${path }/resources/image/product/pro-4-220x294.jpg" title="lorem ippsum dolor dummy" alt="lorem ippsum dolor dummy" /></a></div>
              </div>
              
              <div class="item">
                <div class="image-additional"><a class="thumbnail  " href="image/product/product5.jpg" title="lorem ippsum dolor dummy"> <img src="${path }/resources/image/product/pro-5-220x294.jpg" title="lorem ippsum dolor dummy" alt="lorem ippsum dolor dummy" /></a></div>
              </div>
              <div class="item">
                <div class="image-additional"><a class="thumbnail  " href="image/product/product6.jpg" title="lorem ippsum dolor dummy"> <img src="${path }/resources/image/product/pro-6-220x294.jpg" title="lorem ippsum dolor dummy" alt="lorem ippsum dolor dummy" /></a></div>
              </div>
              <div class="item">
                <div class="image-additional"><a class="thumbnail  " href="image/product/product7.jpg" title="lorem ippsum dolor dummy"> <img src="${path }/resources/image/product/pro-7-220x294.jpg" title="lorem ippsum dolor dummy" alt="lorem ippsum dolor dummy" /></a></div>
              </div>
              
            </div>
          </div>
        </div>
        <!-- 상세 상품 사진 넣는 곳 끝 -->
        
        <!-- 상품 설명 -->
        <div class="col-sm-6">
          <h1 class="productpage-title">상품명</h1>
          
          <!-- 별 찍는 거 -->
          <div class="rating product"> 
          <span class="fa fa-stack">
	          <i class="fa fa-star fa-stack-1x"></i>
	          <i class="fa fa-star-o fa-stack-1x"></i>
          </span> 
          <span class="fa fa-stack">
	          <i class="fa fa-star fa-stack-1x"></i>
	          <i class="fa fa-star-o fa-stack-1x"></i>
          </span> 
          <span class="fa fa-stack">
	          <i class="fa fa-star fa-stack-1x"></i>
	          <i class="fa fa-star-o fa-stack-1x"></i>
          </span> 
          <span class="fa fa-stack">
          	<i class="fa fa-star-o fa-stack-1x"></i>
          </span> 
          <span class="fa fa-stack">
          	<i class="fa fa-star-o fa-stack-1x"></i>
          </span>
          <hr>
         
         <!-- AddThis Button BEGIN -->
            <div class="addthis_toolbox addthis_default_style"><a class="addthis_button_facebook_like" ></a> <a class="addthis_button_tweet"></a> <a class="addthis_button_pinterest_pinit"></a> <a class="addthis_counter addthis_pill_style"></a></div>
         <!-- AddThis Button END -->
          </div>
          
          
          <ul class="list-unstyled productinfo-details-top">
            <li>
            <!-- 가격 -->
              <h2 class="productpage-price">${productPrice }가격</h2>
            </li>
            
            <!-- 세금 내역 -> 이벤트 할인 가 넣으면 될듯 -->
            <!-- <li><span class="productinfo-tax">Ex Tax: $100.00</span></li> -->
            
          </ul>
          <hr>
          
          <ul class="list-unstyled product_info">
            <li>
              <label>brand:</label>
              <span> <!-- <a href="#"> -->${brandNo} <!-- </a> --></span></li>
            <li>
              <label>상품 :</label>
              <span> ${scNo }</span></li>
            <li>
              <label>재고:</label>
              <span> ${qtn }</span></li>
          </ul>
          <hr>
          	
          <p class="product-desc"> 핵심적인 간단한 상품 설명</p>
          <div id="product">
            <div class="form-group">
              <label class="control-label qty-label" for="input-quantity">수량</label>
              <input type="number" name="quantity" value="1" size="2" id="input-quantity" class="form-control productpage-qty" />
              <input type="hidden" name="productNo" value="${productNo }" />
              <div class="btn-group">
                <button type="button" data-toggle="tooltip" class="btn btn-default wishlist" title="Add to Wish List" ><i class="fa fa-heart-o"></i></button>
                <!-- 카트 버튼 -->
                <button type="button" id="cartBtn" data-loading-text="Loading..." class="btn btn-primary btn-lg btn-block addtocart">Add to Cart</button>
                <!-- <button type="button" data-toggle="tooltip" class="btn btn-default compare" title="Compare this Product" ><i class="fa fa-exchange"></i></button> -->
              </div>
            </div>
          </div>
        </div>
      </div>
      
      <!-- 상품 설명//댓글 창 List-->
      <div class="productinfo-tab">
        <ul class="nav nav-tabs">
          <li class="active"><a href="#tab-description" data-toggle="tab">상세설명</a></li>
          <li><a href="#tab-review" data-toggle="tab">상품문의</a></li>
        </ul>
        
        <!-- 상품 설명 탭 -->
        <div class="tab-content">
          <div class="tab-pane active" id="tab-description">
            <div class="cpt_product_description ">
              <div>
                <p>자세한 상품 설명</p>
              </div>
            </div>
            <!-- cpt_container_end -->
            </div>
          
          <!-- 댓글 등록 창 -->
          <div class="tab-pane" id="tab-review">
            <form class="form-horizontal">
              <div id="review"></div>
              <h2>상품 문의</h2>
              <div class="form-group required">
                <div class="col-sm-12">
                  <label class="control-label" for="input-name">댓글 작성자 이름</label>
                  <input type="text" name="name" value="" id="input-name" class="form-control" />
                </div>
              </div>
              <div class="form-group required">
                <div class="col-sm-12">
                  <label class="control-label" for="input-review">댓글 작성내용</label>
                  <textarea name="text" rows="5" id="input-review" class="form-control"></textarea>
                </div>
              </div>
              
              <div class="form-group required">
                <div class="col-sm-12">
                  <label class="control-label">평점</label>
                  &nbsp;&nbsp;&nbsp; Bad&nbsp;
                  <input type="radio" name="rating" value="1" />
                  &nbsp;
                  <input type="radio" name="rating" value="2" />
                  &nbsp;
                  <input type="radio" name="rating" value="3" />
                  &nbsp;
                  <input type="radio" name="rating" value="4" />
                  &nbsp;
                  <input type="radio" name="rating" value="5" />
                  &nbsp;Good
               </div>
              </div>
              <div class="buttons clearfix">
                <div class="pull-right">
                  <button type="button" id="button-review" data-loading-text="Loading..." class="btn btn-primary">댓글등록(continue)</button>
                </div>
              </div>
            </form>
          </div>
        </div>
      </div>
      
      <!-- 비슷한 상품 추천 -->
      <h3 class="productblock-title">Related Products</h3>
      <div class="box">
        <div id="related-slidertab" class="row owl-carousel product-slider">
        
        <!-- 상품 1 -->
          <div class="item">
            <div class="product-thumb transition">
              <div class="image product-imageblock"> <a href="#"> <img src="image/product/pro-1-220x294.jpg" alt="women's New Wine is an alcoholic" title="women's New Wine is an alcoholic" class="img-responsive" /> </a>
                <div class="button-group">
                  <button type="button" class="wishlist" data-toggle="tooltip" title="Add to Wish List"><i class="fa fa-heart-o"></i></button>
                  <button type="button" class="addtocart-btn">Add to Cart</button>
                  <button type="button" class="compare" data-toggle="tooltip" title="Compare this Product"><i class="fa fa-exchange"></i></button>
                </div>
              </div>
              <div class="caption product-detail">
                <h4 class="product-name"><a href="product.html" title="women's New Wine is an alcoholic">women's New Wine is an alcoholic</a></h4>
                <p class="price product-price"> <span class="price-new">$254.00</span> <span class="price-old">$272.00</span> <span class="price-tax">Ex Tax: $210.00</span> </p>
              </div>
              <div class="button-group">
                <button type="button" class="wishlist" data-toggle="tooltip" title="Add to Wish List"><i class="fa fa-heart-o"></i></button>
                <button type="button" class="addtocart-btn">Add to Cart</button>
                <button type="button" class="compare" data-toggle="tooltip" title="Compare this Product"><i class="fa fa-exchange"></i></button>
              </div>
            </div>
          </div>
          
          <!-- 상품 2 -->
          <div class="item">
            <div class="product-thumb transition">
              <div class="image product-imageblock"> <a href="#"> <img src="image/product/pro-2-220x294.jpg" alt="women's New Wine is an alcoholic" title="women's New Wine is an alcoholic" class="img-responsive" /> </a>
                <div class="button-group">
                  <button type="button" class="wishlist" data-toggle="tooltip" title="Add to Wish List"><i class="fa fa-heart-o"></i></button>
                  <button type="button" class="addtocart-btn">Add to Cart</button>
                  <button type="button" class="compare" data-toggle="tooltip" title="Compare this Product"><i class="fa fa-exchange"></i></button>
                </div>
              </div>
              <div class="caption product-detail">
                <h4 class="product-name"><a href="product.html" title="women's New Wine is an alcoholic">women's New Wine is an alcoholic</a></h4>
                <p class="price product-price"> <span class="price-new">$254.00</span> <span class="price-old">$272.00</span> <span class="price-tax">Ex Tax: $210.00</span> </p>
              </div>
              <div class="button-group">
                <button type="button" class="wishlist" data-toggle="tooltip" title="Add to Wish List"><i class="fa fa-heart-o"></i></button>
                <button type="button" class="addtocart-btn">Add to Cart</button>
                <button type="button" class="compare" data-toggle="tooltip" title="Compare this Product"><i class="fa fa-exchange"></i></button>
              </div>
            </div>
          </div>
          
          <!-- 상품 3 -->
          <div class="item">
            <div class="product-thumb transition">
              <div class="image product-imageblock"> <a href="#"> <img src="image/product/pro-3-220x294.jpg" alt="women's New Wine is an alcoholic" title="women's New Wine is an alcoholic" class="img-responsive" /> </a>
                <div class="button-group">
                  <button type="button" class="wishlist" data-toggle="tooltip" title="Add to Wish List"><i class="fa fa-heart-o"></i></button>
                  <button type="button" class="addtocart-btn">Add to Cart</button>
                  <button type="button" class="compare" data-toggle="tooltip" title="Compare this Product"><i class="fa fa-exchange"></i></button>
                </div>
              </div>
              <div class="caption product-detail">
                <h4 class="product-name"><a href="product.html" title="women's New Wine is an alcoholic">women's New Wine is an alcoholic</a></h4>
                <p class="price product-price"> <span class="price-new">$254.00</span> <span class="price-old">$272.00</span> <span class="price-tax">Ex Tax: $210.00</span> </p>
              </div>
              <div class="button-group">
                <button type="button" class="wishlist" data-toggle="tooltip" title="Add to Wish List"><i class="fa fa-heart-o"></i></button>
                <button type="button" class="addtocart-btn">Add to Cart</button>
                <button type="button" class="compare" data-toggle="tooltip" title="Compare this Product"><i class="fa fa-exchange"></i></button>
              </div>
            </div>
          </div>
          
          <!-- 상품 4 -->
          <div class="item">
            <div class="product-thumb transition">
              <div class="image product-imageblock"> <a href="#"> <img src="image/product/pro-4-220x294.jpg" alt="women's New Wine is an alcoholic" title="women's New Wine is an alcoholic" class="img-responsive" /> </a>
                <div class="button-group">
                  <button type="button" class="wishlist" data-toggle="tooltip" title="Add to Wish List"><i class="fa fa-heart-o"></i></button>
                  <button type="button" class="addtocart-btn">Add to Cart</button>
                  <button type="button" class="compare" data-toggle="tooltip" title="Compare this Product"><i class="fa fa-exchange"></i></button>
                </div>
              </div>
              <div class="caption product-detail">
                <h4 class="product-name"><a href="product.html" title="women's New Wine is an alcoholic">women's New Wine is an alcoholic</a></h4>
                <p class="price product-price"> <span class="price-new">$254.00</span> <span class="price-old">$272.00</span> <span class="price-tax">Ex Tax: $210.00</span> </p>
              </div>
              <div class="button-group">
                <button type="button" class="wishlist" data-toggle="tooltip" title="Add to Wish List"><i class="fa fa-heart-o"></i></button>
                <button type="button" class="addtocart-btn">Add to Cart</button>
                <button type="button" class="compare" data-toggle="tooltip" title="Compare this Product"><i class="fa fa-exchange"></i></button>
              </div>
            </div>
          </div>
          
          <!-- 상품 5 -->
          <div class="item">
            <div class="product-thumb transition">
              <div class="image product-imageblock"> <a href="#"> <img src="image/product/pro-5-220x294.jpg" alt="women's New Wine is an alcoholic" title="women's New Wine is an alcoholic" class="img-responsive" /> </a>
                <div class="button-group">
                  <button type="button" class="wishlist" data-toggle="tooltip" title="Add to Wish List"><i class="fa fa-heart-o"></i></button>
                  <button type="button" class="addtocart-btn">Add to Cart</button>
                  <button type="button" class="compare" data-toggle="tooltip" title="Compare this Product"><i class="fa fa-exchange"></i></button>
                </div>
              </div>
              <div class="caption product-detail">
                <h4 class="product-name"><a href="product.html" title="women's New Wine is an alcoholic">women's New Wine is an alcoholic</a></h4>
                <p class="price product-price"> <span class="price-new">$254.00</span> <span class="price-old">$272.00</span> <span class="price-tax">Ex Tax: $210.00</span> </p>
              </div>
              <div class="button-group">
                <button type="button" class="wishlist" data-toggle="tooltip" title="Add to Wish List"><i class="fa fa-heart-o"></i></button>
                <button type="button" class="addtocart-btn">Add to Cart</button>
                <button type="button" class="compare" data-toggle="tooltip" title="Compare this Product"><i class="fa fa-exchange"></i></button>
              </div>
            </div>
          </div>
          
          <!-- 상품 6 -->
          <div class="item">
            <div class="product-thumb transition">
              <div class="image product-imageblock"> <a href="#"> <img src="image/product/pro-6-220x294.jpg" alt="women's New Wine is an alcoholic" title="women's New Wine is an alcoholic" class="img-responsive" /> </a>
                <div class="button-group">
                  <button type="button" class="wishlist" data-toggle="tooltip" title="Add to Wish List"><i class="fa fa-heart-o"></i></button>
                  <button type="button" class="addtocart-btn">Add to Cart</button>
                  <button type="button" class="compare" data-toggle="tooltip" title="Compare this Product"><i class="fa fa-exchange"></i></button>
                </div>
              </div>
              <div class="caption product-detail">
                <h4 class="product-name"><a href="product.html" title="women's New Wine is an alcoholic">women's New Wine is an alcoholic</a></h4>
                <p class="price product-price"> <span class="price-new">$254.00</span> <span class="price-old">$272.00</span> <span class="price-tax">Ex Tax: $210.00</span> </p>
              </div>
              <div class="button-group">
                <button type="button" class="wishlist" data-toggle="tooltip" title="Add to Wish List"><i class="fa fa-heart-o"></i></button>
                <button type="button" class="addtocart-btn">Add to Cart</button>
                <button type="button" class="compare" data-toggle="tooltip" title="Compare this Product"><i class="fa fa-exchange"></i></button>
              </div>
            </div>
          </div>
          
          <!-- 상품 7 -->
          <div class="item">
            <div class="product-thumb transition">
              <div class="image product-imageblock"> <a href="#"> <img src="image/product/pro-7-220x294.jpg" alt="women's New Wine is an alcoholic" title="women's New Wine is an alcoholic" class="img-responsive" /> </a>
                <div class="button-group">
                  <button type="button" class="wishlist" data-toggle="tooltip" title="Add to Wish List"><i class="fa fa-heart-o"></i></button>
                  <button type="button" class="addtocart-btn">Add to Cart</button>
                  <button type="button" class="compare" data-toggle="tooltip" title="Compare this Product"><i class="fa fa-exchange"></i></button>
                </div>
              </div>
              <div class="caption product-detail">
                <h4 class="product-name"><a href="product.html" title="women's New Wine is an alcoholic">women's New Wine is an alcoholic</a></h4>
                <p class="price product-price"> <span class="price-new">$254.00</span> <span class="price-old">$272.00</span> <span class="price-tax">Ex Tax: $210.00</span> </p>
              </div>
              <div class="button-group">
                <button type="button" class="wishlist" data-toggle="tooltip" title="Add to Wish List"><i class="fa fa-heart-o"></i></button>
                <button type="button" class="addtocart-btn">Add to Cart</button>
                <button type="button" class="compare" data-toggle="tooltip" title="Compare this Product"><i class="fa fa-exchange"></i></button>
              </div>
            </div>
          </div>
          
        </div>
      </div>
      
      
    </div>
  </div>
</div>

</section>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>