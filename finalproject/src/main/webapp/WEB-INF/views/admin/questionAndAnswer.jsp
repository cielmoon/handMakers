<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
   <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
   <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<jsp:include page="/WEB-INF/views/common/header.jsp">
   <jsp:param value="" name="pageTitle"/>
</jsp:include>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8"/>
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<meta name="viewport" content="user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width"/>
<title>Q & A</title>
<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>

<style>
#plusfriend-addfriend-button, #plusfriend-chat-button {
	text-align: center;
}

.panel-title {
	color: black;
}
</style>

</head>
<body>
<div class="container">
		<ul class="breadcrumb">
			<li><a href="<%=request.getContextPath()%>/index.jsp"><i class="fa fa-home"></i></a></li>
			<li><a href="<%=request.getContextPath()%>/admin/questionAndAnswer.do">Q & A</a></li>
		</ul>
		<br />
		<div class="row">
			<div class="col-sm-3"></div>
			<div class="col-sm-3">
				<div id="plusfriend-addfriend-button">
					<div class="panel-heading">
						<h3 class="panel-title">[플러스친구] 친구추가</h3>
					</div>
				</div>
			</div>
			<div class="col-sm-3">
				<div id="plusfriend-chat-button">
					<div class="panel-heading">
						<h3 class="panel-title">[플러스친구] 상담하기</h3>
					</div>
				</div>
			</div>
			<div class="col-sm-3"></div>
		</div>
</div>

<script type='text/javascript'>
  //<![CDATA[
    // 사용할 앱의 JavaScript 키를 설정해 주세요.
    Kakao.init('2a40c35769407dab0853c995ef536c20');
    /* Kakao.init('bc707634ff27da5e93d59fea2e3ec55a'); */
    // 플러스친구 친구추가 버튼을 생성합니다.
    Kakao.PlusFriend.createAddFriendButton({
      container: '#plusfriend-addfriend-button',
      plusFriendId: '_xmrDxcj' // 플러스친구 홈 URL에 명시된 id로 설정합니다.
    });
  //]]>
  
  //<![CDATA[
    // 사용할 앱의 JavaScript 키를 설정해 주세요.
    // 플러스친구 1:1채팅 버튼을 생성합니다.
    Kakao.PlusFriend.createChatButton({
      container: '#plusfriend-chat-button',
      plusFriendId: '_xmrDxcj' // 플러스친구 홈 URL에 명시된 id로 설정합니다.
    });
  //]]>
</script>
</body>
</html>


<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>