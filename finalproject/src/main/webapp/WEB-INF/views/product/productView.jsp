<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=30a3285db1175ba90bd73c4b0460f5a9&libraries=services"></script>
<script>
$(function() {
	//대댓글 작성 글자수 제한
	$('input[type=text], textarea').on('keyup', function() {
		if (this.value.length > 600) {
			alert("300자 까지만 입력해 주세요.");
			this.value = this.value.substring(0, 600);
			this.focus();
		}
	});
	
	$('#input-quantity').keyup(function(e){
		if(!((e.keyCode > 95 && e.keyCode < 106)|| (e.keyCode > 47 && e.keyCode < 58)|| e.keyCode == 8)) {
			alert('숫자만 입력해주세요');
			return false;
		}
		
		if($('#input-quantity').val()==""){
			alert('수량을 입력해주세요');
			return false;
		}
	});
		
	
	
	var type = '${type}';
	if (type == 'R') {
		$("#li-description").attr('class', '');
		$("#li-review").attr('class', 'active');
		$("#li-question").attr('class', '');
		$("#li-sallerInfo").attr('class', '');

		$("#tab-description").attr('class', 'tab-pane');
		$("#tab-review").attr('class', 'tab-pane active');
		$("#tab-question").attr('class', 'tab-pane');
		$("#tab-sallerInfo").attr('class', 'tab-pane');
	} else if (type == 'Q') {
		$("#li-description").attr('class', '');
		$("#li-review").attr('class', '');
		$("#li-question").attr('class', 'active');
		$("#li-sallerInfo").attr('class', '');

		$("#tab-description").attr('class', 'tab-pane');
		$("#tab-review").attr('class', 'tab-pane');
		$("#tab-question").attr('class', 'tab-pane active');
		$("#tab-sallerInfo").attr('class', 'tab-pane');
	} else {
		$("#li-description").attr('class', 'active');
		$("#li-review").attr('class', '');
		$("#li-question").attr('class', '');
		$("#li-sallerInfo").attr('class', '');

		$("#tab-description").attr('class', 'tab-pane active');
		$("#tab-review").attr('class', 'tab-pane');
		$("#tab-question").attr('class', 'tab-pane');
		$("#tab-sallerInfo").attr('class', 'tab-pane');
	};
	
		/* if(stock < qty){
			alert('남은 수량보다 더 주문해서 주문이 안됩니다.');
			return false;
		}else{
			return true;
		} */
});

function productCheck(){
	
	var qty = Number($('input[name=productQty]').val());
	var productNo = $('#input-productNo').val();
	var tab = $('#tab').val();
	/* var price = ;
	var option = ; */
	

	$.ajax({
		url : "${path}/product/selectProductCheck.do",
		data : {
			"productNo" : productNo,
			"qty" : qty
		},
		success : function(data) {
			//해당 max 값이 보다 더 큰 경우
			
			if(data.state == "F"){
				alert('주문에 실패 하였습니다.');
				location.href="${path}/product/productView.do?productNo="+productNo+"&tab="+tab;
				
			}else{
				alert('결제페이지로 이동합니다.');
				$('#productViewFrm').submit();
			}
		}
	});
};

function fn_sallerInfo() {
	var addr = $('#addr').val();
	var title = $('#brandTitle').val();
	console.log(addr);
	console.log(title);
	var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	mapOption = {
		center : new daum.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
		level : 3
	// 지도의 확대 레벨
	};

	// 지도를 생성합니다    
	var map = new daum.maps.Map(mapContainer, mapOption);

	// 주소-좌표 변환 객체를 생성합니다
	var geocoder = new daum.maps.services.Geocoder();

	// 주소로 좌표를 검색합니다
	geocoder.addressSearch(addr,function(result, status) {
		// 정상적으로 검색이 완료됐으면 
		if (status === daum.maps.services.Status.OK) {

			var coords = new daum.maps.LatLng(result[0].y,result[0].x);

			// 결과값으로 받은 위치를 마커로 표시합니다
			var marker = new daum.maps.Marker({
				map : map,
				position : coords
			});

			// 인포윈도우로 장소에 대한 설명을 표시합니다
			var infowindow = new daum.maps.InfoWindow(
			{
				content : '<div style="width:150px;text-align:center;padding:6px 0;">'+ title + '</div>'
			});
			infowindow.open(map, marker);

			mapContainer.style.width = '600px';
			mapContainer.style.height = '200px';

			map.relayout();

			// 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
			map.setCenter(coords);
		}
	});
};

function fn_wishCk() {
	var wishBtn = $('#wishBtn');
	var wishCount = $('input[name=wishCount]').val();
	var productNo = $('#input-productNo').val();
	$.ajax({
		url : "${path}/product/selectWish.do",
		data : {
			"productNo" : productNo,
			"wishCount" : wishCount
		},
		success : function(data) {
			console.log(data);
			console.log(wishBtn);
			if (data["wishCount"] == 0) {
				wishBtn.html('<i class="fa fa-heart-o"></i>');
				$('input[name=wishCount]').val(data["wishCount"]);
			}
			if (data["wishCount"] != 0) {
				wishBtn.html('<i class="fa fa-heart"></i>');
				$('input[name=wishCount]').val(data["wishCount"]);
			}
		}
	});
};

function fn_description() {
	/* event.preventDefault(); */
	var productNo = $('#input-productNo').val();
	var productinfoContent = $('#productinfoContent');
	$.ajax({
		url : "${path}/product/productDetail.do",
		data : {
			"productNo" : productNo
		},
		success : function(data) {
			$('#descript').attr('href', "#tab-description");
			productinfoContent.html(data["PRODUCT_DETAIL"]);

			return true;
		}
	});
};

function fn_noLogin() {
	location.href = '${path}/member/memberLogin.do';
}

function fn_noLoginComment() {
	alert('로그인 후 이용가능한 서비스 입니다.');
	location.href = '${path}/member/memberLogin.do';
}

function fn_tabChanged(type) {
	var tab = $('#tab').val();
	
	location.href = "${path}/product/productView.do?commentType=" + type
			+ "&productNo=" + '${product.PRODUCT_NO}'+"&tab="+tab;

}

function fn_insertReviewCommentLevel1() {
	var productNo = $('#input-productNo').val();
	var orderNo = $('#orderList').val();
	$('#input-reviewCommentProductNo').val(productNo);
	$('#input-reviewOrderNo').val(orderNo);
	var content = $('#input-review').val();
	console.log(content);

	if(content.trim().length < 1){ 
		alert('내용을 넣어주세요');
		return false;
	}
	
	$('#commentReview').submit();
};

function fn_insertQuestionComment() {
	var productNo = $('#input-productNo').val();
	var questionContent = $('#input-question').val();
	var tab = $('#tab').val();
	
	if(questionContent.trim().length<1){
		alert('문의 내용을 입력해주세요');
		return false;
	}
	$('#input-questionTab').val(tab);
	$('#input-questionCommentProductNo').val(productNo);
	$('#commentQuestion').submit();
};

function fn_reviewComment(commentNo){
	console.log(commentNo);
	$('#'+commentNo).attr('style','display:none');
	$('#input-'+commentNo).attr('type','text');
	$('#btn-'+commentNo).attr('style','display:inline; padding-top:0; padding-bottom:0');
};

function fn_updateReviewComment(inputCommentNo, inputCommentContent){
	console.log(inputCommentNo);
	console.log(inputCommentContent);
	var commentNo = $('#' + inputCommentNo).val();
	var commentContent = $('#input-'+inputCommentContent).val();
	var commentType = $('input[name=commentType]').val();
	
	if(commentContent.trim().length<1){
		alert('내용을 입력해주세요');
		return false;
	}
	console.log(commentType);
	console.log(commentNo);
	console.log(commentContent);
	$.ajax({
		url : "${path}/product/updateReviewComment.do",
		data : {
			"commentNo" : commentNo,
			"commentContent": commentContent,
			"commentType" : commentType
		},
		success : function(data) {
			console.log(data);
			$('#'+inputCommentContent).text(commentContent);
			$('#'+inputCommentContent).attr('style','display:""');
			$('#input-'+inputCommentContent).attr('type','hidden');
			$('#btn-'+inputCommentContent).attr('style','display:none');
		}
	});
};

function fn_deleteComment(inputComment, tab){
	var commentNo = $('#'+inputComment).val();
	var commentType = $('input[name=commentType]').val();
	var productNo = $('#input-productNo').val();
	
	console.log(commentNo);
	console.log(commentType);
	if(tab!=null){
		location.href="${path}/product/deleteComment?commentNo="+commentNo+"&commentType="+commentType+"&productNo="+productNo+"&tab="+tab;
	}
	/* location.href="${path}/product/deleteComment?commentNo="+commentNo+"&commentType="+commentType+"&productNo="+productNo; */
};

function fn_deleteQuestionComment(inputComment){
	var commentNo = $('#'+inputComment).val();
	var commentType = $('input[name=questionCommentType]').val();
	var productNo = $('#input-productNo').val();
	console.log(commentNo);
	console.log(commentType);
	var tab = $('#tab').val();
	
	
	if(tab!=null){
		
		location.href="${path}/product/deleteComment?commentNo="+commentNo+"&commentType="+commentType+"&productNo="+productNo+"&tab="+tab;
	}
	/* location.href="${path}/product/deleteComment?commentNo="+commentNo+"&commentType="+commentType+"&productNo="+productNo; */	
};

function fn_imageViewChange(subImg){
	$("#product-main-img").attr("src", "${path }/resources/image/product/" + subImg);
}
</script>

<style>
.display-inline {
	display: inline;
}

.reply-sm-10 {
	float: right;
	padding-right: 0px;
}

.btn-reply {
	padding: 6px 18px 4px;
}

.btn-warning {
	background-image: linear-gradient(to bottom, #b9b9b9, #afaaaa);
}

.float-right {
	float: right;
}
</style>

<section class="product col-2 left-col">
<!-- <div class="preloader loader" style="display: block; background:#f2f2f2;"> <img src="image/loader.gif"  alt="#"/></div> -->
<div class="container">
  <ul class="breadcrumb">
    <li><a href="/makers"><i class="fa fa-home"></i></a></li>
    <c:choose>
    	<c:when test="${tab eq 'p'}">
    		<li><a href="${path }/product/preList.do">입점예정</a></li>
    	</c:when>
    	<c:when test="${tab eq 'n' }">
    		<li><a href="${path }/product/newList.do">신규</a></li>
    	</c:when>
    	<c:when test="${tab eq 'b' }">
    		<li><a href="${path }/product/bestList.do">베스트</a></li>
    	</c:when>
    	<c:otherwise>
    		<li><a href="${path }/product/category.do?category=${product.BC_NO }">${bcTitle }</a></li>
    	</c:otherwise>
    </c:choose>
    <li><a href="javascript:void(0)">${product.PRODUCT_TITLE }</a></li>
  </ul>
  
  <!-- nav -->
  <div class="row">
    <div id="column-left" class="col-sm-3 hidden-xs column-left">
<%--     <c:choose>
    	<c:when test="${tab eq 'n' or tab eq 'p' }"></c:when>
     	<c:when test="${tab eq 'b'}">
    		<div class="column-block">
	        <div class="column-block">
	          <div class="columnblock-title">${bcTitle }</div>
	          <div class="category_block">
	            <ul class="box-category treeview-list treeview">
	            <c:forEach items="${scList }" var="sc"> 
	                 <li><a href="${path }/product/bestList.do?category=${sc.bcNo}&sc=${sc.scNo}&best=best&tab=b">${sc.scTitle}</a></li>
	              </c:forEach>
	           </ul>
	          </div>
	        </div>
	       </div>
    	</c:when> 
     	<c:otherwise>
      <div class="column-block">
        <div class="column-block">
          <div class="columnblock-title">${bcTitle }</div>
          <div class="category_block">
            <ul class="box-category treeview-list treeview">
            <c:forEach items="${scList }" var="sc"> 
                 <li><a href="${path }/product/category.do?category=${sc.bcNo}&sc=${sc.scNo}">${sc.scTitle}</a></li>
              </c:forEach>
           </ul>
          </div>
        </div>
       </div>
       </c:otherwise>
       </c:choose> --%>
       </div>

    <div id="content" class="col-sm-9">
      <div class="row">       
        <!-- 상세 상품 사진 넣는 곳 시작 -->
        <div class="col-sm-6">       
          <div class="thumbnails">        
            <div><a class="thumbnail" href="javascript:void(0)" title="상품 프로필 사진"><img src="${path }/resources/image/product/${product.PRODUCT_PROFILE}" title="상품 프로필 사진" alt="상품 프로필 사진" style="width:460px;height:484.531px;" id="product-main-img"/></a></div>       
            <div id="product-thumbnail" class="owl-carousel">          
	              <div class="item">
               		 <div class="image-additional"><a class="thumbnail  " href="javascript:void(0)" title="상품 프로필사진"> <img src="${path }/resources/image/product/${product.PRODUCT_PROFILE}" title="상품 프로필 사진" alt="상품 프로필 사진" style="width:76px;height:80.141px;" onclick="fn_imageViewChange('${product.PRODUCT_PROFILE}');"/></a></div>
                 </div>
              
              <c:forEach items="${productImg }" var="pi">
                 <div class="item">
                   <div class="image-additional"><a class="thumbnail  " href="javascript:void(0)" title="상품 서브사진" > <img src="${path }/resources/image/product/${pi.productSubImg}" title="상품 서브 사진" alt="상품 서브 사진" style="width:76px;height:80.141px;" onclick="fn_imageViewChange('${pi.productSubImg}');" id="product-sub-img"/></a></div>
                 </div>
              </c:forEach>
            </div>
          </div>
        </div>
        <!-- 상세 상품 사진 넣는 곳 끝 -->
        
        <!-- 상품 설명 -->
        <div class="col-sm-6">
        <form id="productViewFrm" action="${path }/order/orderEnroll.do?tab=${tab}" method="post">
          <h1 class="productpage-title">${product.PRODUCT_TITLE }</h1>
          <ul class="list-unstyled productinfo-details-top">
            <li>
            <!-- 별점 -->
                           평점 : <%-- ${score.SCORE } --%>
            <c:if test="${score.SCORE ge 0 and score.SCORE lt 0.5 }">
            	<i class="far fa-star"></i><i class="far fa-star"></i><i class="far fa-star"></i><i class="far fa-star"></i><i class="far fa-star"></i>
            </c:if>
            <c:if test="${score.SCORE ge 0.5 and score.SCORE lt 1}">
            	<i class="fas fa-star-half-alt"></i><i class="far fa-star"></i><i class="far fa-star"></i><i class="far fa-star"></i><i class="far fa-star"></i>
            </c:if>
            <c:if test="${score.SCORE ge 1 and score.SCORE lt 1.5}">
            	<i class="fas fa-star"></i><i class="far fa-star"></i><i class="far fa-star"></i><i class="far fa-star"></i><i class="far fa-star"></i>
            </c:if>
            <c:if test="${score.SCORE ge 1.5 and score.SCORE lt 2}">
            	<i class="fas fa-star"></i><i class="fas fa-star-half-alt"></i><i class="far fa-star"></i><i class="far fa-star"></i><i class="far fa-star"></i>
            </c:if>
            <c:if test="${score.SCORE ge 2 and score.SCORE lt 2.5}">
            	<i class="fas fa-star"></i><i class="fas fa-star"></i><i class="far fa-star"></i><i class="far fa-star"></i><i class="far fa-star"></i>
            </c:if>
            <c:if test="${score.SCORE ge 2.5 and score.SCORE lt 3}">
            	<i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star-half-alt"></i><i class="far fa-star"></i><i class="far fa-star"></i>
            </c:if>
            <c:if test="${score.SCORE ge 3 and score.SCORE lt 3.5}">
            	<i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="far fa-star"></i><i class="far fa-star"></i>
            </c:if>
            <c:if test="${score.SCORE ge 3.5 and score.SCORE lt 4}">
            	<i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star-half-alt"></i><i class="far fa-star"></i>
            </c:if>
            <c:if test="${score.SCORE ge 4 and score.SCORE lt 4.5}">
            	<i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="far fa-star"></i>
            </c:if>
            <c:if test="${score.SCORE ge 4.5 and score.SCORE lt 5}">
            	<i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star-half-alt"></i>
            </c:if>
            <c:if test="${score.SCORE eq 5}">
            	<i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i>
            </c:if>
            
              <h2 class="productpage-price">( 누적 판매량 : ${product.PRODUCT_TOTALSELL } ) </h2>
            </li>
          </ul>             
          <hr>
          <ul class="list-unstyled productinfo-details-top">
            <li>
            <!-- 가격 -->
            <c:if test="${product.PRODUCT_STEP ne 0 }">
            	<h2 class="productpage-price">가격 : <fmt:formatNumber value="${product.PRODUCT_PRICE}" type="currency" currencySymbol="￦"/></h2>
              	<input type="hidden" name="productPrice" value="${product.PRODUCT_PRICE }"/>
            </c:if>
            <c:if test="${product.PRODUCT_STEP eq 0 }">
              <h2 class="productpage-price">가격 : <fmt:formatNumber value="${product.SALES}" type="currency" currencySymbol="￦"/></h2>
              <input type="hidden" name="productPrice" value="${product.SALES }"/>
            </c:if>
            </li>
            <c:if test="${product.PRODUCT_STEP eq 0 and product.PRODUCT_DISCOUNT ne 0}">
               <!-- 세금 내역 -> 이벤트 할인 가 넣으면 될듯 -->
               <li><span class="productinfo-tax"><fmt:formatNumber value="${product.PRODUCT_DISCOUNT }"/>%</span></li>
            </c:if>
          </ul>
          <hr>
          
          <ul class="list-unstyled product_info">
            <li>
              <label>최소수량:</label>
              <span> ${product.PRODUCT_MIN }</span></li>
            <li>
              <label>최대수량:</label>
              <span> ${product.PRODUCT_MAX }</span></li>
            <li>
              <label>현재 판매량 : </label>
              <span> ${product.PRODUCT_CURSELL }</span></li>
              <c:choose>
              <c:when test="${product.PRODUCT_STATE ne 0}">
              	<li>
              	<label>남은 수량 : </label>
              	<span style="color:red"> 0개</span></li>
              </c:when>
              <c:when test="${product.PRODUCT_STATE eq 0 }">
              	<li>
              	<label>남은 수량 : </label>
              	<span style="color:red"> ${product.REMAININVENTORY }개</span></li>
              </c:when>
              </c:choose>    
          </ul>
          
          <hr/>
          <ul class="list-unstyled product_info">
            <li>
              <label>판매시작일:</label>
              <span><fmt:formatDate value="${product.PRODUCT_UPDATE }" pattern="yyyy-MM-dd"/></span>
              </li>
            <li>
              <label>판매종료일:</label>
              <span><fmt:formatDate value="${product.PRODUCT_ENDDATE }" pattern="yyyy-MM-dd"/></span></li>
            <c:choose>
            	<c:when test="${product.PRODUCT_STATE eq 3}">
            	<li>
	              <label>판매 남은일:</label>
	              <span id="remainperiod" style="color:red">판매가 완료된 상품입니다.</span></li>
	           </c:when>
	           <c:when test="${product.PRODUCT_STATE eq 1}">
            	<li>
	              <label>판매 남은일:</label>
	              <span id="remainperiod" style="color:red">판매중지가 요청된 상품입니다.</span></li>
	           </c:when>
	           <c:when test="${product.PRODUCT_STATE eq 2}">
            	<li>
	              <label>판매 남은일:</label>
	              <span id="remainperiod" style="color:red">판매중지 상품입니다.</span></li>
	           </c:when>
	           <c:when test="${product.PRODUCT_STATE eq 4}">
            	<li>
	              <label>판매 남은일:</label>
	              <span id="remainperiod" style="color:red">재판매가 요청된 상품입니다.</span></li>
	           </c:when>
	           <c:when test="${product.PRODUCT_STATE eq 0 }">
	            <li>
	            <label>판매 남은일:</label>
	            <span id="remainperiod" style="color:red">${product.REMAINPERIOD }일</span></li>
	           </c:when>
            </c:choose>
          </ul>
          <hr/>
             
          <p class="product-desc">${product.PRODUCT_COMMENT }</p>
          <div id="product">
            <div class="form-group">
               <select class="form-control" name="productOption" id="select-productOption">
                   <c:forEach var="option" items="${productOption }">
                      <option id="productOptionTag" value="${option.PRODUCT_OPTION_NO }">${option.PRODUCT_OPTION }</option>
                   </c:forEach>
                </select>
            </div>
            
            <div class="form-group">
              <label class="control-label qty-label" for="input-qty">수량</label>
              <input type="number" name="productQty" value="1" min="1" size="10" max="${product.REMAININVENTORY }" id="input-quantity" class="form-control productpage-qty" style="width:100px"/>
              <input type="hidden" name="tab" id="tab" value="${tab }"/>
              <input type="hidden" name="productNo" id="input-productNo" value="${product.PRODUCT_NO }"/>
              <input type="hidden" name="brandNo" value="${product.BRAND_NO }"/>
              <input type="hidden" name="wishCount" value="${wishCount }"/>
              <%-- <input type="hidden" name="cPage" id="cPage" value="${cPage }"/> --%>
              <input type="hidden" name="productTitle" value="${product.PRODUCT_TITLE }"/>

             
              <div class="btn-group" id="divBtn">
              
              <!-- 찜 버튼 ajax 처리 wish list 저장 -->
              <!-- data-toggle="tooltip"은 호버 했'을 경우 title의 내용이 말 풍선으로 나옴 -->
              <c:if test="${member!=null }">
              <c:if test="${wishCount eq 1}">
                <button type="button" id="wishBtn" data-toggle="tooltip" class="btn btn-default wishlist" title="Add to Wish List" onclick="fn_wishCk();">
                   <i class="fa fa-heart"></i>
                  </button>
               </c:if>
               <c:if test="${wishCount eq 0}">
                <button type="button" id="wishBtn" data-toggle="tooltip" class="btn btn-default wishlist" title="Add to Wish List" onclick="fn_wishCk();">
                   <i class="fa fa-heart-o"></i>
                  </button>
               </c:if>
               </c:if>
               
               <c:if test="${member==null}">
                <button type="submit" id="wishBtnNologin" data-toggle="tooltip" class="btn btn-default wishlist" title="Add to Wish List" onclick="fn_noLogin();">
                   <i class="fa fa-heart-o"></i>
                  </button>
               </c:if>
               
                <!-- 결제 버튼 -->
                <c:choose>
                <c:when test="${product.PRODUCT_STATE ne 0 }">
                	<input type="submit" id="orderBtn" class="btn btn-primary btn-lg btn-block addtocart" value="결제하기" disabled/>
                </c:when>
                <c:otherwise>
                <c:if test="${member==null }">
                <input type="submit" id="orderBtn" class="btn btn-primary btn-lg btn-block addtocart" value="결제하기" onclick="fn_noLogin();"/>
                <!-- <button type="button" data-toggle="tooltip" class="btn btn-default compare" title="Compare this Product" ><i class="fa fa-exchange"></i></button> -->
                </c:if>
	                <c:choose>
	                <c:when test="${member!=null }"> 
	                	<c:choose>
	                	<c:when test="${member.memberAuthority eq 'A' }">
	                		<input type="submit" id="orderBtn" class="btn btn-primary btn-lg btn-block addtocart" value="결제하기" disabled/>
	                	</c:when>	                              	
	                	<c:when test="${member.memberAuthority ne 'A' }">
	                		<input type="button" id="orderBtn" class="btn btn-primary btn-lg btn-block addtocart" onclick="return productCheck();" value="결제하기"/>
	                	</c:when>
	                	</c:choose>
	                </c:when>
	                </c:choose>
	                </c:otherwise>
                </c:choose>
              </div>
            </div>
          </div>
          </form>
        </div>
      </div>
      
      <!-- 상품 설명//댓글 창 List-->
      <div class="productinfo-tab">
        <ul class="nav nav-tabs">
          <li class="active" id="li-description">
             <a href="#tab-description" data-toggle="tab" onclick="fn_description();" id="descript">상세설명</a>
          </li>
          <li id="li-review"><a href="#tab-review" data-toggle="tab" onclick="fn_tabChanged('R');">상품후기</a></li> <!-- onclick="fn_review();" 모두 셀렉트로 가져옴 -->
          <li id="li-question"><a href="#tab-question" data-toggle="tab" id="product-question" onclick="fn_tabChanged('Q');">상품문의</a></li>
          <li id=""><a href="#tab-sallerInfo" data-toggle="tab" id="product-sallerInfo" onclick="fn_sallerInfo();">판매자 정보</a></li>   
        </ul>
        <input type="hidden" name="review" value="R"/>
        <input type="hidden" name="question" value="Q"/>
        
        <!-- 상품 설명 탭 -->
        <div class="tab-content">
          <div class="tab-pane active" id="tab-description">
            <div class="cpt_product_description ">
              <div id="productinfoContent">
                ${productDetail.PRODUCT_DETAIL }
              </div>
            </div>
            <!-- cpt_container_end -->
            </div>
			
			
          <!-- 후기 댓글 등록 창 -->
         <div class="tab-pane" id="tab-review">
            <div id="reviewComment" class="form-group"> <!-- style="border:1px solid red" -->
               
                <ul class="media-list">
                     <c:if test='${reviewCommentList.size() eq 0 }'>
                        <span id="level1">등록된 상품 후기가 없습니다.
                        </span>
                     </c:if>
                     <c:if test="${reviewCommentList!=null }">
                        <c:forEach items="${reviewCommentList }" var="reviewComment" varStatus="vs">
                        <li class="media">                  
                           <c:if test="${reviewComment.COMMENT_LEVEL eq 1 }">
                           <a class="pull-left" href="javascript:void(0);"> 
                           <c:if test="${member.memberAuthority eq 'A' }">
                              <img class="media-object img-circle" width="100px;" src="${path }/resources/image/adminProfile/${reviewComment['MEMBER_PROFILE']}" alt="profile">
                           </c:if>
                           <c:if test="${member.memberAuthority eq 'M' }">
                              <img class="media-object img-circle" width="100px;" src="${path }/resources/image/memberProfile/${reviewComment['MEMBER_PROFILE']}" alt="profile">
                           </c:if>   
                           </a>
                              <div class="media-body">
                                 <div class="well well-sm">
                                    <h4 class="media-heading text-uppercase reviews display-inline">${reviewComment['MEMBER_NAME'] }</h4>
                                    <ul class="media-date text-uppercase reviews list-inline display-inline">
                                        <li class="dd"><fmt:formatDate value="${reviewComment['COMMENT_DATE'] }" pattern="yyyy MM dd"/></li>
                                    </ul>
                                    <c:if test="${reviewComment['MEMBER_NO'] eq member.memberNo or member.memberAuthority eq 'A'}"> 
                                       <ul class="float-right">
                                       	<li>
                                       	  <c:if test="${member.memberAuthority eq 'M' }">
                                       	  	<a href="javascript:void(0);" onclick="fn_reviewComment('${reviewComment['COMMENT_NO'] }Level1');"><i class="fas fa-pen" style="font-size:15px;"></i></a> &nbsp;
                                          </c:if>
                                            <a href="javascript:void(0);" onclick="fn_deleteComment('inputNo-${reviewComment['COMMENT_NO'] }Level1', '${tab }');"><i class="fas fa-times" style="font-size: 18px;"></i></a>
                                        </li>
                                       </ul>
                                     </c:if>
      
                                    <p class="media-comment" id="${reviewComment['COMMENT_NO'] }Level1">${reviewComment['COMMENT_CONTENT'] }</p>
                                    <input type="hidden" id="input-${reviewComment['COMMENT_NO'] }Level1" style="width:80%;" value="${reviewComment['COMMENT_CONTENT'] }"/>
                                    <input type="button" class="btn btn-primary" id="btn-${reviewComment['COMMENT_NO'] }Level1" value="등록" style="display:none;" onclick="fn_updateReviewComment('inputNo-${reviewComment['COMMENT_NO'] }Level1','${reviewComment['COMMENT_NO'] }Level1')"/><br/>
                                    <input type="hidden" id="inputNo-${reviewComment['COMMENT_NO'] }Level1" name="commentNo" value="${reviewComment['COMMENT_NO'] }"/>
                                    <input type="hidden" name="commentType" value="R"/>
                                    <div>
                                    <a id="btn-comment" class="btn btn-primary btn-circle text-uppercase btn-reply" data-toggle="collapse" href="#${reviewComment['COMMENT_NO']}"> <!--onclick="fn_selectCommentLevel2('${reviewComment.COMMENT_NO}'); -->
                                       <i class="far fa-comment-dots"></i>&nbsp;${reviewComment['CN']}개 comment</a>
                                    </div>
                                 </div>
                              </div>
                        </c:if>
                        
                           <div class="col-sm-11 reply-sm-10 collapse" id="${reviewComment['COMMENT_NO']}"> <!-- {reviewComment['COMMENT_REF']} -->
                              <ul class="media-list">
                              <c:forEach items="${reviewSecondCommentList }" var="second">  <!--  test="${reviewComment.COMMENT_LEVEL eq 2 } -->
                              <c:if test="${second['COMMENT_REF'] eq  reviewComment['COMMENT_NO']}">
	                              <li class="media media-replied">
	                              <a class="pull-left" href="javascript:void(0);"> 
	                              <c:if test="${member.memberAuthority eq 'A' }">
	                                 <img class="media-object img-circle" style="width: 80px;" src="${path }/resources/image/adminProfile/${second['MEMBER_PROFILE']}" alt="profile">
	                              </c:if>
	                              <c:if test="${member.memberAuthority eq 'M' }">
	                              	 <img class="media-object img-circle" style="width: 80px;" src="${path }/resources/image/memberProfile/${second['MEMBER_PROFILE']}" alt="profile">
	                              </c:if>   
	                              </a>
	                                 <div class="media-body">
	                                    <div class="well well-sm">
	                                       <h4 class="media-heading text-uppercase reviews display-inline">${second['MEMBER_NAME'] }</h4>
	                                       <ul class="media-date text-uppercase reviews list-inline display-inline">
	                                          <li class="dd"><fmt:formatDate value="${second['COMMENT_DATE'] }" pattern="yyyy MM dd"/></li>
	                                       </ul>
	                                       
		                                  <c:if test="${second['MEMBER_NO'] eq member.memberNo or member.memberAuthority eq 'A'}"> 
	                                       <ul class="float-right">
	                                       	<li>
	                                       	  <c:if test="${member.memberAuthority eq 'M' }">
	                                       	  	<a href="javascript:void(0);" onclick="fn_reviewComment('${second['COMMENT_NO'] }Level2');"><i class="fas fa-pen" style="font-size: 13px;"></i></a> &nbsp;
	                                          </c:if>
	                                            <a href="javascript:void(0);" onclick="fn_deleteComment('inputNo-${second['COMMENT_NO'] }Level2');"><i class="fas fa-times" style="font-size: 16px;"></i></a>
	                                        </li>
	                                       </ul>
	                                     </c:if>	                                       
	                                    <p class="media-comment" id="${second['COMMENT_NO'] }Level2">${second['COMMENT_CONTENT'] }</p>
	                                    <input type="hidden" id="input-${second['COMMENT_NO'] }Level2" style='width:100%;'value="${second['COMMENT_CONTENT'] }"/>
	                                    <input type="button" class="btn btn-primary" id="btn-${second['COMMENT_NO'] }Level2" value="등록" style="display:none" onclick="fn_updateReviewComment('inputNo-${second['COMMENT_NO'] }Level2','${second['COMMENT_NO'] }Level2')"/>
	                                    <input type="hidden" id="inputNo-${second['COMMENT_NO'] }Level2" name="commentNo" value="${second['COMMENT_NO'] }"/>
	                                    <input type="hidden" name="commentType" value="R"/>	                                      
	                                 </div>
	                              </li>
                              </c:if>
                              </c:forEach>

							  <c:if test="${member!=null}">
                              <!-- 대댓글 작성부분 -->
                              <li class="media media-replied">
                              <form id="fm-${reviewComment['COMMENT_NO'] }" action="${path}/product/insertCommentLevel2.do?productNo=${product.PRODUCT_NO}&tab=${tab}" method="post">
                              <a class="pull-left" href="javascript:void(0);"> 
                              <c:if test="${member.memberAuthority eq 'A' }">
                              	<img class="media-object img-circle" width="80px;" src="${path }/resources/image/adminProfile/${reviewComment['MEMBER_PROFILE']}" alt="profile">
                              </c:if>
                              <c:if test="${member.memberAuthority eq 'M' }">
                                <img class="media-object img-circle" width="80px;" src="${path }/resources/image/memberProfile/${reviewComment['MEMBER_PROFILE']}" alt="profile">
                              </c:if>
                          	  </a>
                                 <div class="media-body">
                                    <div class="well well-sm">
                                       <h4 class="media-heading text-uppercase reviews display-inline">${member.memberName}</h4>
                                       <hr/>
                                        <p class="media-comment">
										 <textarea id="reviewContent${reviewComment['COMMENT_NO'] }" name="reviewContent" class="form-control" style="resize: none; border: 0px;" placeholder="댓글을 작성해주세요"></textarea>
										 <input type="hidden" id="inputRLevel2-${reviewComment['COMMENT_NO'] }" name="commentNo" value="${reviewComment['COMMENT_NO'] }"/>
										</p>
										<hr/>
										<div style="text-align: right;">
                                         <a class="btn btn-primary text-uppercase btn-reply" onclick="fn_insertReviewComment('inputRLevel2-${reviewComment['COMMENT_NO'] }');"><i class="far fa-edit"></i></a>
                                    	</div>
                                    </div>
                                    
                                 </div>
                                 </form>
                              </li>
                              
                              </c:if>
                             </ul>
                    	   </div>
                     </li>
                     </c:forEach>
                  </c:if>
                  </ul>
               
               <div style="text-align: center;">
                  ${pageBar }
               </div>
            </div>
            
            <script>
            	function fn_insertReviewComment(inputCommentNo){
            		console.log(inputCommentNo);
            		var commentNo = $('#'+inputCommentNo).val();
            		var commentContent = $('#reviewContent'+commentNo).val();
            		console.log(commentNo);
            		if(commentContent.trim().length < 1){
            			alert('내용을 입력해주세요');
            			return false;
            		}
            		
            		$('#fm-'+commentNo).submit();
            	};
            
            </script>
            
            <c:if test="${member!=null && orderList[0].ORDER_PAYSTATE ne '2' }">
            <form id="commentReview" class="form-horizontal" action="${path }/product/insertCommentReview.do?tab=${tab}">
              <div  id="div-review">
                 <c:if test="${orderList.size()>0 }">
                 <select class="form-control" id="orderList">
                 <c:forEach items="${orderList }" var="order">
                 <c:if test="${order.ORDER_PAYSTATE ne '2'}">
                    <option value="${order.ORDER_NO }">${order.PRODUCT_TITLE }</option>
                 </c:if>
                 </c:forEach>
                 </select>
                 </c:if>
              </div>
              <div class="form-group required">
                <div class="col-sm-12">
                  <label class="control-label" for="input-name">후기 작성자ID</label>
                  <c:if test="${member != null}">
                     <input type="text" name="name" id="input-name" class="form-control" value="${member.memberName }" readonly/>
                     <input type="hidden" name="memberNo" id="input-memberNo" value="${member.memberNo }"/>
                     <input type="hidden" name="reviewType" value="R"/>
                     <input type="hidden" name="reviewCommentProductNo" id="input-reviewCommentProductNo"/>
                     <input type="hidden" name="orderNo" id="input-reviewOrderNo"/>
                  </c:if>
                </div>
              </div>
              <div class="form-group required">
                <div class="col-sm-12">
                  <label class="control-label" for="input-review">상품 후기</label>
                  <textarea name="reviewContent" rows="5" id="input-review" name="reviewContent" class="form-control"></textarea>
                </div>
              </div>
              
              <div class="form-group required">
                <div class="col-sm-12">
                  <label class="control-label">만족도</label>
                  &nbsp;&nbsp;&nbsp; Bad&nbsp;
                  <input type="radio" name="rating" value="1" />
                  &nbsp;
                  <input type="radio" name="rating" value="2" />
                  &nbsp;
                  <input type="radio" name="rating" value="3" />
                  &nbsp;
                  <input type="radio" name="rating" value="4" />
                  &nbsp;
                  <input type="radio" name="rating" value="5" checked/>
                  &nbsp;Good</div>
              </div>
 
              <div class="buttons clearfix">
                <div class="pull-right">
                  <!-- 구매 완료된 사람들만 글 쓰기 권한!! -->
				    <input type="button" id="button-review" class="btn btn-primary" value="후기등록" onclick="fn_insertReviewCommentLevel1();"/>
                </div>
              </div>
            </form>
            </c:if>
          </div>
          
          <!-- 상품 문의 작성 -->
          <div class="tab-pane" id="tab-question">
            <div id="questionComment" class="form-group"><!--  style="border:1px solid red" -->
                  <ul class="media-list">
             
                     <c:if test='${questionCommentListLv1.size() eq 0 }'>
                        <span id="level1">등록된 상품 문의가 없습니다.</span>
                     </c:if>
                     <c:if test="${questionCommentListLv1!=null }">   
                        <c:forEach items="${questionCommentListLv1 }" var="questionComment" varStatus="vs">  
                        <li class="media">                  
                           <c:if test="${questionComment.COMMENT_LEVEL eq 1 }">
                           <a class="pull-left" href="javascript:void(0);"> 
                           <%-- <c:if test="${member.memberAuthority eq 'A' }">
                              <img class="media-object img-circle" width="100px;" src="${path }/resources/image/adminProfile/${questionComment.MEMBER_PROFILE }" alt="profile">
                           </c:if>
                           <c:if test="${member.memberAuthority eq 'M' }"> --%>
                           <c:if test="${questionComment.MEMBER_AUTHORITY eq 'A' }">
                           	  <img class="media-object img-circle" width="100px;" src="${path }/resources/image/adminProfile/${questionComment.MEMBER_PROFILE }" alt="profile">
                           </c:if>
                           <c:if test="${questionComment.MEMBER_AUTHORITY eq 'M' }">
                              <img class="media-object img-circle" width="100px;" src="${path }/resources/image/memberProfile/${questionComment.MEMBER_PROFILE }" alt="profile">
                           </c:if>
                           <%-- </c:if> --%>
                           </a>
                              <div class="media-body">
                                 <div class="well well-sm">
                                    <h4 class="media-heading text-uppercase reviews display-inline">${questionComment['MEMBER_NAME'] }</h4>
                                    <ul class="media-date text-uppercase reviews list-inline display-inline">
                                       <li class="dd"><fmt:formatDate value="${questionComment['COMMENT_DATE'] }" pattern="yyyy MM dd"/></li>
                                    </ul>
      
                                     <c:if test="${questionComment['MEMBER_NO'] == member.memberNo || member.memberAuthority == 'A'}"> 
                                       <ul class="float-right">
                                       	<li>
                                       	  <c:if test="${member.memberAuthority == 'M' }">
                                       	  	<a href="javascript:void(0);" onclick="fn_reviewComment('${questionComment['COMMENT_NO'] }Level1');"><i class="fas fa-pen" style="font-size: 15px;"></i></a> &nbsp;
                                          </c:if>
                                            <a href="javascript:void(0);" onclick="fn_deleteQuestionComment('inputNo-${questionComment['COMMENT_NO'] }Level1');"><i class="fas fa-times" style="font-size: 18px;"></i></a>
                                        </li>
                                       </ul>
                                     </c:if>
                                    <p class="media-comment" id="${questionComment['COMMENT_NO'] }Level1">${questionComment['COMMENT_CONTENT'] }</p>
                                    <input type="hidden" id="input-${questionComment['COMMENT_NO'] }Level1" style='width:80%;'value="${questionComment['COMMENT_CONTENT'] }"/>
                                    <input type="button" class="btn btn-primary" id="btn-${questionComment['COMMENT_NO'] }Level1" value="등록" style="display:none;" onclick="fn_updateReviewComment('inputNo-${questionComment['COMMENT_NO'] }Level1','${questionComment['COMMENT_NO'] }Level1')"/>
                                    <input type="hidden" id="inputNo-${questionComment['COMMENT_NO'] }Level1" name="commentNo" value="${questionComment['COMMENT_NO'] }"/>
                                    <input type="hidden" name="questionCommentType" value="Q"/>
                                    <!-- <input type="hidden" name="tab" id="tab"/> -->
                                 </div>
                              </div>
                        </c:if>
                        <c:forEach items="${questionCommentListLv2 }" var="questionCommentLv2">
                        <c:if test="${questionCommentLv2.COMMENT_REF eq questionComment.COMMENT_NO }">  
                           <div class="col-sm-11 reply-sm-10">
                              <ul class="media-list">
                              <li class="media media-replied">
                              <a class="pull-left" href="javascript:void(0);"> 
                                 <img class="media-object img-circle" style="width: 80px;" src="${path }/resources/image/memberProfile/seller_img.png" alt="profile">
                              </a>
                                 <div class="media-body">
                                    <div class="well well-sm">
                                       <h4 class="media-heading text-uppercase reviews display-inline">판매자</h4>
                                       <ul class="media-date text-uppercase reviews list-inline display-inline">
                                          <li class="dd"><fmt:formatDate value="${questionCommentLv2['COMMENT_DATE'] }" pattern="yyyy MM dd"/></li>
                                       </ul>
                                       <p class="media-comment">${questionCommentLv2['COMMENT_CONTENT'] }</p>
                                    </div>
                                 </div>
                              </li>
                              </ul>
                           </div>
                        </c:if>
                        </c:forEach>
                        
                     </li>
                     </c:forEach>
                  </c:if>
                  </ul>
               <div style="text-align: center;">
                  ${pageBar }
               </div>
            </div>
            
            <form id="commentQuestion" class="form-horizontal" action="${path }/product/insertCommentQuestion.do?tab=${tab}">
              <div  id="div-review"></div>
              <div class="form-group required">
                <div class="col-sm-12">
                  <label class="control-label" for="input-name">문의 작성자ID</label>
                  <c:if test="${member != null}">
                     <input type="text" name="name" id="input-name" class="form-control" value="${member.memberName }" readonly/>
                     <input type="hidden" name="questionCommentProductNo" id="input-questionCommentProductNo"/>
                     <input type="hidden" name="tab" id="input-questionTab"/>
                     <input type="hidden" name="memberNo" id="input-memberNo" value="${member.memberNo }"/>
                     <input type="hidden" name="commentType" value="Q"/>
                  </c:if>
                </div>
              </div>
              <div class="form-group required">
                <div class="col-sm-12">
                  <label class="control-label" for="input-question">상품 문의</label>
                  <textarea rows="5" id="input-question" name="questionContent" class="form-control"></textarea>
                </div>
              </div>
              
              <div class="buttons clearfix">
                <div class="pull-right">
                  
                  <c:if test="${member==null }">
                     <button type="button" id="button-question" class="btn btn-primary" onclick="fn_noLoginComment();">문의등록</button>
                  </c:if>
                  
                  <c:if test="${member!=null }">
                     <input type="button" id="button-question" class="btn btn-primary" value="문의등록" onclick="fn_insertQuestionComment();"/>
                  </c:if>
                </div>
              </div>
            </form>
          </div>
          
          <!-- 업체 정보 보여주는 곳 -->
          <div class="tab-pane" id="tab-sallerInfo">
            <div class="cpt_product_description ">
            <div class="col-sm-4 left">
              <address>
              <strong> 브랜드 명: </strong>${brand.BRAND_TITLE } <br>
              <br>
              <strong>주소:</strong>
              <div class="address"> ${brand.BRAND_ADDR } ${brand.BRAND_DETAILADDR }</div>
              <input type="hidden" id="addr" value="${brand.BRAND_ADDR }"/>
              <input type="hidden" id="brandTitle" value="${brand.BRAND_TITLE }"/>
              <br>
              </address>
            </div>
            <div class="col-sm-8 right">
                  <div id="map" style="height:200px;width:600px;"></div>
            </div>
            </div>
            </div>
                
      	 </div>  
        
      </div>
          
        </div>
      </div>
</section>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>