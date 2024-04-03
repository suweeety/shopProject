<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<html lang="kr">
<!DOCTYPE html>

<head>
<meta charset="UTF-8">
<meta name="description">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<sec:csrfMetaTags />

<style>
.container {
	max-width: 1200px;
}

.quick_area {
    position: fixed;
    top: 171px;
    right: 0;
    width: 66px;
    z-index: 100;
}

.to_top a {
    display: block;
    height: 62px;
    transform: translateY(8px);
    box-sizing: border-box;
    text-indent: -9999px;
    overflow: hidden;
    /* border-left: 1px solid #a3a3a3; */
    /* border-bottom: 1px solid #a3a3a3; */
    background: url(/resources/icon/top.png) no-repeat center;
    background-size: cover;
    /* background-size: contain; */
}
</style>

<!-- Cairo Font -->
<link
	href="https://fonts.googleapis.com/css2?family=Cairo:wght@200;300;400;600;900&display=swap"
	rel="stylesheet">

<!-- 제이쿼리 -->
<script src="https://code.jquery.com/jquery-3.7.1.js"
	integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4="
	crossorigin="anonymous"></script>

<!-- 부트스트랩 -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
	crossorigin="anonymous"></script>

<!-- 폰트 어썸 -->
<script src="https://kit.fontawesome.com/c96d31bca3.js"
	crossorigin="anonymous"></script>

<!-- Css Styles -->
<link rel="stylesheet" href="/resources/css/bootstrap.min.css"
	type="text/css">
<link rel="stylesheet" href="/resources/css/font-awesome.min.css"
	type="text/css">
<link rel="stylesheet" href="/resources/css/elegant-icons.css"
	type="text/css">
<link rel="stylesheet" href="/resources/css/nice-select.css"
	type="text/css">
<link rel="stylesheet" href="/resources/css/jquery-ui.min.css"
	type="text/css">
<link rel="stylesheet" href="/resources/css/owl.carousel.min.css"
	type="text/css">
<link rel="stylesheet" href="/resources/css/slicknav.min.css"
	type="text/css">
<link rel="stylesheet" href="/resources/css/style.css" type="text/css">

</head>

<body>
	<!-- Page Preloder -->
	<div id="preloder">
		<div class="loader"></div>
	</div>

	<!-- Header Section Begin -->
	<header class="header">

		<div class="header__top">
			<div class="container" style="width: 1600px; text-align: center;">
				<a class="mailAddress"><i class="fa fa-envelope"
					style="font-size: 0.8rem;"></i>ponkuu@naver.com</a>

				<sec:authorize access="hasRole('ROLE_ADMIN')">
					<script>
						// mailAddress 클래스를 가진 요소를 제거하는 스크립트
						document.addEventListener("DOMContentLoaded",
								function() {
									var mailAddress = document
											.querySelector(".mailAddress");
									if (mailAddress) {
										mailAddress.remove();
									}
								});
					</script>
					<a href="/goods/admin">관리자 모드</a>
				</sec:authorize>
			</div>
		</div>
		<!-- header__top -->

		<div class="container">
			<div class="row" style="text-align: center;">
				<div class="col-lg-2" style="text-align: right;">
					<div class="header__logo">
						<a href="/" style="color: black; font-size: 50px;">PONKU</a>
					</div>
				</div>
				<div class="col-lg-8" style="line-height: 75px;">
					<nav class="header__menu" style="text-align: center;">
						<ul>
							<li class="active"><a href="/goods/list">모든상품</a></li>
							<li><a href="/custompage">커스텀 케이스</a></li>
							<li><a href="./blog.html">이벤트</a></li>
							<li><a href="/ask/main">문의게시판</a></li>

							<sec:authorize access="isAuthenticated()">

								<li><a href="/myPage" name="myPage">마이페이지</a>
									<ul class="header__menu__dropdown">
										<li><a href="/myPage">나의 정보관리</a></li>
										<li><a href="/myOrder">나의 주문관리</a></li>
										<!-- 아직 미구현 -->
										<li><a href="/myPlace">나의 활동관리</a></li>
										<!-- 아직 미구현 -->
									</ul></li>
							</sec:authorize>

							<sec:authorize access="isAnonymous()">
								<li><a href="#" name="noMember">마이페이지</a></li>
							</sec:authorize>

						</ul>
					</nav>
				</div>
				<!-- col-lg-8 -->

				<div class="col-lg-2" style="line-height: 75px;">
					<div class="header__top__right__auth" style="width: 100%;">

						<sec:authentication property="principal" var="pinfo" />

						<sec:authorize access="isAnonymous()">
							<a
								style="display: block; padding-top: 2px; font-family:; padding-left: 30px;"
								href="/customLogin"><i class="fa fa-user"></i>로그인</a>
						</sec:authorize>

						<sec:authorize access='isAuthenticated()'>
							<input type="hidden" value="${pinfo.member.member_seq }"
								name="memberSeq">
							<div class="hero__cart" style="display: inline-block;">
								<ul>
									<li>
										<form action="/logout" method="post" name="logoutForm"
											style="display: inline-block;">
											<a href="#" name="logoutBtn"
												style="display: inline-block; padding-top: 12px;"> <i
												class="fa fa-user"></i>
											</a> <input type="hidden" name="${_csrf.parameterName}"
												value="${_csrf.token}" />
										</form>
									</li>

									<li><a href="#" name="insta_btn"><i
											class="fa-brands fa-instagram"></i></a></li>

									<li><a href="#"><i class="fa fa-heart"></i></a></li>

									<li><a
										href="/shoppingcart?member=${pinfo.member.member_seq }"><i
											class="fa fa-shopping-bag"></i><span id="cart-elements">
										</span></a></li>

								</ul>

								<script type="text/javascript">
									// 로그인시 쇼핑카트에 몇개가 담겼는지 정보 받아옴

									var memberSeq = $("input[name='memberSeq']")
											.val()
											+ "";

									console.log(memberSeq);

									$
											.ajax({
												url : '/showCartElements',
												type : 'GET',
												data : {
													member : memberSeq
												},
												contentType : 'application/x-www-form-urlencoded; charset=utf-8',
												dataType : 'text',
												success : function(result) {

													$("#cart-elements").text(
															result + "");
												}
											});
								</script>

							</div>
						</sec:authorize>

					</div>
					<!-- header__top__right__auth -->
				</div>
				<!-- col-lg-2 -->

			</div>
			<!-- row -->
		</div>
		<!-- container -->

		<script>
			$(document).ready(function() {

				$("a[name='logoutBtn']").on("click", function(e) {
					e.preventDefault();
					var formObj = $("form[name='logoutForm']");
					formObj.submit();
					alert("로그아웃이 완료되었습니다. 이용해주셔서 감사합니다.");
				});

				$("a[name='noMember']").on("click", function(e) {
					e.preventDefault();
					alert("로그인 후 이용 가능합니다!!");
					location.href="/customLogin";
				});

				$("a[name='likes']").on("click", function(e) {
					e.preventDefault();
					alert("준비중입니다.");
				});

				$("a[name='insta_btn']").on("click", function(e) {

					e.preventDefault();

					window.open("https:////www.instagram.com/ponku.53");
				});
			});
		</script>

	</header>
	<!-- Header Section End -->