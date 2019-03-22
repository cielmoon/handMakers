<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath }" />

<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
<%-- <jsp:para value="" name="pageTitle"/> --%>

<!-- include libraries(jQuery, bootstrap) -->

<!-- <script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.4/jquery.js"></script> -->
<script src="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.js"></script>
<!-- include summernote css/js-->
<link href="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.2/summernote.css" rel="stylesheet">
<script src="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.2/summernote.js"></script>






<!-- 
<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
<link href="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.11/summernote-lite.css" rel="stylesheet">
<script src="http://code.jquery.com/jquery-3.2.1.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.11/summernote-lite.js"></script>
 -->

<!-- <script src="http://jonthornton.github.io/Datepair.js/dist/datepair.js"></script>
<script src="http://jonthornton.github.io/Datepair.js/dist/jquery.datepair.js"></script> -->
<style>
#newProductProfileImg {
	padding-top: 7px;
	border: none;
}

#newProductOptionList {
	width: 300px;
}

#newProductDetailComments {
	width:800px;
	height:600px;
}
</style>

<script>

	$(document).ready(function() {	
		
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
	     
		$("#newProductProfile").on("change", enrollMainImg);
		// 상품 등록날짜, 마감날짜 
		// 날짜에서 추가할 내용 : 마감날짜는 등록날짜 이후만 클릭되도록 설정해줘야 함
/* 		$("#newProductSaleStart").datepicker({
			language : 'ko',
			format : 'yyyy/mm/dd',
			autoclose : true,
			calendarWeeks : false,
			todayHighlight : true
		});
		
		$("#newProductSaleEnd").datepicker({
			language : 'ko',
			format : 'yyyy/mm/dd',
			autoclose : true,
			calendarWeeks : false,
			todayHighlight : true

		}); */
		
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
    
/* 	function checkDate() {
		var startDate = $("#newProductSaleStart").val();
		var endDate = $("#newProductSaleEnd").val();
		
		console.log("startDate : " + startDate);
		console.log("endDate : " + endDate);
	} */
	
	function validate() {
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

		if ($("#newProductMemberId").val() == "") {
			alert("판매자의 아이디를 입력해주세요.");
			$("#newProductMemberId").focus();

			return false;
		}

		if ($("#newProductPrice").val() == "") {
			alert("상품가격을 입력해주세요.");
			$("#newProductPrice").focus();

			return false;
		}

		if ($("#adminProductSale").val() == "") {
			alert("할인율을 입력해주세요.");
			$("#adminProductSale").focus();

			return false;
		}

		if ($("#newProductSaleStart").val() == "") {
			alert("상품 등록날짜를 입력해주세요.");
			$("#newProductSaleStart").focus();
			
			return false;
		}
		
		if ($("#newProductSaleEnd").val() == "") {
			alert("상품 마감날짜를 입력해주세요.");
			$("#newProductSaleEnd").focus();
			
			return false;
		}

		if ($("#newProductMin").val() == "") {
			alert("최소주문량을 입력해주세요.");
			$("#newProductMin").focus();

			return false;
		}

		if ($("#newProductMax").val() == "") {
			alert("최대주문량을 입력해주세요.");
			$("#newProductMax").focus();

			return false;
		}
		
		return true;
	};
	
	// 메인사진 등록
	function enrollMainImg(e) {
		var files = e.target.files;
		var filesArr = Array.prototype.slice.call(files);
		
		filesArr.forEach(function(f) {
			if (!f.type.match("image.*")) {
				alert("이미지 확장자만 등록해주세요.")
				
				return;
			}
			
			sel_file = f;
			
			var reader = new FileReader();
			reader.onload = function(e) {
				$("#adminProductProfileMainImg").attr("src", e.target.result).css('width', '100%').css('height', '100%');
				console.log("메인사진" + $("#newProductProfileImg").val());
			}
			
			reader.readAsDataURL(f);
		});
	}
</script>

<script>
// 상품 상세 사진 추가
var filecount = 1;

$(function(){
    $('#fileAdd').on("click",function(e){
		console.log(filecount);
		
    	if(filecount < 4){
    		
    		var addTr=$("<tr></tr>");
    		var addTh=$("<th>상품사진</th>");
   	 		var addTd=$("<td></td>");
   	 		var addInput =$("<input type='file' name='newProductDetailImg' title='파일첨부  : 용량 1,048,576 바이트 이하만 업로드 가능'>");
    
    		var addTd2=$("<td></td>");
    		var deleteBtn = $('<th><button type="button" class="btn btn-primary1 pull-left" id="deleteA" name="deleteA">삭제</button></th>');
    		
    	
    		addTd2.append(deleteBtn);
    		addTd.append(addInput);
    	
    	
    		$(addTr).append(addTh);
    		$(addTr).append(addTd);
    		$(addTr).append(addTd2);
    		$(this).parents('tr').before(addTr);
    		++filecount;
    		
    		
    		$(deleteBtn).on("click",function(e){
    			--filecount;  
    			console.log(filecount);
    			$(e.target).parents('tr').remove();

    		});

    	}else{
    		console.log(filecount);
    		alert('파일은 최대 4개까지 가능합니다.');
        	
    	}
    		
    });
})

    /* function test(){
       window.onload();
    } */
    
    /* function validate(){
       var content=$('[name=content]').val();
       if(content.trim().length==0)
       {
          alert("내용을 입력하세요.");
       }
       return true;
    } */
    
    <%-- function fn_boardList(){
       location.href = "<%=request.getContextPath()%>/board/boardList";
	} --%>
	
	
// 상품 옵션 추가
var optioncount = 1;

$(function(){
    $('#optionAdd').on("click",function(e){
    	if(optioncount < 4){
    		
    		var addTr=$("<tr></tr>");
    		var addTh=$("<th>상세옵션</th>");
   	 		var addTd=$("<td></td>");
   	 		var addInput =$("<input type='text' name='newProductOption' id='newProductOptionList' placeholder='상품 옵션을 추가해주세요.''>");
    		
   	 		
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
    		alert('파일은 최대 4개까지 가능합니다.');
        	
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
							<a class="list-group-item" href="${path}/admin/manageProduct.do">상품 관리</a>												 
							<a class="list-group-item" href="${path}/admin/manageReProduct.do">상품 재등록 관리</a>
							<a class="list-group-item"	href="${path}/admin/manageRequest.do">폐점신고 및 상품 판매중지 요청</a>					 
						</div>
					</div>
				</div>
			</div>
			<!-- 정보 변경 전에 다시 비밀번호 확인 -->
			<div class="col-sm-9" id="content">
				<div class="row">
					<div class="col-sm-12">
						<form name="productEnrollEndFrm" action="${path}/admin/enrollProductEnd.do" method="post" onsubmit="return validate();" enctype="multipart/form-data">
						
<%-- 							<fieldset id="productField0">
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
							<div class="col-sm-3">
							<select class="form-control" id="select-brand" name="brandNo" required>
								<c:forEach items="${brandList }" var="b" varStatus="vs">
									<option ${vs.count==1? "selected" : ""} value="${b.brandNo }">${b.brandTitle}</option>
								</c:forEach>
							</select>
							</div>
							<div class="col-sm-3">
							</div>
							
							</fieldset> --%>
							
							
							<fieldset id="productField1">	
								<!-- 상품명 -->							
								<div class="form-group required">
									<label for="adminProductName" class="col-sm-2 control-label">상품명</label>
									<div class="col-sm-10">
										<input type="text" class="form-control" id="newProductName" name="newProductName" placeholder="상품명을 입력하세요">
									</div>
								</div>
								<!-- 상품 코멘트 -->
								<div class="form-group required">
									<label for="adminProductComment" class="col-sm-2 control-label">한줄설명</label>
									<div class="col-sm-10">
										<input type="text" class="form-control" id="newProductComment" name="newProductComment" placeholder="상품의 간단한 설명을 입력하세요">
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
										<input type="number" class="form-control" id="newProductSale" name="newProductSale"  min='1' max='100' step='4'>
									</div>
								</div>
								<!-- 등록날짜 ~ 마감날짜 -->
								<div class="form-group required">
									<label for="adminProductSaleStart" class="col-sm-2 control-label">등록날짜</label>
									<div class="col-sm-4">
										<input type="date" class="form-control" id="newProductSaleStart" name="newProductSaleStart" placeholder="등록날짜" onclick="checkDate();">
									</div>								
									<label for="adminProductSaleEnd" class="col-sm-2 control-label">마감날짜</label>
									<div class="col-sm-4">
										<input type="date" class="form-control" id="newProductSaleEnd" name="newProductSaleEnd" placeholder="마감날짜" onclick="checkDate();">
									</div>
								</div>
								<!-- 최소주문량 ~ 최대주문량 -->
								<div class="form-group required">
									<label for="adminProductMin" class="col-sm-2 control-label">최소주문량</label>
									<div class="col-sm-4">
										<input type="number" class="form-control" id="newProductMin" name="newProductMin"  min='1' max='10000' step='5'>						
									</div>							
									<label for="adminProductMax" class="col-sm-2 control-label">최대주문량</label>
									<div class="col-sm-4">
										<input type="number" class="form-control" id="newProductMax" name="newProductMax"  min='1' max='10000' step='5'>
									</div>
								</div>						
							</fieldset>
							
							<fieldset id="productField2">
								<div class="form-group required">
									<label for="adminProductProfile" class="col-sm-2 control-label">메인사진</label>
									<div class="col-sm-2">
									<input type="file" name="newProductProfile" id="newProductProfile" >
									</div>	
								</div>
								<div class="col-sm-3">
								</div>
								<div class="col-sm-6">
										<img id="adminProductProfileMainImg" src="${path }/resources/image/noImg.png">										
								</div>
								<div class="col-sm-3">
								</div>
							</fieldset>

  
							<fieldset>
								<table class="table table-bordered board" id="product_detailimage_table" name="product_detailimage_table">
									<tbody class="tbody_">
										<tr>
											<th>상품사진</th>
											<td><input type="file" name="newProductDetailImg"
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
											<td><input type="text" name="newProductOption" id="newProductOption"
												id="option_upload" placeholder="상품 옵션을 추가해주세요."></td>
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
											<textarea class="form-control" id="summernote" name="newProductDetail" maxlength="140" rows="7">
											
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