<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=30a3285db1175ba90bd73c4b0460f5a9&libraries=services"></script>
<script>
function fn_sallerInfo(){
		var addr = $('#addr').val();
		var title = $('#brandTitle').val();
		console.log(addr);
		console.log(title);
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	    mapOption = {
	        center: new daum.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
	        level: 3 // 지도의 확대 레벨
	    };  
	
	// 지도를 생성합니다    
	var map = new daum.maps.Map(mapContainer, mapOption); 
	
	// 주소-좌표 변환 객체를 생성합니다
	var geocoder = new daum.maps.services.Geocoder();
	
	// 주소로 좌표를 검색합니다
	geocoder.addressSearch(addr, function(result, status) {
		
	    // 정상적으로 검색이 완료됐으면 
	     if (status === daum.maps.services.Status.OK) {
	
	        var coords = new daum.maps.LatLng(result[0].y, result[0].x);
	
	        // 결과값으로 받은 위치를 마커로 표시합니다
	        var marker = new daum.maps.Marker({
	            map: map,
	            position: coords
	        });
	
	        // 인포윈도우로 장소에 대한 설명을 표시합니다
	        var infowindow = new daum.maps.InfoWindow({
	            content: '<div style="width:150px;text-align:center;padding:6px 0;">'+title+'</div>'
	        });
	        infowindow.open(map, marker);
			
	        mapContainer.style.width='600px';
	        mapContainer.style.height='200px';
	        
	        map.relayout();
	        
	        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
	        map.setCenter(coords);
	    } 
	});  
};
	    
</script>

<style>
.display-inline{
   display: inline;
}
.reply-sm-10{
    float: right;
    padding-right: 0px;
}
.btn-reply{
 padding: 6px 18px 4px;
}
.btn-warning{
   background-image: linear-gradient(to bottom, #b9b9b9, #afaaaa);
}
.float-right{
   float: right;
}
</style>
     
<section class="product col-2 left-col">
<!-- <div class="preloader loader" style="display: block; background:#f2f2f2;"> <img src="image/loader.gif"  alt="#"/></div> -->
<div class="container">
  <ul class="breadcrumb">
    <li><a href="/makers"><i class="fa fa-home"></i></a></li>
   <li><a href="${path }/product/category.do?category=${product.BC_NO }">${bcTitle }</a></li>
    <li><a href="javascript:void(0)">${product.PRODUCT_TITLE }</a></li>
  </ul>
  <!-- nav -->
  <div class="row">
    <div id="column-left" class="col-sm-3 hidden-xs column-left">
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
       </div>

    <div id="content" class="col-sm-9">
      <div class="row">
        
        <!-- 상세 상품 사진 넣는 곳 시작 -->
        <div class="col-sm-6">
          
          <div class="thumbnails">
            
            <div><a class="thumbnail" href="${path }/resources/image/product/${product.PRODUCT_PROFILE}" title="lorem ippsum dolor dummy"><img src="${path }/resources/image/product/${product.PRODUCT_PROFILE}" title="lorem ippsum dolor dummy" alt="lorem ippsum dolor dummy" /></a></div>
            
            <div id="product-thumbnail" class="owl-carousel">
            
              <div class="item">
                <div class="image-additional"><a class="thumbnail  " href="${path }/resources/image/product/${product.PRODUCT_PROFILE}" title="lorem ippsum dolor dummy"> <img src="${path }/resources/image/product/${product.PRODUCT_PROFILE}" title="lorem ippsum dolor dummy" alt="lorem ippsum dolor dummy" /></a></div>
              </div>
              
              <c:forEach items="${productImg }" var="pi">
                 <div class="item">
                   <div class="image-additional"><a class="thumbnail  " href="${path }/resources/image/product/${pi.productSubImg}" title="lorem ippsum dolor dummy"> <img src="${path }/resources/image/product/${pi.productSubImg}" title="lorem ippsum dolor dummy" alt="lorem ippsum dolor dummy" /></a></div>
                 </div>
              </c:forEach>
            </div>
          </div>
        </div>
        <!-- 상세 상품 사진 넣는 곳 끝 -->
        
        <!-- 상품 설명 -->
        <div class="col-sm-6">
        <form id="productViewFrm" action="${path }/order/orderEnroll.do" method="post">
          <h1 class="productpage-title">${product.PRODUCT_TITLE }</h1>
          <ul class="list-unstyled productinfo-details-top">
            <li>
            <!-- 가격 -->
              <h2 class="productpage-price">( 누적평점 :  누적 판매량 : ${product.PRODUCT_TOTALSELL } ) </h2>
            </li>
          </ul>
             
          <hr>
          
          <ul class="list-unstyled productinfo-details-top">
            <li>
            <!-- 가격 -->
              <h2 class="productpage-price">가격 : <fmt:formatNumber value="${product.PRODUCT_PRICE }" type="currency" currencySymbol="￦"/>원</h2>
              <input type="hidden" name="productPrice" value="${product.PRODUCT_PRICE }"/>
            </li>
            <c:if test="${product.PRODUCT_STEP eq 0}">
               <!-- 세금 내역 -> 이벤트 할인 가 넣으면 될듯 -->
               <li><span class="productinfo-tax"><fmt:formatNumber value="${product.PRODUCT_DISCOUNT }" type="currency" currencySymbol="￦"/></span></li>
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
              <input type="number" name="productQty" value="1" size="2" id="input-quantity" class="form-control productpage-qty" />
              
              <input type="hidden" name="productNo" id="input-productNo" value="${product.PRODUCT_NO }"/>
              <input type="hidden" name="brandNo" value="${product.BRAND_NO }"/>
              <input type="hidden" name="wishCount" value="${wishCount }"/>
              <input type="hidden" name="cPage" id="cPage" value="${cPage }"/>
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
               
                <!-- 결재 버튼 -->
                <c:if test="${member==null }">
                <input type="submit" id="orderBtn" class="btn btn-primary btn-lg btn-block addtocart" value="결재하기" onclick="fn_noLogin();"/>
                <!-- <button type="button" data-toggle="tooltip" class="btn btn-default compare" title="Compare this Product" ><i class="fa fa-exchange"></i></button> -->
                </c:if>
                
                <c:if test="${member!=null }">
                <input type="submit" id="orderBtn" class="btn btn-primary btn-lg btn-block addtocart" value="결재하기"/>
                <!-- <button type="button" data-toggle="tooltip" class="btn btn-default compare" title="Compare this Product" ><i class="fa fa-exchange"></i></button> -->
                </c:if>
              </div>
            </div>
          </div>
          </form>
        </div>
      </div>
      <script>
          /* $(function(){
            var wishBtn = $('#wishBtn');
            wishBtn.click(function(){
               var wishCount = $('input[name=wishCount]').val();
                console.log("처음에 왔을 때 확인 : "+wishCount);
                var productNo = $('#input-productNo').val();
                var divBtn = $('#divBtn');
               alert(wishCount);
               $.ajax({
                  url:"${path}/product/selectWish.do",
                  data:{"productNo":productNo,"wishCount":wishCount},
                  success:function(data){
                     console.log(data);
                     console.log(wishBtn);
                     if(data["wishCount"]==0){
                        console.log("이벤트 발생 후 0 : "+data["wishCount"]);
                        wishBtn.html('<i class="fa fa-heart-o"></i>');
                        $('input[name=wishCount]').val(data["wishCount"]);
                     }
                     if(data["wishCount"]!=0){
                        console.log("이벤트 발생 후 1 : "+data["wishCount"]);
                        wishBtn.html('<i class="fa fa-heart"></i>');
                        $('input[name=wishCount]').val(data["wishCount"]);
                     }
                  }
               })
            });
         }); */
          
         function fn_wishCk(){
            var wishBtn = $('#wishBtn');
            var wishCount = $('input[name=wishCount]').val();
            console.log("처음에 왔을 때 확인 : "+wishCount);
            var productNo = $('#input-productNo').val();
            $.ajax({
              url:"${path}/product/selectWish.do",
              data:{"productNo":productNo,"wishCount":wishCount},
              success:function(data){
                 console.log(data);
                 console.log(wishBtn);
                 if(data["wishCount"]==0){
                    console.log("이벤트 발생 후 0 : "+data["wishCount"]);
                    wishBtn.html('<i class="fa fa-heart-o"></i>');
                    $('input[name=wishCount]').val(data["wishCount"]);
                 }
                 if(data["wishCount"]!=0){
                    console.log("이벤트 발생 후 1 : "+data["wishCount"]);
                    wishBtn.html('<i class="fa fa-heart"></i>');
                    $('input[name=wishCount]').val(data["wishCount"]);
                 }
              }
           });
         };
         
         /* $('li a').on("click",function(e){
            e.preventDefault();
            alert('들어오니?');
            var productNo = $('#input-productNo').val();
            var productinfoContent = $('#productinfoContent');
            $.ajax({
               url:"${path}/product/productDetail.do",
               data:{"productNo":productNo},
               success:function(data){
                  console.log(data);
                  productinfoContent.html(data["PRODUCT_DETAIL"]);
                  return true;
               }
            });
         }); */
         
         function fn_description(){
            /* event.preventDefault(); */
            var productNo = $('#input-productNo').val();
            var productinfoContent = $('#productinfoContent');
            $.ajax({
               url:"${path}/product/productDetail.do",
               data:{"productNo":productNo},
               success:function(data){
                  console.log(data);
                  $('#descript').attr('href',"#tab-description");
                  productinfoContent.html(data["PRODUCT_DETAIL"]);
                  
                  return true;
               }
            });
         };
         
         /* function fn_review(cPage){
            
            var productNo = $('#input-productNo').val();
            var commentType = $('input[name=review]').val();
            alert('들어오니?'+commentType);
            $.ajax({
               url:"${path}/product/selectComment.do",
               data:{"productNo":productNo, "commentType":commentType, "cPage":cPage},
               success:function(data){
                  console.log(data);
                  var a = data.pageBar;
                  var b = data.commentList; */
                  /* var c = data.orderList; */
                  /* console.log(a);
                  console.log(b); */
                  /* console.log(c); */
                  /* var table = $("<table id='tbl-board' class='table table-striped table-hover'>"); */
                  /* var select = $("#orderList"); */
                  /* var orderStr="";
                  for(var j = 0; j<c.length; j++){
                     console.log(c[j].ORDER_NO);
                     $('#orderList').append("<option value='"+c[j].ORDER_NO+"'>"+c[j].PRODUCT_TITLE+"</option>");
                  }
                  $('#div-review').append(select); */
                  
                  /* for(var i = 0; i<b.length; i++){
                     console.log(b[i]);
                     var tr = $('<tr>');
                     for(var key in b[i]){
                        console.log("으잉??"+key);
                        console.log("ㅁㅇ롸ㅓㅇ놈ㄹㅇ"+b[i][key]);
                        var td = $('<td>');                        
                      td.append(b[i][key]);
                        tr.append(td);
                     }
                     table.append(tr);
                  }
                  $('#reviewComment').html(table).append(a);
                  return true;
               }
            });
         };  */
         
      /* function fn_review(cPage){
            var productNo = $('#input-productNo').val();
            var commentType = $('input[name=review]').val();
            $.ajax({
               url:"${path}/product/selectComment.do",
               data:{"productNo":productNo, "commentType":commentType, "cPage":cPage},
               success:function(data){
                  console.log(data);
                  var a = data.pageBar;
                  var commentList = data.commentList;
                  var table = $('#tbl-comment');
                  var html = "<table id='tbl-comment' class='table table-striped table-hover'><thead><tr><td>작성자</td><td>작성내용</td></tr></thead>";
                  var t = table.append(html);
                  for(var i = 0; i<commentList.length; i++){
                     console.log(commentList[i]["COMMENT_CONTENT"]);
                     for(var key in commentList[i]){
                        var str = "";
                        var str2 = "";
                        str+=" <tr id='level1'><td><strong>후기</strong><input type='text' class='form-control' id='level1-reviewWriter' value="+commentList[i]["MEMBER_NAME"]+" readonly/></td> ";
                        str+=" <td><input type='text' class='form-control' id='level1-reviewContent' value="+commentList["COMMENT_CONTENT"]+"></td>)";
                        str+=" <td><input type='button' class='form-control' value='수정' onclick='fn_reviewUpdate();'/></td> ";
                        str+=" <td><input type='button' class='form-control' value='삭제' onclick='fn_reviewDelete();'/></td><td> ";
                        str+=" <td><input type='button' class='form-control' value='답글' onclick='fn_reply();'/></td></tr></tr> ";            
                        
                        if(commentList[i]["COMMENT_LEVEL"]==2){
                           str2+=" <tr id=level2><td><strong>후기</strong><input type='text' class='form-control' id='level2-reviewWriter' value="+commentList[i]["MEMBER_NAME"]+" readonly/></td>";
                            str2+=" <td><input type='text' class='form-control' id='level2-reviewContent' value="+commentList["COMMENT_CONTENT"]+"></td> ";
                            str2+=" <td><input type='button' class='form-control' value='수정' onclick='fn_reviewUpdate();'/></td> ";
                            str2+=" <td><input type='button' class='form-control' value='삭제' onclick='fn_reviewDelete();'/></td><td> ";
                            str2+=" <td><input type='button' class='form-control' value='답글' onclick='fn_reply();'/></td></tr></tr> ";
                        }
                        var total = str+str2;
                        console.log(total);
                     }
                     var tt = $('#reviewCommentContent').append(total);
                  }
                  $('#reviewComment').html(tt).append(a);
                  return true;
               }
            });
         };  */
         
         function fn_noLogin(){
            location.href='${path}/member/memberLogin.do';
         }
         
         function fn_noLoginComment(){
            alert('로그인 후 이용가능한 서비스 입니다.');
            location.href='${path}/member/memberLogin.do';
         }

      </script>
      <!-- 상품 설명//댓글 창 List-->
      <div class="productinfo-tab">
        <ul class="nav nav-tabs">
          <li class="active">
             <a href="#tab-description" data-toggle="tab" onclick="fn_description();" id="descript">상세설명</a>
          </li>
          <li><a href="#tab-review" data-toggle="tab">상품후기</a></li> <!-- onclick="fn_review();" 모두 셀렉트로 가져옴 -->
          <li><a href="#tab-question" data-toggle="tab" id="product-question">상품문의</a></li>
          <li><a href="#tab-sallerInfo" data-toggle="tab" id="product-sallerInfo" onclick="fn_sallerInfo();">판매자 정보</a></li>   
        </ul>
        <input type="hidden" name="review" value="R"/>
        <input type="hidden" name="question" value="Q"/>
        
        <!-- 상품 설명 탭 -->
        <div class="tab-content">
          <div class="tab-pane active" id="tab-description">
            <div class="cpt_product_description ">
              <div id="productinfoContent">
                ${productDetail.PRODUCT_DETAIL }
                ${orderList }
              </div>
            </div>
            <!-- cpt_container_end -->
            </div>
          


          <!-- 후기 댓글 등록 창 -->
         <div class="tab-pane" id="tab-review">
            <div id="reviewComment" class="form-group"> <!-- style="border:1px solid red" -->
                
                <ul class="media-list">
                     <c:if test='${reviewCommentList==null }'>
                        <span id="level1">
                           등록된 상품 문의가 없습니다.
                        </span>
                     </c:if>
                     <c:if test="${reviewCommentList!=null }">
                        <c:forEach items="${reviewCommentList }" var="reviewComment" varStatus="vs">
                        <li class="media">                  
                           <c:if test="${reviewComment.COMMENT_LEVEL eq 1 }">
                           <a class="pull-left" href="javascript:void(0);"> 
                              <img class="media-object img-circle" width="100px;" src="https://s3.amazonaws.com/uifaces/faces/twitter/dancounsell/128.jpg" alt="profile">
                           </a>
                              <div class="media-body">
                                 <div class="well well-sm">
                                    <h4 class="media-heading text-uppercase reviews display-inline">${reviewComment['MEMBER_NAME'] }</h4>
                                    <ul class="media-date text-uppercase reviews list-inline display-inline">
                                       <li class="dd">22</li>
                                       <li class="mm">09</li>
                                       <li class="aaaa">2014</li>
                                    </ul>
      
                                    <p class="media-comment">${reviewComment['COMMENT_CONTENT'] }</p>
                                    <div>
                                    <a id="btn-comment" class="btn btn-primary btn-circle text-uppercase btn-reply" data-toggle="collapse" href="#${reviewComment['COMMENT_NO']}">
                                       <i class="far fa-comment-dots"></i>&nbsp;comment</a>
                                       
                                    <a class="btn btn-success btn-circle text-uppercase btn-reply" href="#" id="reply">
                                       <i class="far fa-thumbs-up"></i></a>
                                    <a class="btn btn-warning btn-circle text-uppercase btn-reply" href="#" id="reply" style="background-color: #b7c7c7;">
                                       <i class="far fa-thumbs-down"></i></a>   
                                       <div class="float-right">
                                          <a class="btn btn-primary text-uppercase btn-reply" onclick="fn_reviewUpdate();">수정</a>
                                          <a class="btn btn-primary text-uppercase btn-reply" onclick="fn_reviewDelete();">삭제</a>
                                       </div>
                                    </div>
                                 </div>
                              </div>
                        </c:if>
                        <c:if test="${reviewComment.COMMENT_LEVEL eq 2 }">  
                           <div class="col-sm-11 reply-sm-10 collapse" id="${reviewComment['COMMENT_REF']}">
                              <ul class="media-list">
                              <li class="media media-replied">
                              <a class="pull-left" href="javascript:void(0);"> 
                                 <img class="media-object img-circle" style="width: 80px;" 
                                    src="${path }/resources/image/seller_img.png" alt="profile">
                              </a>
                                 <div class="media-body">
                                    <div class="well well-sm">
                                       <h4 class="media-heading text-uppercase reviews display-inline">
                                          판매자
                                       </h4>
                                       <ul class="media-date text-uppercase reviews list-inline display-inline">
                                          <li class="dd">22</li>
                                          <li class="mm">09</li>
                                          <li class="aaaa">2014</li>
                                       </ul>
                                       <p class="media-comment">${reviewComment['COMMENT_CONTENT'] }</p>
                                    </div>
                                 </div>
                              </li>
                              </ul>
                           </div>
                        </c:if>
                     </li>
                     </c:forEach>
                  </c:if>
                  </ul>
               
               <div style="text-align: center;">
                  ${reviewPageBar }
               </div>
            </div>

                 
          <!-- <script>
      function fn_commentClick(commentNo){
         var temp = '';
         var str = '';   
          $.ajax({
              url:"${path}/product/selectReviewCommentSeconds.do",
              data:{"commentNo":commentNo},
              success:function(data){     
                 
                  
                 for(var i = 0; i < data.list.length; i++)
               {
                       /* str = "<li class='media media-replied col-sm-10 float-right' style='padding-right: 0px;'>"; */
                      str = "<div class='media-body'>";
                  str += "<div class='well well-sm'>";
                  str += "<h4 class='media-heading text-uppercase reviews display-inline' id='review-level2-memberNo'>" + data.list[i].MEMBER_NO + "</h4>";
                  str += "<ul class='media-date text-uppercase reviews list-inline display-inline'>";
                  str += "<li class='dd' id='review-level2-date'></li></ul>";
                  str += "<p class='media-comment' id='review-level2-content'>" + data.list[i].COMMENT_CONTENT + "</p><div style='text-align:right;'>"
                  str += "<a class='btn btn-primary text-uppercase btn-reply' onclick='fn_reviewUpdate();'>수정</a>&nbsp;";
                  str += "<a class='btn btn-primary text-uppercase btn-reply' onclick='fn_reviewDelete();'>삭제</a></div>";
                  str += "</div></div>";/* </li> */
                  temp += str;
               }
                 
                 /* temp += "<li class='media media-replied col-sm-10 float-right' style='padding-right: 0px;'>";
                 temp += "<div class='media-body'>";
                 temp += "<div class='well well-sm'>";
                 temp += "<h4 class='media-heading text-uppercase reviews'>" + "KIM" + "</h4>";
                 temp += "<textarea class='media-comment' rows='3' style='resize: none; width: 100%;' placeholder='내용을 입력해주세요'></textarea>";
                 temp += "<div style='text-align:right;'><a class='btn btn-primary text-uppercase btn-reply' onclick='fn_reviewLevel2Write();'>등록</a></div>";
                 temp += "</div></div></li>"; */
                 $('#' + commentNo).append(temp);
              }
         });
      }
     </script>  -->
            <form id="commentReview" class="form-horizontal" action="${path }/product/insertCommentReview.do">
              <div  id="div-review">
                 <c:if test="${orderList.size()>0 }">
                 <select class="form-control" id="orderList">
                 <c:forEach items="${orderList }" var="order">
                 <c:if test="${order.ORDER_PAYSTATE eq '3'}">
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
                  <input type="radio" name="rating" value="0" />
                  &nbsp;
                  <input type="radio" name="rating" value="30" />
                  &nbsp;
                  <input type="radio" name="rating" value="60" />
                  &nbsp;
                  <input type="radio" name="rating" value="80" />
                  &nbsp;
                  <input type="radio" name="rating" value="100" />
                  &nbsp;Good</div>
              </div>
              
              <div class="buttons clearfix">
                <div class="pull-right">
                  
                  <c:if test="${member==null }">
                     <button type="button" id="button-review" class="btn btn-primary" onclick="fn_noLoginComment();">후기등록</button>
                  </c:if>
                  
                  <!-- 구매 완료된 사람들만 글 쓰기 권한!! -->
                  <c:if test="${member!=null }">
                     <c:if test="${orderList[0].ORDER_PAYSTATE eq '3'}">
                        <input type="button" id="button-review" class="btn btn-primary" value="후기등록" onclick="fn_insertReviewComment();"/>
                     </c:if>   
                  </c:if>
                </div>
              </div>
            </form>
          </div>
          
          <script>
             function fn_insertReviewComment(){
                alert('들어오니?');
                var productNo = $('#input-productNo').val();
                var orderNo = $('#orderList').val();
                $('#input-reviewCommentProductNo').val(productNo);
                $('#input-reviewOrderNo').val(orderNo);
                $('#commentReview').submit();
             }
          </script>
          
          <!-- 상품 문의 작성 -->
          <div class="tab-pane" id="tab-question">
            <div id="questionComment" class="form-group"><!--  style="border:1px solid red" -->
<!--                 <table id='tbl-comment' class='table table-striped table-hover'>
                  <thead>
                     <tr>
                        <td>작성자</td>
                        <td>작성내용</td>
                     </tr>
                  </thead>
                  <tbody id="questionCommentContent"> -->
                  
                  <ul class="media-list">
                     <c:if test='${questionCommentList==null }'>
                        <span id="level1">
                           등록된 상품 문의가 없습니다.
                        </span>
                     </c:if>
                     <c:if test="${questionCommentList!=null }">
                        <c:forEach items="${questionCommentList }" var="questionComment" varStatus="vs">
                        <li class="media">                  
                           <c:if test="${questionComment.COMMENT_LEVEL eq 1 }">
                           <a class="pull-left" href="javascript:void(0);"> 
                              <img class="media-object img-circle" width="100px;" src="https://s3.amazonaws.com/uifaces/faces/twitter/dancounsell/128.jpg" alt="profile">
                           </a>
                              <div class="media-body">
                                 <div class="well well-sm">
                                    <h4 class="media-heading text-uppercase reviews display-inline">${questionComment['MEMBER_NAME'] }</h4>
                                    <ul class="media-date text-uppercase reviews list-inline display-inline">
                                       <li class="dd">22</li>
                                       <li class="mm">09</li>
                                       <li class="aaaa">2014</li>
                                    </ul>
      
                                    <p class="media-comment">${questionComment['COMMENT_CONTENT'] }</p>
                                    <div>
                                    <!-- <a id="btn-comment" class="btn btn-primary btn-circle text-uppercase btn-reply" data-toggle="collapse" href="#${questionComment['COMMENT_NO']}">
                                       <i class="far fa-comment-dots"></i>&nbsp;comment</a> -->
                                       
                                    <a class="btn btn-success btn-circle text-uppercase btn-reply" href="#" id="reply">
                                       <i class="far fa-thumbs-up"></i></a>
                                    <a class="btn btn-warning btn-circle text-uppercase btn-reply" href="#" id="reply" style="background-color: #b7c7c7;">
                                       <i class="far fa-thumbs-down"></i></a>   
                                       <div class="float-right">
                                          <a class="btn btn-primary text-uppercase btn-reply" onclick="fn_reviewUpdate();">수정</a>
                                          <a class="btn btn-primary text-uppercase btn-reply" onclick="fn_reviewDelete();">삭제</a>
                                       </div>
                                    </div>
                                 </div>
                              </div>
                        </c:if>
                        <c:if test="${questionComment.COMMENT_LEVEL eq 2 }">  
                           <div class="col-sm-11 reply-sm-10" <%-- collapse id="${questionComment['COMMENT_REF']}" --%>>
                              <ul class="media-list">
                              <li class="media media-replied">
                              <a class="pull-left" href="javascript:void(0);"> 
                                 <img class="media-object img-circle" style="width: 80px;" 
                                    src="${path }/resources/image/seller_img.png" alt="profile">
                              </a>
                                 <div class="media-body">
                                    <div class="well well-sm">
                                       <h4 class="media-heading text-uppercase reviews display-inline">
                                          판매자
                                       </h4>
                                       <ul class="media-date text-uppercase reviews list-inline display-inline">
                                          <li class="dd">22</li>
                                          <li class="mm">09</li>
                                          <li class="aaaa">2014</li>
                                       </ul>
                                       <p class="media-comment">${questionComment['COMMENT_CONTENT'] }</p>
                                    </div>
                                 </div>
                              </li>
                              </ul>
                           </div>
                        </c:if>
                     </li>
                     </c:forEach>
                  </c:if>
                  </ul>
                  
                  
               <div style="text-align: center;">
                  ${questionPageBar }
               </div>
            </div>
            
            <form id="commentReview" class="form-horizontal" action="${path }/product/insertCommentReview.do">
              <div  id="div-review"></div>
              <div class="form-group required">
                <div class="col-sm-12">
                  <label class="control-label" for="input-name">문의 작성자ID</label>
                  <c:if test="${member != null}">
                     <input type="text" name="name" id="input-name" class="form-control" value="${member.memberName }" readonly/>
                     <input type="hidden" name="memberNo" id="input-memberNo" value="${member.memberNo }"/>
                     <input type="hidden" name="reviewType" value="Q"/>
                  </c:if>
                </div>
              </div>
              <div class="form-group required">
                <div class="col-sm-12">
                  <label class="control-label" for="input-review">상품 문의</label>
                  <textarea name="text" rows="5" id="input-review" name="reviewContent" class="form-control"></textarea>
                </div>
              </div>
              
              <div class="buttons clearfix">
                <div class="pull-right">
                  
                  <c:if test="${member==null }">
                     <button type="button" id="button-review" class="btn btn-primary" onclick="fn_noLoginComment();">문의등록</button>
                  </c:if>
                  
                  <c:if test="${member!=null }">
                     <input type="submit" id="button-review" class="btn btn-primary" value="문의등록"/>
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
              <input type="hidden" id="addr" value="${brand.BRAND_ADDR }${brand.BRAND_DETAILADDR}"/>
              <input type="hidden" id="brandTitle" value="${brand.BRAND_TITLE }"/>
              <br>
              </address>
            </div>
            <div class="col-sm-8 right">
              <div class="map">
                  <div id="map" style="height:200px;width:600px;"></div>
              </div>
            </div>
            </div>
            </div>
           
      </div>

            
            
        </div>
      </div>
      
      <!-- 비슷한 상품 추천 -->
      <!-- <h3 class="productblock-title">Related Products</h3>
      <div class="box">
        <div id="related-slidertab" class="row owl-carousel product-slider">
        
        상품 1
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
          
          상품 2
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
          
          상품 3
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
          </div> -->
          
        </div>
      </div>
      
      
    </div>
</section>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>