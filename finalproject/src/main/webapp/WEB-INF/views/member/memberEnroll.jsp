<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath }" />
<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
<style>
	/*중복아이디 체크 관련*/
    div.well {position:relative; padding:0px;}
    div.well span.guide {display:none;font-size: 12px;position:absolute; top:12px; right:10px;}
    div.well span.ok{color:green;}
    div.well span.error{color:red;}
    
    /* 중복이메일 체크 관련 */
    div.well span.guideEmail {display:none;font-size: 12px;position:absolute; top:12px; right:10px;}
    div.well span.emailOk {color: green;}
    div.well span.emailError {color:red;}
    
    /* 인증 코드 발송, 인증 코드 확인 버튼 */
    #emailCertification, #enterCertification {
    	padding: 6px 17px;
    	margin-top: 10px;
    	margin-bottom: 10px;
    }
    
    /* 바깥쪽 div */
    .well {
    	height: 465px;
    	border-color: white;
    }
    
    /* input text들 */
    #memberId, #memberPwd, #memberPwdCheck, #memberName, #memberEmail, #checkCerCode, #memberPhone {
    	margin-top: 10px;
    	margin-bottom: 10px;
    }
    
    /* 회원가입 버튼 */
    #submit {
    	margin-top: 10px;
    	margin-bottom: 10px;
    }
</style>

<script>
	var checkEmailCount = 0;
	var checkEmailState = false;
	$(function() {
		$("#emailCertification").click(function() {
			
			if(checkEmailCount==0){				
				var memberEmail = $("#memberEmail").val();
				if(memberEmail!=""){				
					$.ajax({
						url:"${path}/member/mailSending.do",
						data:{"memberEmail" : memberEmail},
						success:function(data) {	
							if(checkEmailCount == 0){
								alert("인증번호가 발송되었습니다. 이메일을 확인해주세요.");
								var input = $('<input type="text" class="form-control" id="checkCerCode" placeholder="인증 코드 입력" name="checkCerCode">');
								var enter = $('<a id="'+data.randomNumber+'" onclick="compareCode(this);"><input type="button" value="인증 코드 확인" id="enterCertification" class="btn btn-primary"/></a>');
								$("#enterCerCode").append(input);
								$("#enter").append(enter);
								checkEmailCount = 1;													
								console.log("보내준 인증코드: "+data.randomNumber);
							}
						}
					});
				}else{
					alert("이메일을 입력해주세요.");
				}
			}else{
				alert("이메일을 확인해주세요. 인증코드가 이미 발송되었습니다.");
			}
		});
	});


	compareCode = function(e) {      	   
		var inputCode = $("#checkCerCode").val();
	    var ranNumber = $(e).attr("id");
		console.log("ranNumber:  " + ranNumber);
		console.log("inputCode:  " + inputCode);
		
		if(ranNumber == inputCode){
			alert("인증이 완료되었습니다.");
			checkEmailState = true;
			$("#enterCerCode").remove();
			$("#enter").remove();
			$("#memberEmail").attr("readonly",true);
			$("#emailCertification").attr("disabled",true);
		}else{
			alert("잘못된 인증코드입니다.");
		}
	}
	
	
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
		
		if (checkEmailState == false) {
			alert("이메일 인증이 되지 않았습니다. 이메일 인증을 해주세요.");
			$("#memberEmail").focus();
			
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
	
	$(function(){
		var emailRegex = /^([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/;
		$("#memberEmail").keyup(function(){
		var memberEmail=$("#memberEmail").val().trim();
		
		if(!emailRegex.test(memberEmail))
		{
			$(".guideEmail").hide();
			return;
		}
		
		$.ajax({
			url:"${path}/member/checkEmail.do",
			data:{"memberEmail":memberEmail},
			success:function(data){
				if(data.isEmail==true) {
					$(".guideEmail.emailOk").hide();
					$(".guideEmail.emailError").show();
					$("#emailCertification").attr("disabled", true).attr("readonly", false);
				} else {
					$(".guideEmail.emailOk").show();
					$(".guideEmail.emailError").hide();
					$("#emailCertification").attr("disabled", false).attr("readonly", true);
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
			<li><a href="${path }"><i class="fa fa-home"></i></a></li>
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
									<div class="col-sm-12">
									<input type="text" class="form-control" id="memberId"
										placeholder="아이디 (4글자이상)" name="memberId">
									<span class="guide ok">이 아이디는 사용할 수 있습니다. </span>
            						<span class="guide error">이 아이디는 사용할 수 없습니다. </span>
            						<input type="hidden" name="checkId" value="0"/>
									</div>
								</div>
								
								<div class="form-group">
									<div class="col-sm-12">
									<input type="password" class="form-control" id="memberPwd" placeholder="패스워드 (영문숫자포함 6글자이상)" value="" name="memberPwd">
									</div>
								</div>
								
								<div class="form-group">
									<div class="col-sm-12">
									<input type="password" class="form-control" id="memberPwdCheck" placeholder="패스워드 확인" value="" name="memberPwdCheck">
									</div>
								</div>
								
								<div class="form-group">
									<div class="col-sm-12">
									<input type="text" class="form-control" id="memberName" placeholder="이름" name="memberName">
									</div>
								</div>
								
								<div class="form-group">
										<div class="col-sm-9">
											<input type="email" class="form-control" id="memberEmail" placeholder="이메일" name="memberEmail">
											<span class="guideEmail emailOk">이 이메일은 사용할 수 있습니다. </span>
            								<span class="guideEmail emailError">이 이메일은 사용할 수 없습니다. </span>
            								<input type="hidden" name="checkEmail" value="0"/>
										</div>
										<div class="col-sm-3">
											<input type="button" value="인증 코드 발송" id="emailCertification" class="btn btn-primary">
										</div>
										<div class="col-sm-9" id="enterCerCode"></div>
										<div class="col-sm-3" id="enter"></div>
								</div>						
							
								<div class="form-group">
									<div class="col-sm-12">
										<input type="text" class="form-control" id="memberPhone" placeholder="핸드폰번호 (-제외)" name="memberPhone" maxlength="11">
									</div>
								</div>
								<div class="col-sm-12">
								<input type="submit" id="submit" class="btn btn-primary" value="회원가입">
								</div>
							</form>
						</div>
					</div>
					<div class="col-sm-3">
					</div>
				</div>
			</div>
		</div>
	</div>
</section>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>