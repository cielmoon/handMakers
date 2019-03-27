<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath }" />

<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
<%-- <jsp:para value="" name="pageTitle"/> --%>

<!-- include libraries(jQuery, bootstrap) -->


<link href="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.2/summernote.css" rel="stylesheet">
<script src="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.2/summernote.js"></script>


<!-- 
<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
<link href="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.11/summernote-lite.css" rel="stylesheet">
<script src="http://code.jquery.com/jquery-3.2.1.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.11/summernote-lite.js"></script>
 -->


<style>
#select-brand, #select-bigcategory, #select-smallcategory {
	margin-bottom: 10px;
}

#newProductDetailImg, #newProductOption, .newProductDetailImg, .newProductOption {
	width: 500px;
}

#adminProductProfileMainImg {
	padding-top: 7px;
	border: none;
	max-height: 350px;
	max-width: 350px;
}

#newProductOptionList {
	width: 300px;
}

#newProductDetailComments {
	width:800px;
	height:600px;
}
.modal-backdrop, .modal-backdrop.in{
     z-index: -1;
}/* add yewon summer note modal blank fix */

#product_option_table > tbody > tr:nth-child(2) > td > div > div.note-toolbar.panel-heading > div.note-btn-group.btn-group.note-insert > button:nth-child(3) {
	display: none;
}

#product_option_table > tbody > tr:nth-child(2) > td > div > div.note-toolbar.panel-heading > div.note-btn-group.btn-group.note-insert > button:nth-child(1) {
	display: none;
}

#product_option_table > tbody > tr:nth-child(2) > td > div > div.note-toolbar.panel-heading > div.note-btn-group.btn-group.note-view > button.note-btn.btn.btn-default.btn-sm.btn-fullscreen {
	display: none;
}

#product_option_table > tbody > tr:nth-child(2) > td > div > div.note-toolbar.panel-heading > div.note-btn-group.btn-group.note-view > button.note-btn.btn.btn-default.btn-sm.btn-codeview {
	display: none;
}

#product_option_table > tbody > tr:nth-child(2) > td > div > div.note-toolbar.panel-heading > div.note-btn-group.btn-group.note-view > button:nth-child(3) {
	display: none;
}

</style>

<script>

	$(document).ready(function() {
		  $("#newProductProfile").on("change", enrollMainImg);
		  
		  var today = new Date();
		  var year = today.getFullYear();
		  var month = ("0" + (today.getMonth() + 1)).slice(-2);
		  var day = ("0" + (today.getDate() + 1)).slice(-2);
			
		  var minDate = (year + "-" + month + "-" + day);
			
		  $("#newProductSaleEnd").attr("min", minDate);
		  
		  function fn_setDatePickerMax(){
      		var datePicker = $('#newProductSaleEnd');
      		datePicker.min = new Date(new Date().getTime() - new Date().getTimezoneOffset() * 60000).toISOString().split("T")[0];
   		  }
		  
	      $('#summernote').summernote({
	          height: 300,
	          minHeight: null,
	          maxHeight: null,
	          focus: true,
	          callbacks: {
	            onImageUpload: function(files, editor, welEditable) {
	              for (var i = files.length - 1; i >= 0; i--) {
	                sendFile(files[i], this);
	              }
	            }
	      }
	    });

		$("#select-bigCategory").change(function(){
			var bcNo = $("#select-bigCategory").find(":selected").val();
			/* 소카테고리 리스트 초기화  */
			$("#select-smallCategory")[0].options.length = 0;
			$.ajax({
				//${path}/admin/productEnrollB randSet.do
				url:"${path}/admin/productEnrollScSet.do",
				data:{"bcNo" : bcNo},
				success:function(data){
					for(var i=0; i<data.scList.length; i++)
					{
						$('#select-smallCategory').append($('<option>',
						{
					        value: data.scList[i]['scNo'],
					        text : data.scList[i]['scTitle']
					    }));
					}
				}
			});
		});
	});

    function sendFile(file, el) {
        var form_data = new FormData();
        var path = '${path}' + "/resources/image/product/";
        form_data.append('file', file);
        $.ajax({
          data: form_data,
          type: "POST",
          url: '${path}/admin/handleFileUpload.do',
          cache: false,
          contentType: false,
          enctype: 'multipart/form-data',
          processData: false,
          success: function(url) {        
            $(el).summernote('editor.insertImage', path + url);
            $('#imageBoard > ul').append('<li><img src="'+ path + url +'" width="480" height="auto"/></li>');
          }
        });
      }
	
	function validate() {
		/* var textArea = $("#note-codable").val();
		console.log("textArea : " + textArea);
		
		if(textArea.trim().length < 0) {
			alert("상품 상세내용을 입력해주세요.");
			$("#note-codable").focus();
			
			return false;
		} */
		var html = $('#summernote').summernote('code');


		
		if ($("#newProductName").val() == "") {
			alert("상품명을 입력해주세요.");
			$("#newProductName").focus();

			return false;
		}

		if ($("#newProductComment").val() == "") {
			alert("한줄설명을 입력해주세요.");
			$("#newProductComment").focus();

			return false;
		}

		if ($("#newProductPrice").val() == "") {
			alert("상품 가격을 입력해주세요.");
			$("#newProductPrice").focus();

			return false;
		}
	
		if ($("#newProductSale").val() == "") {
			alert("할인율을 입력해주세요.");
			$("#newProductSale").focus();

			return false;
		}
		
		if ($("#newProductSaleEnd").val() == "") {
			alert("상품 마감 날짜를 입력해주세요.");
			$("#newProductSaleEnd").focus();
			
			return false;
		}

		if ($("#newProductMin").val() == "") {
			alert("최소 주문량을 입력해주세요.");
			$("#newProductMin").focus();

			return false;
		}

		if ($("#newProductMax").val() == "") {
			alert("최대 주문량을 입력해주세요.");
			$("#newProductMax").focus();

			return false;
		}
		
		if ($("#newProductProfile").val() == "") {
			alert("메인 사진을 등록해주세요.");
			$("#newProductProfile").focus();
			
			return false;
		}
		
		if ($("#newProductDetailImg").val() == "") {
			alert("상품 사진을 등록해주세요.");
			$("#newProductDetailImg").focus();
			
			return false;
		}
		
		for (var i = 1; i < 10; i++) {
			if ($(".newProductDetailImg" + i).val() == "") {
				
				alert("추가할 상품 사진을 등록해주세요.");
				$("#newProductDetailImg" + i).focus();
				
				return false;
			}
		}
		
		if ($("#newProductOption").val() == "") {
			alert("상품 옵션을 입력해주세요.");
			$("#newProductOption").focus();
			
			return false;
		}
 		
		for (var i = 1; i < 10; i++) {
			if ($(".newProductOption" + i).val() == "") {
				
				alert("추가할 상품 옵션을 등록해주세요.");
				$("#newProductOption" + i).focus();
				
				return false;
			}
		}
		
		if (html.trim() == "") {
			alert("상세설명을 입력해주세요.");		

			return false;
		}
		
		return true;
	};
	
	$(function() {
		var numberRegex = /^[0-9]+$/;
		
		$("#newProductSale").keyup(function() {
			var newProductSale = $("#newProductSale").val();
			if (newProductSale.length > 0) {
				if(!numberRegex.test(newProductSale)) {
					alert("할인율은 숫자만 입력해주세요.");
					$("#newProductSale").val('');
					/* $("#newProductPrice").focus(); */

					return;
				}
			}
			
			if (parseInt($("#newProductSale").val()) < 0 || parseInt($("#newProductSale").val()) > 99) {
				alert("할인율은 0 ~ 99 사이의 숫자만 입력해주세요.");
				$("#newProductSale").val('');
				/* $("#newProductSale").focus(); */
				
				return;
			}
		})
		
		$("#newProductPrice").keyup(function() {
			var newProductPrice = $("#newProductPrice").val();
			if (newProductPrice.length > 0) {
				if(!numberRegex.test(newProductPrice)) {
					alert("상품 가격은 숫자만 입력해주세요.");
					$("#newProductPrice").val('');
					/* $("#newProductPrice").focus(); */

					return;
				}
			}
		})
		
		$("#newProductMin").keyup(function() {
			var newProductMin = $("#newProductMin").val();
			if (newProductMin.length > 0) {
				if(!numberRegex.test(newProductMin)) {
					alert("최소 주문량은 숫자만 입력해주세요.");
					$("#newProductMin").val('');
					/* $("#newProductPrice").focus(); */

					return;
				}
			}
			
			if (parseInt($("#newProductMin").val()) < 1 || parseInt($("#newProductMin").val()) > 10000) {
				alert("최소 주문량은 1 ~ 10000 사이의 숫자만 입력해주세요.");
				$("#newProductMin").val('');
				/* $("#newProductSale").focus(); */
				
				return;
			}
		})
		
		$("#newProductMax").keyup(function() {
			var newProductMax = $("#newProductMax").val();
			
			if (newProductMax.length > 0) {
				if(!numberRegex.test(newProductMax)) {
					alert("최대 주문량은 숫자만 입력해주세요.");
					$("#newProductMax").val('');
					/* $("#newProductPrice").focus(); */

					return;
				}
			}
			
			if (parseInt($("#newProductMax").val()) < 1 || parseInt($("#newProductMax").val()) > 10000) {
				alert("최대 주문량은 1 ~ 10000 사이의 숫자만 입력해주세요.");
				$("#newProductMax").val('');
				/* $("#newProductSale").focus(); */
				
				return;
			}
		})
		
		$("#newProductMax").blur(function() {			
			if (parseInt($("#newProductMin").val()) >= parseInt($("#newProductMax").val())) {
				alert("최대 주문량은 최소 주문량보다 크게 입력해주세요.")
				$("#newProductMin").val('');
				$("#newProductMax").val('');
				$("#newProductMin").focus();
			}
		});
	});
	
	// 메인사진 등록 체크
	function enrollMainImg(e) {
		var files = e.target.files;
		var filesArr = Array.prototype.slice.call(files);
		
		filesArr.forEach(function(f) {
			if (!f.type.match("image/*")) {
				alert("이미지 확장자만 등록해주세요.");
				$("#newProductProfile").val('');
				// <img id="adminProductProfileMainImg" src="${path }/resources/image/noImg.png">
				$("#adminProductProfileMainImg").attr("src", "${path }/resources/image/noImg.png").css('width', '350px').css('height', '350px');
				
				return;
			}
			
			sel_file = f;
			
			var reader = new FileReader();
			reader.onload = function(e) {
				$("#adminProductProfileMainImg").attr("src", e.target.result).css('width', '350px').css('height', '350px');
			}
			
			reader.readAsDataURL(f);
		});
	}
</script>

<script>
// 상품 상세 사진 추가
var filecount = 1;
var detailImgCount = 0;

$(function(){
    $('#fileAdd').on("click",function(e){
    	if(filecount < 10){
    		
    		var addTr=$("<tr></tr>");
    		var addTh=$("<th>상품사진</th>");
   	 		var addTd=$("<td></td>");
   	 		var addInput =$("<input type='file' id='newProductDetailImg' name='newProductDetailImg' class='newProductDetailImg" + filecount + "' title='파일첨부  : 용량 1,048,576 바이트 이하만 업로드 가능'> multiple='multiple'");
    		var addTd2=$("<td></td>");
    		var deleteBtn = $('<th><button type="button" class="btn btn-primary1 pull-left" id="deleteA" name="deleteA">삭제</button></th>');
    		
    	
    		addTd2.append(deleteBtn);
    		addTd.append(addInput);
    	
    	
    		$(addTr).append(addTh);
    		$(addTr).append(addTd);
    		$(addTr).append(addTd2);
    		$(this).parents('tr').before(addTr);
    		++filecount;
    		++detailImgCount;
    		console.log("detailImgCount1 : " + detailImgCount);
    		
    		if (detailImgCount >= 1) {
    	    	console.log("detailImgCount가 1보다 크거나 같다");
    	 
    	        console.log("뭘까? : " + $(".newProductDetailImg" + detailImgCount).val(''));
    	        $(".newProductDetailImg" + detailImgCount).on("change", newEnrollDetailImg);
    	        
    	    }
    		
    		
    		$(deleteBtn).on("click",function(e){
    			--filecount;  
    			--detailImgCount;
    			$(e.target).parents('tr').remove();
				console.log("detailImgCount2 : " + detailImgCount);
    		});

    	}else{
    		console.log(filecount);
    		alert('파일은 최대 10개까지 가능합니다.');	
    	}   		
    });
    
    $("#newProductDetailImg").on("change", defaultEnrollDetailImg);
    
    function defaultEnrollDetailImg(e) {
		var files = e.target.files;
		var filesArr = Array.prototype.slice.call(files);
		
		filesArr.forEach(function(f) {
			if (!f.type.match("image/*")) {
				alert("이미지 확장자만 등록해주세요.");
						
				$(".newProductDetailImg" + detailImgCount).val('');

				return;
			}
		});
	}
    
    function newEnrollDetailImg(e) {
    	console.log("새로생긴 버튼 막아보자");
		var files = e.target.files;
		var filesArr = Array.prototype.slice.call(files);
		
		filesArr.forEach(function(f) {
			if (!f.type.match("image/*")) {
				alert("이미지 확장자만 등록해주세요.");
				$(".newProductDetailImg" + detailImgCount).val('');
				
				return;
			}
		});
	}
})

// 상품 옵션 추가
var optioncount = 1;

$(function(){
    $('#optionAdd').on("click",function(e){
    	if(optioncount < 10){
    		
    		var addTr=$("<tr></tr>");
    		var addTh=$("<th>상세옵션</th>");
   	 		var addTd=$("<td></td>");
   	 		var addInput =$("<input type='text' id='newProductOption' name='newProductOption' class='newProductOption" + optioncount +"' placeholder='상품 옵션을 추가해주세요.'>");
    		
   	 		
    		var addTd2=$("<td></td>");
    		var deleteBtn = $('<th><button type="button" class="btn btn-primary1 pull-left" id="deleteA" name="deleteA">삭제</button></th>');
    		
    	
    		addTd2.append(deleteBtn);
    		addTd.append(addInput);
    	
    	
    		$(addTr).append(addTh);
    		$(addTr).append(addTd);
    		$(addTr).append(addTd2);
    		$(this).parents('tr').before(addTr);
    		++optioncount;
    		
    		
    		$(deleteBtn).on("click",function(e){
    			--optioncount;  
    			$(e.target).parents('tr').remove();

    		});

    	}else{
    		alert('파일은 최대 10개까지 가능합니다.');
        	
    	}
    });
})
</script>



<section>
	<div class="container">
		<ul class="breadcrumb">
			<li><a href="${path }"><i class="fa fa-home"></i></a></li>
			<li><a href="${path}/admin/adminPage.do">관리자페이지</a></li>
			<li><a href="${path}/admin/manageProduct.do">상품 관리</a></li>
			<li><a href="${path}/admin/enrollProduct.do">상품 등록</a></li>
		</ul>
		<br />
		<div class="row">
			<div class="col-sm-3 hidden-xs column-left" id="column-left">
				<div class="column-block">
					<div class="columnblock-title">관리자페이지</div>
					<div class="account-block">
						<div class="list-group">
							<a class="list-group-item" href="${path}/admin/adminPage.do">홈</a>					
							<a class="list-group-item" href="${path}/admin/memberList.do">회원목록</a>
							<a class="list-group-item"	href="${path}/admin/manageBrand.do">브랜드 등록관리</a>							
							<a class="list-group-item" href="${path}/admin/managePreProduct.do">입점 제안관리</a>
							<a class="list-group-item" href="${path}/admin/manageProduct.do">상품 등록/수정 관리</a>												 
							<a class="list-group-item" href="${path}/admin/manageReProduct.do">상품 종료/중지 목록</a>
							<a class="list-group-item"	href="${path}/admin/manageRequest.do">폐점신고/상품 판매중지 요청</a>					 
						</div>
					</div>
				</div>
			</div>
			<!-- 정보 변경 전에 다시 비밀번호 확인 -->
			<div class="col-sm-9" id="content">
				<div class="row">
					<div class="col-sm-12">
						<form name="productEnrollEndFrm" action="${path}/admin/enrollProductEnd.do" method="post" onsubmit="return validate();" enctype="multipart/form-data">
						
 						<fieldset id="productField0">
						<div class="col-sm-3">
						<select class="form-control" id="select-brand" name="brandNo" required>
							<c:forEach items="${brandList }" var="b" varStatus="vs">
								<option ${vs.count==1? "selected" : ""} value="${b.brandNo }">${b.brandTitle}</option>
							</c:forEach>
						</select>
						</div>			
						<div class="col-sm-3">
						<select class="form-control" id="select-bigCategory" name="bcNo" required>
							<c:forEach items="${bcList }" var="b" varStatus="vs">
								<option ${vs.count==1? "selected" : ""} value="${b.bcNo }">${b.bcTitle}</option>
							</c:forEach>	
						</select>
						</div>
						<div class="col-sm-3">
						<select class="form-control" id="select-smallCategory" name="scNo" required>
							<c:forEach items="${scList }" var="s" varStatus="vs">
								<option ${vs.count==1? "selected" : ""} value="${s.scNo }">${s.scTitle}</option>
							</c:forEach>
						</select>
						</div>
							
							</fieldset>
																					
							<fieldset id="productField1">	
								<!-- 상품명 -->							
								<div class="form-group required">
									<label for="adminProductName" class="col-sm-2 control-label">상품명</label>
									<div class="col-sm-10">
										<input type="text" class="form-control" id="newProductName" name="newProductName" placeholder="상품명을 입력하세요" maxlength="100">
									</div>
								</div>
								<!-- 상품 코멘트 -->
								<div class="form-group required">
									<label for="adminProductComment" class="col-sm-2 control-label">한줄설명</label>
									<div class="col-sm-10">
										<input type="text" class="form-control" id="newProductComment" name="newProductComment" placeholder="상품의 간단한 설명을 입력하세요" maxlength="100">
									</div>
								</div>
								<!-- 상품 관리자 + 판매자 아이디 -->
								<div class="form-group required">
									<label for="adminProductId" class="col-sm-2 control-label">상품등록자</label>
									<div class="col-sm-4">
										<h4>${member.memberName }</h4>										
									</div>
<!-- 									<label for="adminProductMemberId" class="col-sm-2 control-label">판매자</label>
									<div class="col-sm-4">
										<input type="text" class="form-control" id="newProductMemberId" name="newProductMemberId" placeholder="판매자의 아이디를 적어주세요">
									</div> -->
								</div>
							</fieldset>

							
							<fieldset id="productField2">
								<!-- 상품가격 -->
								<div class="form-group required">
									<label for="adminProductPrice" class="col-sm-2 control-label">상품가격</label>
									<div class="col-sm-4">
										<input type="text" class="form-control" id="newProductPrice" name="newProductPrice" placeholder="상품가격을 적어주세요(원)">								
									</div>
									<label for="adminProductSale" class="col-sm-2 control-label">할인율</label>
									<div class="col-sm-4">									
										<input type="text" class="form-control" id="newProductSale" name="newProductSale" min="0" max="99" placeholder="0부터 99까지 입력해주세요.">
									</div>
								</div>
								<!-- 등록날짜 ~ 마감날짜 -->
								<div class="form-group required">
									<label for="adminProductSaleStart" class="col-sm-2 control-label">판매 시작일</label>
									<div class="col-sm-4">
										<input type="datetime" class="form-control" id="newProductSaleStart" name="newProductSaleStart" placeholder="오늘부터 판매가 시작됩니다." readonly="readonly">
									</div>								
									<label for="adminProductSaleEnd" class="col-sm-2 control-label">판매 종료일</label>
									<div class="col-sm-4">
										<input type="date" class="form-control" id="newProductSaleEnd" name="newProductSaleEnd" placeholder="마감날짜">
									</div>
								</div>
								<!-- 최소주문량 ~ 최대주문량 -->
								<div class="form-group required">
									<label for="adminProductMin" class="col-sm-2 control-label">최소주문량</label>
									<div class="col-sm-4">
										<input type="text" class="form-control" id="newProductMin" name="newProductMin"  min='1' max='10000' placeholder="1부터 10000까지 입력해주세요.">						
									</div>							
									<label for="adminProductMax" class="col-sm-2 control-label">최대주문량</label>
									<div class="col-sm-4">
										<input type="text" class="form-control" id="newProductMax" name="newProductMax"  min='1' max='10000' placeholder="1부터 10000까지 입력해주세요.">
									</div>
								</div>						
							</fieldset>
							
							<fieldset id="productField2">
								<div class="form-group required">
									<label for="adminProductProfile" class="col-sm-2 control-label">메인사진</label>
									<div class="col-sm-3">
										<input type="file" name="newProductProfile" id="newProductProfile" >
									</div>
									<div class="col-sm-9">
										
									</div>
								</div>
								<div class="form-group required">
									<div class="col-sm-3">
									</div>
									<div class="col-sm-6">
											<img id="adminProductProfileMainImg" src="${path }/resources/image/noImg.png">										
									</div>
									<div class="col-sm-3">
									</div>								
								</div>

							</fieldset>

  
							<fieldset>
								<table class="table table-bordered board" id="product_detailimage_table" name="product_detailimage_table">
									<tbody class="tbody_">
										<tr>
											<th>상품사진</th>
											<td><input type="file" name="newProductDetailImg" id="newProductDetailImg" class="newProductDetailImg0"
												title="파일첨부  : 용량 1,048,576 바이트 이하만 업로드 가능"
												multiple="multiple"></td>
											<th></th>
										</tr>

										<tr>
											<td colspan="2">
												<div class="btn_confirm">													
													<button type="button" class="btn btn-primary1 pull-left"
														id="fileAdd" name="fileAdd">사진추가</button>
												</div>

											</td>
											<th></th>
										</tr>
									</tbody>
								</table>
							</fieldset>



  							<fieldset>
								<table class="table table-bordered board"
									id="product_option_table" name="product_option_table">
									<tbody class="tbody_">
										<tr>
											<th>상세옵션</th>
											<td><input type="text" name="newProductOption" id="newProductOption" class="newProductOption" placeholder="상품 옵션을 추가해주세요."></td>
											<th></th>
										</tr>

										<tr>
											<td colspan="2">
												<div class="btn_confirm">							
													<button type="button" class="btn btn-primary1 pull-left"
														id="optionAdd" name="optionAdd">옵션추가</button>
												</div>

											</td>
											<th></th>
										</tr>
									</tbody>
								</table>
							</fieldset>



							<fieldset>
								<table class="table table-bordered board"
									id="product_option_table" name="product_option_table">
									<tbody class="tbody_">										
										<tr><td>상품 상세내용 작성</td></tr>
										<tr>
											<td>
											<textarea class="newProductDetail" id="summernote" name="newProductDetail" maxlength="140" rows="7">
											
											</textarea>
											
											</td>
											
										</tr>
									</tbody>
								</table>
							</fieldset>


							<div class="buttons">
								<div class="pull-right">
									<input type="submit" class="btn btn-primary" value="등록하기">
								</div>
							</div>
						</form>
					</div>
				</div>
			</div>


		</div>
	</div>
</section>


<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>