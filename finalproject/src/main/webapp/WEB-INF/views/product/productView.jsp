<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>


<section class="product col-2 left-col">
<div class="preloader loader" style="display: block; background:#f2f2f2;"> <img src="image/loader.gif"  alt="#"/></div>
<div class="container">
  <ul class="breadcrumb">
    <li><a href="/makers"><i class="fa fa-home"></i></a></li>
	<li><a href="${path }/product/category.do?category="${product.BC_NO }>${bcTitle }</a></li>
    <li><a href="#">${product.PRODUCT_TITLE }</a></li>
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
              	<li><a href="${path }/product/category.do?category=${sc.scNo}">${sc.scTitle}</a></li>
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
         
         <!-- AddThis Button BEGIN -->
            <div class="addthis_toolbox addthis_default_style"><a class="addthis_button_facebook_like" ></a> <a class="addthis_button_tweet"></a> <a class="addthis_button_pinterest_pinit"></a> <a class="addthis_counter addthis_pill_style"></a></div>
         <!-- AddThis Button END -->
          
          
          
          <ul class="list-unstyled productinfo-details-top">
            <li>
            <!-- 가격 -->
              <h2 class="productpage-price">가격 : ${product.PRODUCT_PRICE }</h2>
              <input type="hidden" name="productPrice" value="${product.PRODUCT_PRICE }"/>
            </li>
            <c:if test="${product.PRODUCT_STEP eq 0}">
	            <!-- 세금 내역 -> 이벤트 할인 가 넣으면 될듯 -->
	            <li><span class="productinfo-tax">${product.PRODUCT_DISCOUNT }</span></li>
            </c:if>
          </ul>
          <hr>
          
          <ul class="list-unstyled product_info">
            <li>
              <label>brand:</label>
              <span> ${product.BRAND_TITLE}</span></li>
            <%-- <li>
              <label>상품 :</label>
              <span> ${productList.PRODUCT_TITLE }</span></li> --%>
            <li>
              <label>최소수량:</label>
              <span> ${product.PRODUCT_MIN }</span></li>
            <li>
              <label>최대수량:</label>
              <span> ${product.PRODUCT_MAX }</span></li>  
          </ul>
          <hr>
             
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
              
              <input type="hidden" name="productNo" id="input-productNo" value="${product.PRODUCT_NO }" />
              <input type="hidden" name="brandNo" value="${product.BRAND_NO }" />
              <input type="hidden" name="wishCount" value="${wishCount }"/>
              <input type="hidden" name="cPage" id="cPage" value="${cPage }"/>
              <input type="hidden" name="productTitle" value="${product.PRODUCT_TITLE }"/>

              <!-- <input type="hidden" name="" -->
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
          <!-- <li><a href="#tab-review" data-toggle="tab">상품후기</a></li> onclick="fn_review();" 모두 셀렉트로 가져옴
          <li><a href="#tab-question" data-toggle="tab" id="product-question">상품문의</a></li>
          <li><a href="#tab-sallerInfo" data-toggle="tab" id="product-sallerInfo">판매자 정보</a></li> -->	
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
          <%-- <div class="tab-pane" id="tab-review">
         	<div id="reviewComment" class="form-group" style="border:1px solid red">
         	 	<table id='tbl-comment' class='table table-striped table-hover'>
         			<thead>
         				<tr>
         					<td>작성자</td>
         					<td>작성내용</td>
         				</tr>
         			</thead>
         			<tbody id="reviewCommentContent">
         				<c:if test='${reviewCommentList==null }'>
         					<tr id="level1">
         						<td colspan="2">등록한 댓글이 없습니다.</td>
         					</tr>
         				</c:if>
         				<c:if test="${reviewCommentList!=null }">
         				<c:forEach items="${reviewCommentList }" var="reviewComment" varStatus="vs">
         					<c:if test="${reviewComment.COMMENT_LEVEL eq 1 }">
         					<tr id="level1">
         						<td>
         							<strong>후기</strong><input type="text" class="form-control" id="level1-reviewWriter" value="${reviewComment['MEMBER_NAME'] }" readonly/>
         							
         							<!-- $(#level1).append('<td><strong>후기</strong><input type="text" class="form-control" id="level1-reviewWriter" value="'+data[i].MEMBER_NAME+'" readonly/></td>') -->
         							
         						</td>
         						<td>
	         						<input type="text" class="form-control" id="level1-reviewContent" value="${reviewComment['COMMENT_CONTENT'] }">
	         					</td>
	         					<td>
	         						<input type="button" class="form-control" value="수정" onclick="fn_reviewUpdate();"/>
	         					</td>
	         					<td>
	         						<input type="button" class="form-control" value="삭제" onclick="fn_reviewDelete();"/>
	         					</td>
	         					<td>
	         						<input type="button" class="form-control" value="답글" onclick="fn_reply();"/>
	         					</td>
         					</tr>
         					<c:if test="${reviewComment.COMMENT_LEVEL eq 2 }">
         					<tr id="level2">
	         					<td><strong>답글</strong><input type="text" class="form-control" id="level2-reviewWriter" value="${reviewComment['MEMBER_NO'] }" readonly/></td>
	         					<td colspan="2">
	         						<input type="text" class="form-control" id="level2-reviewContent" value="${reviewComment['COMMENT_CONTENT'] }">
	         					</td>
	         					<td>
	         						<input type="button" class="form-control" value="수정"/>
	         					</td>
	         					<td>
	         						<input type="button" class="form-control" value="삭제"/>
	         					</td>
	         				</tr>
	         				</c:if>
         					</c:if>
         					</c:forEach>
         				</c:if>
         			</tbody>
         		</table> --%>
         		<%-- ${reviewPageBar } --%>
         	<!-- </div> -->
         	
         	<!-- <div class="form-group">
         		
         				<tr>
         					<td><strong>후기</strong><input type="text" class="form-control" value="홍길동" readonly/></td>
         					<td>
         						<input type="text" class="form-control" value="내용">
         					</td>
         					<td>
         						<input type="button" class="form-control" value="수정"/>
         					</td>
         					<td>
         						<input type="button" class="form-control" value="삭제"/>
         					</td>
         					<td>
         						<input type="button" class="form-control" value="답글"/>
         					</td>
         				</tr>
         				<tr>
         					<td><strong>답글</strong><input type="text" class="form-control" value="판매자" readonly/></td>
         					<td colspan="2">
         						<input type="text" class="form-control" value="답변">
         					</td>
         					<td>
         						<input type="button" class="form-control" value="수정"/>
         					</td>
         					<td>
         						<input type="button" class="form-control" value="삭제"/>
         					</td>
         				</tr>
         			
         	</div>
         	
         	<ul class="pagination pagination-sm no-magin" id="reviewCommentUL">
         	 		<li data-replyNo="test" class='form-control'>
         	 			<h3><strong>후기</strong></h3><p class='form-inline'>내용</p>
         	 			<p class='form-inline'>작성자</p>
         	 			<button type='button' class='btn btn-xs btn-success form-inline' data-toggle='modal' data-target='#modifyModal'>댓글 수정</button>
         	 			<button type='button' class='btn btn-xs btn-success form-inline' data-toggle='modal' data-target='#modifyModal'>댓글 삭제</button>
         	 			<button type='button' class='btn btn-xs btn-success form-inline' data-toggle='modal' data-target='#modifyModal'>답글 달기</button>
         	 		</li>
         	 		<hr/>
         	 		<li data-replyNo="test" class='form-control'>
         	 			<strong>답변</strong><p class='form-inline'>내용</p>
         	 			<p class='form-inline'>작성자</p>
         	 			<button type='button' class='btn btn-xs btn-success' data-toggle='modal' data-target='#modifyModal'>댓글 수정</button>
         	 			<button type='button' class='btn btn-xs btn-success' data-toggle='modal' data-target='#modifyModal'>댓글 삭제</button>
         	 		</li>
         	 	</ul> -->
         	
            <form id="commentReview" class="form-horizontal" action="${path }/product/insertCommentReview.do">
              <div  id="div-review">
              	<c:if test="${orderList!=null }">
              	<%-- <c:if test="${orderList.ORDER_PAYSTATE eq '3'}"> --%>
	              <select class="form-control" id="orderList">
	              <c:forEach items="${orderList }" var="order">
	              	<option value="${order.ORDER_NO }">${order.PRODUCT_TITLE }</option>
	              </c:forEach>
	              </select>
	            <%-- </c:if> --%>
              	</c:if>
              </div>
              <h2>상품 후기</h2>
              <div class="form-group required">
                <div class="col-sm-12">
                  <label class="control-label" for="input-name">후기 작성자ID</label>
                  <c:if test="${member != null}">
                  	<input type="text" name="name" id="input-name" class="form-control" value="${member.memberName }" readonly/>
                  	<input type="hidden" name="memberNo" id="input-memberNo" value="${member.memberNo }"/>
                  	<input type="hidden" name="reviewType" value="R"/>
                  </c:if>
                </div>
              </div>
              <div class="form-group required">
                <div class="col-sm-12">
                  <label class="control-label" for="input-review">상품 후기</label>
                  <textarea name="text" rows="5" id="input-review" name="reviewContent" class="form-control"></textarea>
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
	                  <%-- <c:if test="${product_order.order_state eq '3'}"> --%>
	                  	<input type="submit" id="button-review" class="btn btn-primary" value="후기등록"/>
	                  <%-- </c:if> --%>	
                  </c:if>
                </div>
              </div>
            </form>
          </div>
          
          <!-- 상품 문의 작성 -->
          <div class="tab-pane" id="tab-question">
         	<div id="questionComment" class="form-group" style="border:1px solid red">
         	 	<table id='tbl-comment' class='table table-striped table-hover'>
         			<thead>
         				<tr>
         					<td>작성자</td>
         					<td>작성내용</td>
         				</tr>
         			</thead>
         			<tbody id="questionCommentContent">
         				<c:if test='${questionCommentList==null }'>
         					<tr id="level1">
         						<td colspan="2">등록한 댓글이 없습니다.</td>
         					</tr>
         				</c:if>
         				<c:if test="${questionCommentList!=null }">
         				<c:forEach items="${questionCommentList }" var="questionComment" varStatus="vs">
         					<c:if test="${questionComment.COMMENT_LEVEL eq 1 }">
         					<tr id="level1">
         						<td>
         							<strong>문의</strong><input type="text" class="form-control" id="level1-reviewWriter" value="${questionComment['MEMBER_NAME'] }" readonly/>
         							
         							<!-- $(#level1).append('<td><strong>후기</strong><input type="text" class="form-control" id="level1-reviewWriter" value="'+data[i].MEMBER_NAME+'" readonly/></td>') -->
         							
         						</td>
         						<td>
	         						<input type="text" class="form-control" id="level1-reviewContent" value="${questionComment['COMMENT_CONTENT'] }">
	         					</td>
	         					<td>
	         						<input type="button" class="form-control" value="수정" onclick="fn_reviewUpdate();"/>
	         					</td>
	         					<td>
	         						<input type="button" class="form-control" value="삭제" onclick="fn_reviewDelete();"/>
	         					</td>
	         					<td>
	         						<input type="button" class="form-control" value="답글" onclick="fn_reply();"/>
	         					</td>
         					</tr>
         					<c:if test="${questionComment.COMMENT_LEVEL eq 2 }">
         					<tr id="level2">
	         					<td><strong>답글</strong><input type="text" class="form-control" id="level2-reviewWriter" value="${questionComment['MEMBER_NO'] }" readonly/></td>
	         					<td colspan="2">
	         						<input type="text" class="form-control" id="level2-reviewContent" value="${questionComment['COMMENT_CONTENT'] }">
	         					</td>
	         					<td>
	         						<input type="button" class="form-control" value="수정"/>
	         					</td>
	         					<td>
	         						<input type="button" class="form-control" value="삭제"/>
	         					</td>
	         				</tr>
	         				</c:if>
         					</c:if>
         					</c:forEach>
         				</c:if>
         			</tbody>
         		</table>
         		<%-- ${questionPageBar } --%>
         	</div>
         	
            <form id="commentReview" class="form-horizontal" action="${path }/product/insertCommentReview.do">
              <div  id="div-review"></div>
              <h2>상품 문의</h2>
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
                  
                  <!-- 구매 완료된 사람들만 글 쓰기 권한!! -->
                  <c:if test="${member!=null }">
	                  <%-- <c:if test="${product_order.order_state eq '3'}"> --%>
	                  	<input type="submit" id="button-review" class="btn btn-primary" value="문의등록"/>
	                  <%-- </c:if> --%>	
                  </c:if>
                </div>
              </div>
            </form>
          </div>
          
          <!-- 업체 정보 보여주는 곳 -->
          <div class="tab-pane" id="tab-sallerInfo">
            <div class="cpt_product_description ">
              <div>
                
            <div class="col-sm-4 left">
              <address>
              <strong> 브랜드 명: </strong>${brand.BRAND_TITLE } <br>
              <br>
              <strong>주소:</strong>
              <div class="address"> ${brand.BRAND_ADDR } ${brand.BRAND_DETAILADDR }</div>
              <br>
              </address>
            </div>
            <div class="col-sm-8 rigt">
              <div class="map">
                <script type="text/javascript" src="http://maps.google.com/maps/api/js?sensor=false"></script>
                <div style="overflow:hidden;height:200px;width:100%;">
                  <div id="gmap_canvas" style="height:200px;width:600px;"></div>

                  <a class="google-map-code" href="http://www.pureblack.de/google-maps/" id="get-map-data">pureblack.de</a></div>
                <script type="text/javascript"> function init_map(){var myOptions = {zoom:14, scrollwheel:false,center:new google.maps.LatLng(36.778261,-119.41793239999998),mapTypeId: google.maps.MapTypeId.ROADMAP};map = new google.maps.Map(document.getElementById("gmap_canvas"), myOptions);marker = new google.maps.Marker({map: map,position: new google.maps.LatLng(36.778261, -119.41793239999998)});infowindow = new google.maps.InfoWindow({content:"<b>Fresh Food privated limited</b><br/>Warehouse &amp; Offices 12345<br/> California " });google.maps.event.addListener(marker, "click", function(){infowindow.open(map,marker);});infowindow.open(map,marker);}google.maps.event.addDomListener(window, 'load', init_map);</script>
              </div>
            </div>
        
              </div>
            </div>
            <!-- cpt_container_end -->
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
  </div>
</div>

</section>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>