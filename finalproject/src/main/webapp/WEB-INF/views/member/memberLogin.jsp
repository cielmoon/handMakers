<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<style>
.modal-dialog {
   z-index: 1050;
}

.modal-body {
   padding-top: 5px;
}

#emailCertification, #enterCertification, #emailCertificationForPwd, #enterCertificationForPwd {
    padding: 6px 17px;
    margin-top: 10px;
    margin-bottom: 10px;
}

#memberEmail, #memberEmailForPwd, #checkCerCode, #checkCerCodeForPwd {
	margin-top: 10px;
    margin-bottom: 10px;
}

#memberNewPwd, #memberNewPwdCheck {
	margin-top: 10px;
    margin-bottom: 10px;
}

#submit {
    margin-top: 10px;
    margin-bottom: 10px;
}
</style>

<script>
	var checkEmailCount = 0;
	var checkEmailState = false;
	var checkEmailCountForPwd = 0;
	var checkEmailStateForPwd = false;
	
	$(function() {
		$("#emailCertification").click(function() {			
			if(checkEmailCount==0){				
				var memberEmail = $("#memberEmail").val();
				if(memberEmail!=""){	
					$.ajax({
						url:"${path}/member/mailCheck.do",
						data:{"memberEmail" : memberEmail},
						success:function(data) {	
							if(data.emailState == "T"){
								alert("인증번호가 발송되었습니다. 이메일을 확인해주세요.");
								var input = $('<input type="text" class="form-control" id="checkCerCode" placeholder="인증 코드 입력" name="checkCerCode">');
								var enter = $('<a id="'+data.randomNumber+'" value="'+memberEmail+'"onclick="compareCode(this);"><input type="button" value="인증 코드 확인" id="enterCertification" class="btn btn-primary"/></a>');
								var newEmailCertification = $('<input type="button" value="인증 코드 발송" id="emailCertification" class="btn btn-primary" disabled="disabled">');
								
								$("#enterCerCode").append(input);
								$("#enter").append(enter);
								$("#emailCertificationArea").html(newEmailCertification);
								
								checkEmailCount = 1;													
								console.log("보내준 인증코드: "+data.randomNumber);
							} else {
								alert("등록된 이메일이 존재하지 않습니다. 다시 입력해 주세요.");
								$("#memberEmail").val('');
								$("#memberEmail").focus();
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
	    var memberEmail = $(e).attr("value");
		console.log("ranNumber:  " + ranNumber);
		console.log("inputCode:  " + inputCode);
		
		if(ranNumber == inputCode){
			checkEmailState = true;
			$("#enterCerCode").remove();
			$("#enter").remove();
			$("#memberEmail").attr("readonly",true);
			$("#emailCertification").attr("disabled",true);			
			
			$.ajax({
				url:"${path}/member/memberIdFind.do",
				data:{"memberEmail" : memberEmail},
				success:function(data) {
					alert("아이디가 발송되었습니다. 이메일을 확인해주세요.");
					location.href="${path}/member/memberLogin.do";
				}
				
			});
			
		}else{
			alert("잘못된 인증코드입니다.");
		}
	}		
	
	$(function() {
		$("#emailCertificationForPwd").click(function() {
			if(checkEmailCountForPwd==0){
				var memberEmailForPwd = $("#memberEmailForPwd").val();
				var memberEmailIdForPwd = $("#memberIdForPwd").val();
				console.log("memberEmailForPwd: " + memberEmailForPwd);
				console.log("memberEmailIdForPwd: " + memberEmailIdForPwd);
				if(memberEmailForPwd != "" && memberEmailIdForPwd != ""){	
					$.ajax({
						url:"${path}/member/mailSendingForPwd.do",
						data:{"memberEmail" : memberEmailForPwd, "memberEmailId" : memberEmailIdForPwd},
						success:function(data) {	
							if(data.memberState == "T"){
								alert("인증번호가 발송되었습니다. 이메일을 확인해주세요.");
								var input = $('<input type="text" class="form-control" id="checkCerCodeForPwd" placeholder="인증 코드 입력" name="checkCerCodeForPwd">');
								var enter = $('<a id="'+data.randomNumber+'" value="'+memberEmailIdForPwd+'"onclick="compareCodeForPwd(this);"><input type="button" value="인증 코드 확인" id="enterCertificationForPwd" class="btn btn-primary"/></a>');
								var newEmailCertificationForPwd = $('<input type="button" value="인증 코드 발송" id="emailCertificationForPwd" class="btn btn-primary" disabled="disabled">');
								
								$("#enterCerCodeForPwd").append(input);
								$("#enterForPwd").append(enter);
								$("#inputEmailBtnForPwd").html(newEmailCertificationForPwd);
								
								checkEmailCountForPwd = 1;
							} else {
								alert("이메일 또는 아이디가 일치하지 않습니다.");
								$("#memberIdForPwd").val('');
								$("#memberEmailForPwd").val('');
								$("#memberIdForPwd").focus();
							}
						}
					});
				}else{
					alert("이메일 또는 아이디의 빈칸이 존재합니다.");
				}
			} else {
				alert("이메일을 확인해주세요. 인증코드가 이미 발송되었습니다.");
			}
		});
	});
	
	compareCodeForPwd = function(e) {      	   
		var inputCode = $("#checkCerCodeForPwd").val();
		
	    var ranNumber = $(e).attr("id");
	    var memberId = $(e).attr("value");
		console.log("ranNumber:  " + ranNumber);
		console.log("inputCode:  " + inputCode);
		
		if(ranNumber == inputCode){
			checkEmailStateForPwd = true;
			$("#enterCerCodeForPwd").remove();
			$("#enterForPwd").remove();
			$("#inputIdForPwd").remove();
			$("#inputEmailForPwd").remove();
			$("#inputEmailBtnForPwd").remove();
			
			var newPwd = $('<input type="password" class="form-control" id="memberNewPwd" placeholder="패스워드 (영문숫자포함 6글자이상)" value="" name="memberNewPwd">');
			var newPwdCheck = $('<input type="password" class="form-control" id="memberNewPwdCheck" placeholder="패스워드 확인" value="" name="memberNewPwdCheck">');
			var submitBtn = $('<a id="'+memberId+'" onclick="updateNewPwd(this);"><input type="button" value="비밀번호 변경" class="btn btn-primary"/></a>');
				
			$("#newPassword").append(newPwd);
			$("#newPasswordCheck").append(newPwdCheck);
						
			/* 
			$("#memberEmailForPwd").attr("readonly",true);
			$("#emailCertificationForPwd").attr("disabled",true);	 */		
			
			$("#modal-footer").append(submitBtn);
			
			/* $.ajax({
				url:"${path}/member/memberIdFind.do",
				data:{"memberEmail" : memberEmail},
				success:function(data) {
					alert("아이디가 발송되었습니다. 이메일을 확인해주세요.");
					location.href="${path}/member/memberLogin.do";
				}
				
			}); */
			
		}else{
			alert("잘못된 인증코드입니다.");
		}
	}
	
	updateNewPwd = function(e) {      	   
		var newPwd = $("#memberNewPwd").val();
		var newPwdCheck = $("#memberNewPwdCheck").val();
		var passwordRegex = /^.*(?=.{6,20})(?=.*[0-9])(?=.*[a-zA-Z]).*$/; // 영문, 숫자 혼합하여 6~20자리 이내
	    var memberId = $(e).attr("id");

		console.log("newPwd:  " + newPwd);
		console.log("memberId:  " + memberId);
		
		if (newPwd == "" || newPwdCheck == "") {
			alert("비밀번호란 또는 비밀번호 확인란에 빈칸이 존재합니다.");
			$("#memberNewPwd").focus();
		} else if (newPwd != newPwdCheck) {
			alert("패스워드가 일치하지 않습니다.");
			$("#memberNewPwd").val('');
			$("#memberNewPwdCheck").val('');
			$("#memberNewPwd").focus();
		} else if (!passwordRegex.test(newPwd)) {
			alert("비밀번호는 영문, 숫자, 특수문자를 사용하여 6~20자리 이내로 입력해주세요.");
			$("#memberNewPwdCheck").val('');
			$("#memberNewPwd").val('');
			$("#memberNewPwd").focus();
		} else {
			$.ajax({
				url:"${path}/member/newPwdChange.do",
				data:{"newPwd" : newPwd, "memberId" : memberId},
				success:function(data) {	
					if(data.memberState == "T"){
						alert("비밀번호 변경이 완료되었습니다.");
						location.href="${path}/member/memberLogin.do";
					
					}else{
						alert("비밀번호 변경에 실패하였습니다.");					
					}
				}
			});
		}	
	}
	
	
	
 	function validate() {
 		if ($("#memberId").val() == "") {
			alert("아이디를 입력해주세요.");
			$("#memberId").focus();
			
			return false;
		}
 		
 		if ($("#memberPwd").val() == "") {
			alert("비밀번호를 입력해주세요.");
			$("#memberPwd").focus();
			
			return false;
		}
 		
 		return true;
/* 		var memberEmail = $("#memberEmail").val();
		var emailRegex = /^([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/;

		if ($("#memberEmail").val() == "") {
			alert("이메일을 입력해주세요.");
			$("#memberEmail").focus();
			
			return false;
		}
		
		if (!emailRegex.test(memberEmail)) {
			alert("잘못된 이메일 형식입니다. 다시 입력해주세요.");
			$("#memberEmail").focus();
			
			return false;
		}
		
		if (checkEmailState == false) {
			alert("이메일 인증이 되지 않았습니다. 이메일 인증을 해주세요.");
			$("#memberEmail").focus();
			
			return false;
		}
		return true; */
	}; 
</script>

<section>
	<div class="container">
		<ul class="breadcrumb">
			<li><a href="${path }"><i class="fa fa-home"></i></a></li>
			<li><a href="#">MyAccount</a></li>
			<li><a href="#">로그인</a></li>
		</ul>
		<div class="row">
			<div class="col-sm-12" id="content">
				<div class="row">
					<div class="col-sm-3"></div>
					<div class="col-sm-6">
						<div class="well">						
							<form name="memberLoginFrm" action="${pageContext.request.contextPath}/member/memberLoginEnd.do" method="post" onsubmit="return validate();" >
								<div class="form-group">							
									<input type="text" class="form-control" id="memberId" placeholder="아이디" name="memberId" maxlength="18">
								</div>
								<div class="form-group">							
									<input type="password" class="form-control" id="memberPwd" placeholder="패스워드" value="" name="memberPwd" maxlength="22"> 
					 				
					 				
					 				<a href="#" data-toggle="modal" data-target="#findIdModal">아이디 찾기</a>
					 				<a> / </a>
									<a href="#" data-toggle="modal" data-target="#findPwdModal">비밀번호 찾기</a>
									<a> / </a>
									<a href="#" onclick="location.href='${path}/member/memberEnroll.do'">회원가입</a>						
								</div>
								<input type="submit" class="btn btn-primary" value="로그인">
							</form>
						</div>
					</div>
					<div class="col-sm-3">
					</div>
				</div>
			</div>
		</div>
	</div>

         <div class="modal fade" tabindex="-1" role="dialog" id="findIdModal">
           <div class="modal-dialog">
             <div class="modal-content">
               <div class="modal-header">
                 <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">×</span>
                 </button>
                 <h4 class="modal-title" id="modalTitle" style="display: inline;">아이디 찾기</h4>
               </div>
               <div class="modal-body">
                  <div class="row">
                    <div class="form-group">
						<div class="col-sm-9">
							<input type="email" class="form-control" id="memberEmail" placeholder="이메일" name="memberEmail">
						</div>
						<div class="col-sm-3" id="emailCertificationArea">
							<input type="button" value="인증 코드 발송" id="emailCertification" class="btn btn-primary">
						</div>
						<div class="col-sm-9" id="enterCerCode"></div>
						<div class="col-sm-3" id="enter"></div>	
					</div>	
                 </div>
              </div>     
             </div>
           </div>
         </div>
	
	
		<div class="modal fade" tabindex="-1" role="dialog" id="findPwdModal">
           <div class="modal-dialog">
             <div class="modal-content">
               <div class="modal-header">
                 <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">×</span>
                 </button>
                 <h4 class="modal-title" id="modalTitle" style="display: inline;">비밀번호 찾기</h4>
               </div>
               
               <div class="modal-body">
                  <div class="row"> 
                    <div class="form-group">
                    	<div class="col-sm-12" id="inputIdForPwd">
                    		<input type="text" class="form-control" id="memberIdForPwd" placeholder="아이디" name="memberIdForPwd">                    	
                    	</div>
						<div class="col-sm-9" id="inputEmailForPwd">
							<input type="email" class="form-control" id="memberEmailForPwd" placeholder="이메일" name="memberEmail">
						</div>
						<div class="col-sm-3" id="inputEmailBtnForPwd">
							<input type="button" value="인증 코드 발송" id="emailCertificationForPwd" class="btn btn-primary">
						</div>
						<div class="col-sm-9" id="enterCerCodeForPwd"></div>
						<div class="col-sm-3" id="enterForPwd"></div>
												
						<div class="col-sm-12" id="newPassword"></div>
						<div class="col-sm-12" id="newPasswordCheck"></div>
						<!-- <button class="btn btn-outline-success my-2 my-sm-0" type="button" data-toggle="modal" data-target="#emailModal">이메일 인증</button> -->
						<%-- <input type="button" value="메일 보내기" id='btn-add' class='btn btn-outline-success' onclick='location.href="${path}/member/mailSending.do"'/> --%>	
					</div>	
                 </div>
              </div>
               <div class="modal-footer" id="modal-footer"></div>          
             </div>
           </div>
         </div>
</section>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>