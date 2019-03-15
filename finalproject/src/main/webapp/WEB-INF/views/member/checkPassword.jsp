<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath }" />
<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>

<section>
	<div class="container">
		<ul class="breadcrumb">
			<li><a href="path"><i class="fa fa-home"></i></a></li>
			<li><a href="#">������������</a></li>
			<li><a href="#">�������� ����</a></li>
		</ul>
		<br />
		<div class="row">
			<div class="col-sm-3 hidden-xs column-left" id="column-left">
				<div class="column-block">
					<div class="columnblock-title">������������</div>
					<div class="account-block">
						<div class="list-group">
							<a class="list-group-item" href="#">Ȩ</a> 
							<a class="list-group-item" href="#">�������� ����</a>
							<a class="list-group-item" href="#">���ι�� ����</a>
							<a class="list-group-item" href="#">ȸ�� ����</a>				
							<a class="list-group-item" href="#">�������� ����</a>												
							
						</div>
					</div>
				</div>
			</div>
			<!-- ���� ���� ���� �ٽ� ��й�ȣ Ȯ�� -->
			<div class="col-sm-9" id="content">
				<div class="row">


				</div>
			</div>
		</div>
	</div>
</section>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>