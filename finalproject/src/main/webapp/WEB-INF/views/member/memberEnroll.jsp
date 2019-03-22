<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath }" />
<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
<style>
	/*중복아이디체크관련*/
    div.well {position:relative; padding:0px;}
    div.well span.guide {display:none;font-size: 12px;position:absolute; top:12px; right:10px;}
    div.well span.ok{color:green;}
    div.well span.error{color:red;}
</style>

<script>
	function validate() {
		/* 
		아이디 : OK (아이디 존재 유무 확인은 해주는데 중복가입을 막아야 함 -> 버튼 활성화 / 비활성화로 함)
		패스워드 : 나중에 추가
		이름 : OK
		나이 : 삭제
		이메일 : OK
		핸드폰번호 : OK
		*/
		var memberId = $('#memberId').val();
		var memberPwd = $('#memberPwd').val();
		var memberName = $('#memberName').val();
		var memberEmail = $("#memberEmail").val();
		var memberPhone = $("#memberPhone").val();
		var emailRegex = /^([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/;
		var phoneRegex = /^[0-9]+$/;
		var passwordRegex = /^.*(?=.{6,20})(?=.*[0-9])(?=.*[a-zA-Z]).*$/; // 영문, 숫자 혼합하여 6~20자리 이내
		var idRegex = /^[A-Z|a-z|0-9]+$/;
		var nameRegex = /^[ㄱ-ㅎ|가-힣|a-z|A-Z|\*]+$/;
		
		if (memberId.length < 4) {
			alert("아이디는  영문, 숫자를 사용하여 4~16자리 이내로 입력해주세요.");
			$("#memberId").focus();
			
			return false;
		}
		
		if ($("#memberName").val() == "") {
			alert("이름을 입력해주세요.");
			$("#memberName").focus();
			
			return false;
		}
		
		if ($("#memberPwd").val() == "") {
			alert("비밀번호를 입력해주세요.");
			$("#memberPwd").focus();
			
			return false;
		}
		
		if ($("#memberPwdCheck").val() == "") {
			alert("비밀번호 확인을 해주세요.");
			$("#memberPwd").focus();
			
			return false;
		}
		
		if ($("#memberBirth").val() == "") {
			alert("나이를  입력해주세요.");
			$("#memberBirth").focus();
			
			return false;
		}
		
		if ($("#memberEmail").val() == "") {
			alert("이메일을 입력해주세요.");
			$("#memberEmail").focus();
			
			return false;
		}
		
		if ($("#memberPhone").val() == "") {
			alert("핸드폰번호를 입력해주세요.");
			$("#memberPhone").focus();
			
			return false;
		}
		
		if (!idRegex.test(memberId)) {
			alert("아이디는  영문, 숫자를 사용하여 4~16자리 이내로 입력해주세요.");
			$("#memberId").focus();
			
			return false;
		}
		
		if (!nameRegex.test(memberName)) {
			alert("이름은 한글 또는 영어로 입력해주세요.");
			$("#memberName").focus();
			
			return false;
		}
		
		if (!emailRegex.test(memberEmail)) {
			alert("잘못된 이메일 형식입니다. 다시 입력해주세요.");
			$("#memberEmail").focus();
			
			return false;
		}
		
		if (!phoneRegex.test(memberPhone)) {
			alert("핸드폰번호는 숫자만 입력해주세요.");
			$("#memberPhone").focus();
			
			return false;
		}
		
		if (!passwordRegex.test(memberPwd)) {
			alert("비밀번호는 영문, 숫자, 특수문자를 사용하여 6~20자리 이내로 입력해주세요.");
			$("#memberPwd").focus();
			
			return false;
		}

		return true;
	};
	
	$(function(){
		$("#memberId").keyup(function(){
		var memberId=$("#memberId").val().trim();
		
		if(memberId.length<4)
		{
			$(".guide").hide();
			return;
		}
		$.ajax({
			url:"${path}/member/checkId.do",
			data:{"memberId":memberId},
			success:function(data){
				if(data.isId==true) {
					$(".guide.ok").hide();
					$(".guide.error").show();
					$("#submit").attr("disabled", true).attr("readonly", false);
				} else {
					$(".guide.ok").show();
					$(".guide.error").hide();
					$("#submit").attr("disabled", false).attr("readonly", true);
				}	
			}
		});
		});
	});
	
	$(function() {
		$("#memberPwdCheck").blur(function() {
			var p1 = $("#memberPwd").val(), p2 = $("#memberPwdCheck").val();
			
			if (p1 != p2) {
				alert("패스워드가 일치하지 않습니다.");
				$("#memberPwdCheck").val('');
				$("#memberPwd").focus();
			}
		});
	});
</script>

<section>
	<div class="container">
		<ul class="breadcrumb">
			<li><a href="${pageContext.request.contextPath }"><i
					class="fa fa-home"></i></a></li>
			<li><a href="#">MyAccount</a></li>
			<li><a href="#">회원가입</a></li>
		</ul>
		<div class="row">
			<div class="col-sm-12" id="content">
				<div class="row">
					<div class="col-sm-3"></div>
					<div class="col-sm-6">
						<div class="well">
							<form name="memberEnrollFrm" action="${path}/member/memberEnrollEnd.do" method="post" onsubmit="return validate();" >
								<div class="form-group">
									<input type="text" class="form-control" id="memberId"
										placeholder="아이디 (4글자이상)" name="memberId">
									<span class="guide ok">이 아이디는 사용할 수 있습니다. </span>
            						<span class="guide error">이 아이디는 사용할 수 없습니다. </span>
            						<input type="hidden" name="checkId" value="0"/>
            						<!-- <script>
            							
            						</script> -->
								</div>
								
								<div class="form-group">
									<input type="password" class="form-control" id="memberPwd"
										placeholder="패스워드 (영문숫자포함 6글자이상)" value="" name="memberPwd">
								</div>
								
								<div class="form-group">
									<input type="password" class="form-control" id="memberPwdCheck"
										placeholder="패스워드 확인" value="" name="memberPwdCheck">
								</div>
								
								<div class="form-group">
									<input type="text" class="form-control" id="memberName"
										placeholder="이름" name="memberName">
								</div>
								<!-- <div class="form-group">
									<input type="text" class="form-control" id="memberBirth"
										placeholder="나이 (1~100사이 숫자만)" value="" name="memberBirth">
								</div> -->
								
								<div class="form-group">
									<input type="text" class="form-control" id="memberEmail"
										placeholder="이메일" name="memberEmail">
								</div>
								
								<div class="form-group">
									<input type="text" class="form-control" id="memberPhone"
										placeholder="핸드폰번호 (-제외)" name="memberPhone" maxlength="11">
								</div>
								<input type="submit" id="submit" class="btn btn-primary" value="회원가입">
							</form>
						</div>
					</div>
					<div class="col-sm-3"></div>
				</div>
			</div>
		</div>
	</div>
</section>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>