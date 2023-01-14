<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<form name="loginForm" method="post">
	<!-- container -->
	<div class="lfcontainer" style="padding-top: 0px;">
        <div class="contents">
            <h2 class="loginH2Title">LOG IN</h2>
			<div class="loginForm">
				<input type="text" name="j_username" class="loginFormInput" maxlength="50" placeholder="아이디" value="taehee33">
				<input type="password" name="j_password" class="loginFormInput" maxlength="20" placeholder="비밀번호" value="aaa12345!">
				<div class="loginFormEtcBox">
					<p class="save_id"><input type="checkbox" id="saveId" name="saveId" class="ip_chekbox" checked="checked"><label for="saveId">아이디 저장하기</label></p>
					<ul>
						<li><a href="/newbalance/customer/findId.action">아이디/비밀번호 찾기</a></li>
					</ul>
				</div>
				<div class="btnGrp">
					<a href="javascript:;" id="btnLogin" class=loginBtn>로그인</a>
					<a href="javascript:;" id="btnKakaoLogin" class="kkoBtn">카카오 로그인</a>
					<a href="javascript:;" id="btnNaverLogin" class="nvrBtn">네이버 로그인</a>		
					<a href="javascript:;" id="appleid-signin" class="appleBtn">Apple 로그인</a><!--20220811 추가-->			
				</div>
				
				<!-- 20201130 추가 :: S -->
				<div class="nonMembers_txt"><a href="/noncustomer/findNonCustomerOrder.action">비회원 주문조회</a></div>
				<!-- 20201130 추가 :: E -->			
			</div>

			<div class="login_benefit">
				<img src="https://image.nbkorea.com/NBRB_PC/common/logo_NB.png" alt="NB">
				<p class="txt1">온라인 스토어 회원만의 특별한 혜택</p>
				<p class="txt2" style="line-height:20px;">5,000원 온라인 쿠폰지급 + 기념일 축하 1만원 할인 쿠폰 지급 +<br>6%마일리지 적립 + 온오프 마일리지 통합</p>
				<div class="btnGrpCenter">
					<a href="/newbalance/customer/join.action" class="btnTyRface">회원가입</a>
				</div>
			</div>
			
		</div>
	</div>
	</form>

<script>
	$(function(){
		var loginProcess=false;
		
		$("#saveId").click(function() {
			if($("#saveId").is(":checked")) 
			{
				window.alert("개인정보 보호를 위해 아이디 저장하기는 개인PC에서만 사용해 주세요.");
			}
		});
		
		$("#btnLogin").click(function() {
			var webID = $("input[name='j_username']");
			var webPW = $("input[name='j_password']");

			
			if(loginProcess == true)
			{
				window.alert("이미 처리 중입니다.");
				return;
			}
			
			if(webID.val().trim() == "") 
			{
				window.alert("아이디를 입력해 주세요.");
				webID.focus();
				return;
			}
			
			if(webPW.val().trim() == "")
			{
				window.alert("비밀번호를 입력해 주세요.");
				webPW.focus();
				return;
			}
			
			
			loginProcess = true;
			$("form[name='loginForm']").attr("action", "/newbalance/j_spring_security_check").submit(); 
		});
		
		if("${param.error}" == "fail"){
			alert("아이디 또는 비밀번호를 다시 확인하세요. 뉴발란스 온라인 스토어에 등록되지 않은 아이디이거나, 아이디 또는 비밀번호를 잘못 입력하셨습니다.");
		}
	});
</script>