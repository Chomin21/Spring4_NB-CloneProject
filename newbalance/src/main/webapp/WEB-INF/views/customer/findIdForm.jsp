<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	<div class="findIdContainer" style="padding-top: 0px;">
		<div class="contents">
			<h2 class="h2Title">FIND ID/PW</h2>
			<div class="findSubContainer">
				<div class="h3Title">
					<h3 class="findMiniTitle">아이디/비밀번호 찾기 재설정</h3>
				</div>
				<div class="findIdFormArea">
					<fieldset>
						<legend>회원 정보 아이디 찾기 입력양식</legend>

						<div class="topBox">
							<p class="topTxt">
								카카오 로그인을 연동하시면 아이디, 비밀번호 찾을 필요 없이<br>뉴발란스를 이용하실 수 있습니다.
							</p>

							<a href="javascript:;" id="btnKakaoLogin" class="enrollKakaoBtn">카카오
								계정으로 신규가입</a>
						</div>
						<!-- 20201120 추가:: E-->

						<div class="roww">
							<label for="custName" class="findFormName">이름</label>
							<div class="findFormNameDiv">
								<input type="text" id="custName" name="custName"
									class="ip_text md">
							</div>
						</div>
						<div class="roww" id="phoneFind">
							<label for="cellNo01" class="findFormName">휴대폰번호</label>
							<div class="findFormNameDiv">
								<span class="selBox"> <select id="cellNo01"
									name="cellNo01" title="휴대폰 앞 번호">
										<option value="">선택</option>
										<option value="010">010</option>
										<option value="011">011</option>
										<option value="016">016</option>
										<option value="017">017</option>
										<option value="019">019</option>
								</select>
								</span> <input type="text" id="cellNo02" name="cellNo02" value=""
									class="midNum" title="휴대전화 가운데 번호" maxlength="4"> 
									<input type="text" id="cellNo03" name="cellNo03" value="" class="endNum" title="휴대전화 마지막 번호" maxlength="4"> 
									<input type="hidden" name="authCode" /> 
									<input type="hidden" name="cellNo" /> 
									<a href="javascript:;" class="btnAuthNumberRequest" id="btnAuthNumberRequest">인증번호 요청</a> 
									<a href="javascript:;" class="btnAuthNumberRequest" id="btnAuthNumberRequestAgain">인증번호 재요청</a>
								<!-- 인증번호 요청 후 -->
							</div>
							<!-- 인증번호 요청 후 -->
							<div class="roww con_find" id="smsCertInputArea">
								<label for="smsCertNumber" class="findFormName">인증번호 입력</label>
								<div class="findFormNameDiv">
									<div class="auth_timer">
										<input type="text" id="smsCertNumber" name="smsCertNumber"
											value="" class="smsNumberInput">
										<div class="remainNum" id="remainingSecond">03:00</div>
									</div>
									<a href="javascript:;" class="confirmBtn"
										id="btnAuthNumberConfirm">인증번호 확인</a>
								</div>
								<div class="findFormNameDiv">
									<p class="authNumInfo">
										<span id="smsMessage" class="point_r"></span><br> 3분 이내에
										인증번호 6자리를 입력하셔야 합니다. 입력하신 휴대폰번호로 전송된 인증번호를 입력해주세요.<br>
										인증번호가 오지 않을 경우 재요청을 선택해주세요.<br>
									</p>
								</div>
							</div>
							<!-- // 인증번호 요청 후 -->
							<div class="findFormNameDiv">
								<span class="fval" id="txtCellno"></span><span class="point_r"
									id="txtCellConfirm"></span>
							</div>
						</div>
					</fieldset>
				</div>
				<p class="bottomNote">* 회원가입 시 사용하신 휴대폰 번호를 통해 아이디/비밀번호를 찾으실 수
					있습니다.</p>
			</div>
		</div>
		<div class="dimmPopBack" id="layerPopupDimmed01"></div>
		<div class="findIDPopUp" id="findMemberIdNo">
			<div class="findIDPopUpInner">
				<h2 class="findIDPopTitle">뉴발란스 회원 안내</h2>
				<div class="topContent">
					<h3>뉴발란스 온라인 스토어에 가입하지 않은 정보입니다.</h3>
					<ul class="desc">
						<li>입력하신 정보를 다시 한번 확인해주세요.</li>
						<li>회원정보가 기억나지 않을 경우 고객상담실로 문의 바랍니다.</li>
					</ul>
					<p class="desc">
						Online Store Call Center 1566-0086<br>(평일 09:00 ~ 18:00 /
						토,일, 공유일 휴무)
					</p>
					<div class="findid_btnArea">
						<a href="javascript:;" id="btnLayerPopupOk01"
							class="findid_confirmBtn">확인</a>
					</div>
				</div>
				<button type="button" class="close" id="btnLayerPopupClose01">
					<img
						src="https://image.nbkorea.com/NBRB_PC/common/btn_pop_close.png"
						alt="팝업 닫기">
				</button>
			</div>
			<div class="specialDownContent">
				<h3>
					뉴발란스 온라인 스토어 회원만의<br> 특별한 혜택
				</h3>
				<p>5,000원 할인 쿠폰 지급 + 온오프 마일리지 통합</p>
				<h4>
					<img src="https://image.nbkorea.com/NBRB_PC/common/logo_NB.png"
						alt="NB">
				</h4>
				<a href="/newbalance/customer/joinn.action" class="findIdPopUpjoinBtn">회원가입</a>
			</div>
		</div>
		<div class="dimmPopBack" id="layerPopupDimmed02" ></div>
		<div class="findIDPopUp" id="findMemberIdYes" >
		    <div class="findIDPopUpInner">
		        <h2 class="findIDPopTitle">뉴발란스 회원 안내</h2>
		        <div class="content_type">
		        	<p class="findid_title"><span id="findMemberName"></span>님 가입하신 아이디입니다.</p>
					<p class="findid_txt" id="findWebID"></p>
		            <p class="findid_desc">
						비밀번호가 생각나지 않으실 경우<br>
						임시비밀번호를 통해 재설정 하실 수 있습니다.
		            </p>
					<div class="findid_btnArea">
						<a href="javascript:;" class="imsiBtn" id="btnImsiPw">임시비밀번호 발급</a>
						<a href="/newbalance/customer/login.action" class="findid_confirmBtn" id="btnFindIdOk">확인</a>
					</div>
		        </div>
		        <button type="button" id="btnLayerPopupClose02"><img src="https://image.nbkorea.com/NBRB_PC/common/btn_pop_close.png" alt="팝업 닫기"></button>
		    </div>
		</div>
		<div class="dimmPopBack" id="layerPopupDimmed04" ></div>
		<div class="findIDPopUp" id="findMemberPwYes" style="position: absolute; top: 490.5px; left: 38px;">
		    <div class="findIDPopUpInner">
		        <h2 class="findIDPopTitle">뉴발란스 회원 안내</h2>
		        <div class="content_type">
		            <h3>인증 받으신 휴대폰 번호로 비밀번호가 발송되었습니다.</h3>
		            <p class="findid_desc2">휴대폰 번호로 발송된 비밀번호를 확인하신 후 로그인해주세요.</p>
					<div class="findid_btnArea">
						<a href="/newbalance/customer/login.action" class="findid_confirmBtn" id="btnFindIdOk">확인</a>
					</div>
		        </div>
		        <button type="button" class="close" id="btnLayerPopupClose04"><img src="https://image.nbkorea.com/NBRB_PC/common/btn_pop_close.png" alt="팝업 닫기"></button>
		    </div>
		</div>
	</div>
	<script>
		function LPad(digit, size, attatch) {
			var add = "";
			digit = digit.toString();

			if (digit.length < size) {
				var len = size - digit.length;
				for (i = 0; i < len; i++) {
					add += attatch;
				}
			}
			return add + digit;
		}
		
		function countDown() {
			var minute = LPad(Math.floor(remainingSecond / 60), 2, "0");
			var second = LPad(remainingSecond % 60, 2, "0");

			$("div#remainingSecond").text(minute + ":" + second);

			remainingSecond--;

			if (intervalObject == null) {
				intervalObject = window.setInterval("countDown()", 1000);
			}

			if (remainingSecond < 0) {
				window.clearInterval(intervalObject);
				intervalObject = null;
				window.alert("인증번호 입력 시간이 초과했습니다.");
			}
		}
	</script>
<script>
	var ajaxProcessing = false;

	var remainingSecond = 180;
	var intervalObject = null;

	var smsRequestAgain = false;

$(function() {
	//인증번호 요청 버튼 클릭
	$("#btnAuthNumberRequest")
			.click(
					function() {

						var custName = $("input[name='custName']");
						var cellNo01 = $("select[name='cellNo01']");
						var cellNo02 = $("input[name='cellNo02']");
						var cellNo03 = $("input[name='cellNo03']");
						var cellNo = "";

						if (ajaxProcessing == true) {
							window.alert("이미 처리 중입니다.");
							return;
						}

						if (custName.val().trim() == "") {
							window.alert("이름을 입력해주세요.");
							custName.focus();
							return;
						}
						if (cellNo01.val().trim() == "") {
							window.alert("휴대폰 번호를 입력해주세요.");
							cellNo01.focus();
							return;
						}
						if (cellNo02.val().trim() == "") {
							window.alert("휴대폰 번호를 입력해주세요.");
							cellNo02.focus();
							return;
						}
						if (cellNo03.val().trim() == "") {
							window.alert("휴대폰 번호를 입력해주세요.");
							cellNo03.focus();
							return;
						}

						cellNo = cellNo01.val() + cellNo02.val()
								+ cellNo03.val();
						$("input[name='cellNo']").val(cellNo01.val()+"-"+cellNo02.val()+"-"+cellNo03.val());

						//인증번호 요청을 날리면
						$
								.ajax({
									url : "/newbalance/sms/registSendAuthNo.ajx",
									type : "POST",
									async : false,
									data : {
										"receiveNumber" : cellNo
									},
									dataType : 'json',
									contentType : 'application/json',
									success : function(data) {
										console.log("Data : ", data);
										if (data.result == "00") {
											countDown();
											$("input[name='authCode']")
													.val(data.authCode);
											$("#btnAuthNumberRequest").hide();
											$("#btnAuthNumberRequestAgain").show();
											$("div#smsCertInputArea").show();
											$("input[name='smsCertNumber']").focus();
											smsRequestAgain = true;
										} else {
											window
													.alert("인증번호를 발송하는데 실패하였습니다. 다시 시도해주시기 바랍니다.");
										}

										ajaxProcessing = false;

									},
									beforeSend : function() {
										ajaxProcessing = true;
									},
									error : function(request, status,
											error) {
										console.log("error : ", error);
										ajaxProcessing = false;
										window
												.alert("인증번호를 발송하는데 실패하였습니다. 다시 시도해주시기 바랍니다.");
									}
								});
					});

		$("#btnAuthNumberRequestAgain").click(function() {
			window.clearInterval(intervalObject);
			intervalObject = null;
			remainingSecond = 180;
			smsRequestAgain = false;

			$("#btnAuthNumberRequest").click();
			if (smsRequestAgain == true) {
				window.alert("인증번호를 재요청하였습니다.");
			}
		});

	$("#btnAuthNumberConfirm")
	.click(
			function() {
	
				var sendAuthCode = $("input[name='authCode']")
						.val().trim();
				var inputAuthCode = $(
						"input[name='smsCertNumber']").val()
						.trim();
	
				if (inputAuthCode == "") {
					window.alert("인증번호를 입력해주세요.");
					return false;
				}
	
				if (sendAuthCode == "") {
					window
							.alert("인증번호를 발송하는데 실패하였습니다. 다시 시도해주시기 바랍니다.");
					return false;
				}
	
				if (remainingSecond <= 0) {
					window
							.alert("인증번호 입력 시간이 초과했습니다. 인증번호 재전송 후 이용해주세요.");
					return;
				}
	
				//인증번호가 일치하는지 확인
				$.ajax({
					url : "/newbalance/sms/checkSmsAuthCode.ajx",
					type : "POST",
					async : false,
					data : JSON.stringify ({
						"sendAuthCode" : sendAuthCode,
						"inputAuthCode" : inputAuthCode
					}),
					dataType : 'json',
					contentType : 'application/json',
					success : function(data) {
						if (data.result == "00") {
							//타이머 다시 세팅
							window
									.clearInterval(intervalObject);
							intervalObject = null;
							remainingSecond = 180;
							getFindMemberIdHp();
						} else {
							window
									.alert("인증번호가 일치하지 않습니다.다시 한번 확인 후 입력해주세요.");
						}
	
						ajaxProcessing = false;
	
					},
					beforeSend : function() {
						ajaxProcessing = true;
					},
					error : function(request, status,
							error) {
						ajaxProcessing = false;
						window
								.alert("인증번호 확인을 실패하였습니다. 새로고침 후 다시 시도해주시기 바랍니다.");
					}
				});
		});
	
	$("#btnImsiPw").click(function(){
		$.ajax({
			url: "/newbalance/customer/getImsiPwd.ajx",
			type: "POST",
			async: false,
			data: JSON.stringify({ 
				"custId": $("#findWebID").text()
				,"cellNo": $("input[name='cellNo']").val()
			}),
			contentType : 'application/json',
			dataType: 'json',
			success: function (data) {
				if(data.result == "00") {
					$("#layerPopupDimmed02").hide();
					$("#findMemberIdYes").hide();
					
					$("#layerPopupDimmed04").show();
					$("#findMemberPwYes").show();
					layerCenter($("#findMemberPwYes"));
				}else{
					window.alert("임시 비밀번호 발급을 실패하였습니다. 다시 시도해주시기 바랍니다.");
				}
			}, error: function(request, status, error){
				window.alert("임시 비밀번호 발급을 실패하였습니다. 다시 시도해주시기 바랍니다.");
			}
		});	 
	});
});


//인증번호가 일치할 경우 회원 정보 가져오기
function getFindMemberIdHp() {
	$.ajax({
		url: "/newbalance/customer/getFindMemberIdHp.ajx",
		type: "POST",
		async: false,
		data: JSON.stringify({ 
			"custName": $("input[name='custName']").val()
			,"cellNo": $("input[name='cellNo']").val()
		}),
		dataType: 'json',
		contentType : 'application/json',
		success: function (data) {
			if(data.result == "99") {
				$("#layerPopupDimmed01").show();
				$("#findMemberIdNo").show();
				layerCenter($("#findMemberIdNo"));
			}else if(data.result == "00") {
				$("#findWebID").html(data.custId);
				$("#findMemberName").html($("#custName").val());
				$("#layerPopupDimmed02").show();
				$("#findMemberIdYes").show();
				layerCenter($("#findMemberIdYes"));
			}else{
				window.alert("아이디 찾기에 실패하였습니다. 다시 시도해주시기 바랍니다.");
			}
			
		}, error: function(request, status, error){
			window.alert("아이디 찾기에 실패하였습니다. 다시 시도해주시기 바랍니다.");
		}
	});	 
}
	
	$("#btnCloseFindIdPopUp").click(function(){
		$("#layerPopupDimmed02").hide();
		$("#findMemberIdYes").hide();
		$("#btnAuthNumberRequest").show();
		$("#btnAuthNumberRequestAgain").hide();
		$("div#smsCertInputArea").hide();
		$("input[name='smsCertNumber']").val("");
	});		
	
	$("#btnLayerPopupClose02").click(function(){
		$("#layerPopupDimmed02").hide();
		$("#findMemberIdYes").hide();
		$("#btnAuthNumberRequest").show();
		$("#btnAuthNumberRequestAgain").hide();
		$("div#smsCertInputArea").hide();
		$("input[name='smsCertNumber']").val("");
	});	
	
	$("#btnLayerPopupClose03").click(function(){
		$("#layerPopupDimmed03").hide();
		$("#findMemberIdEmailYes").hide();
	});
	$("#btnLayerPopupClose04").click(function(){
		$("#layerPopupDimmed04").hide();
		$("#findMemberPwYes").hide();
	});
	
	$("#btnLayerPopupOk01").click(function(){
		$("#layerPopupDimmed01").hide();
		$("#findMemberIdNo").hide();
	})
	
	function layerCenter(val){
		val.css("position","absolute");
		val.css("top", Math.max(0, (($(window).height() - $(val).outerHeight()) / 2) + $(window).scrollTop()) + "px");
		val.css("left", Math.max(0, (($(window).width() - $(val).outerWidth()) / 2) + $(window).scrollLeft()) + "px");

		return val;
	}


	
</script>
