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
			<li><a href="index.html"><i class="fa fa-home"></i></a></li>
			<li><a href="#">장바구니</a></li>
		</ul>
		<div class="row">
			<div class="col-sm-1" id="content"></div>
			<div class="col-sm-10" id="content">
				<h1>Shopping Cart &nbsp;(10.00kg)</h1>
				<form enctype="multipart/form-data" method="post" action="#">
					<div class="table-responsive">
						<table class="table table-bordered">
							<thead>
								<tr>
									<td class="text-center">Image</td>
									<td class="text-left">Product Name</td>
									<td class="text-left">Model</td>
									<td class="text-left">Quantity</td>
									<td class="text-right">Unit Price</td>
									<td class="text-right">Total</td>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td class="text-center"><a href="product.html"><img
											class="img-thumbnail"
											title="women's New Wine is an alcoholic"
											alt="women's New Wine is an alcoholic"
											src="${path }/resource/image/product/2product50x59.jpg"></a></td>
									<td class="text-left"><a href="product.html">women's
											New Wine is an alcoholic</a></td>
									<td class="text-left">product 11</td>
									<td class="text-left"><div style="max-width: 200px;"
											class="input-group btn-block">
											<input type="text" class="form-control quantity" size="1"
												value="1" name="quantity"> <span
												class="input-group-btn">
												<button class="btn btn-primary" title=""
													data-toggle="tooltip" type="submit"
													data-original-title="Update">
													<i class="fa fa-refresh"></i>
												</button>
												<button class="btn btn-danger" title=""
													data-toggle="tooltip" type="button"
													data-original-title="Remove">
													<i class="fa fa-times-circle"></i>
												</button>
											</span>
										</div></td>
									<td class="text-right">$254.00</td>
									<td class="text-right">$254.00</td>
								</tr>
							</tbody>
						</table>
					</div>
				</form>
				<h2>What would you like to do next?</h2>
				<p>Choose if you have a discount code or reward points you want
					to use or would like to estimate your delivery cost.</p>
				<div id="accordion" class="panel-group">
					<div class="panel panel-default">
						<div class="panel-heading">
							<h4 class="panel-title">
								<a data-parent="#accordion" data-toggle="collapse"
									class="accordion-toggle" href="#collapse-coupon">Use Coupon
									Code <i class="fa fa-caret-down"></i>
								</a>
							</h4>
						</div>
						<div class="panel-collapse collapse" id="collapse-coupon">
							<div class="panel-body">
								<label for="input-coupon" class="col-sm-3 control-label">Enter
									your coupon here</label>
								<div class="input-group">
									<input type="text" class="form-control" id="input-coupon"
										placeholder="Enter your coupon here" value="" name="coupon">
									<span class="input-group-btn"> <input type="button"
										class="btn btn-primary" data-loading-text="Loading..."
										id="button-coupon" value="Apply Coupon">
									</span>
								</div>
							</div>
						</div>
					</div>
					<div class="panel panel-default">
						<div class="panel-heading">
							<h4 class="panel-title">
								<a class="accordion-toggle" data-parent="#accordion"
									data-toggle="collapse" href="#collapse-voucher">Use Gift
									Voucher <i class="fa fa-caret-down"></i>
								</a>
							</h4>
						</div>
						<div class="panel-collapse collapse" id="collapse-voucher">
							<div class="panel-body">
								<label for="input-voucher" class="col-sm-3 control-label">Enter
									your gift voucher code here</label>
								<div class="input-group">
									<input type="text" class="form-control" id="input-voucher"
										placeholder="Enter your gift voucher code here" value=""
										name="voucher"> <span class="input-group-btn">
										<input type="submit" class="btn btn-primary"
										data-loading-text="Loading..." id="button-voucher"
										value="Apply Voucher">
									</span>
								</div>
							</div>
						</div>
					</div>
					<div class="panel panel-default">
						<div class="panel-heading">
							<h4 class="panel-title">
								<a data-parent="#accordion" data-toggle="collapse"
									class="accordion-toggle" href="#collapse-shipping">Estimate
									Shipping &amp; Taxes <i class="fa fa-caret-down"></i>
								</a>
							</h4>
						</div>
						<div class="panel-collapse collapse" id="collapse-shipping">
							<div class="panel-body">
								<p>Enter your destination to get a shipping estimate.</p>
								<form class="form-horizontal">
									<div class="form-group required">
										<label for="input-country" class="col-sm-2 control-label">Country</label>
										<div class="col-sm-10">					
										</div>
									</div>
									<div class="form-group required">
										<label for="input-zone" class="col-sm-2 control-label">Region
											/ State</label>
										<div class="col-sm-10">
							
										</div>
									</div>
									<div class="form-group required">
										<label for="input-postcode" class="col-sm-2 control-label">Post
											Code</label>
										<div class="col-sm-10">
											<input type="text" class="form-control" id="input-postcode"
												placeholder="Post Code" value="" name="postcode">
										</div>
									</div>
									<input type="button" class="btn btn-primary"
										data-loading-text="Loading..." id="button-quote"
										value="Get Quotes">
								</form>
							</div>
						</div>
					</div>
				</div>
				<br>
				<div class="row">
					<div class="col-sm-4 col-sm-offset-8">
						<table class="table table-bordered">
							<tbody>
								<tr>
									<td class="text-right"><strong>Sub-Total:</strong></td>
									<td class="text-right">$210.00</td>
								</tr>
								<tr>
									<td class="text-right"><strong>Eco Tax (-2.00):</strong></td>
									<td class="text-right">$2.00</td>
								</tr>
								<tr>
									<td class="text-right"><strong>VAT (20%):</strong></td>
									<td class="text-right">$42.00</td>
								</tr>
								<tr>
									<td class="text-right"><strong>Total:</strong></td>
									<td class="text-right">$254.00</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
				<div class="buttons">
					<div class="pull-left">
						<a class="btn btn-default" href="index.html">Continue Shopping</a>
					</div>
					<div class="pull-right">
						<a class="btn btn-primary" href="checkout.html">Checkout</a>
					</div>
				</div>
			</div>
			<div class="col-sm-1" id="content"></div>
		</div>
	</div>
</section>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>