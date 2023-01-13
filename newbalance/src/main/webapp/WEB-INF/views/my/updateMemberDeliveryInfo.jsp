<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


 <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

       <!-- 콘텐트 구현 부분 start -->
<form method="POST" name="myForm">
<div class="my_cont">
	<div class="deliveryTitleArea">
       <h3 class="pageTit">배송지 수정</h3>
   </div>
	<div class="addDelivery">
               <div class="formArea">
                   <fieldset>
                       <legend>배송지 추가 입력 양식</legend>
                       <input type="hidden" name="maSeq" value="${param.maSeq}"/>
                       <div class="rrow">
                           <label for="maName" class="fftit">받으실 분 <em class="ccompulsory">필수</em></label>
                           <div class="ffdata">
                               <input type="text" id="maName" name="maName" class="ipTextLg" title="아이디" value="${param.maName}">
                           </div>
                       </div>
                       <div class="rrow">
                           <label for="cellNo01" class="fftit">휴대폰 번호 <em class="ccompulsory">필수</em></label>
                           <div class="ffdata">
                               <span class="selectBox">
                                   <select id="cellNo01" name="cellNo01" title="휴대폰 앞 번호">
                                       <option value="">선택</option>
                                       <option value="010">010</option>
                                       <option value="011">011</option>
                                       <option value="016">016</option>
                                       <option value="017">017</option>
                                       <option value="019">019</option>
                                   </select>
                               </span>
                         <input type="text" id="cellNo02" name="cellNo02" value="${cellNo02}" class="ipTextSm" title="휴대폰 가운데 번호" maxlength="4">
                         <input type="text" id="cellNo03" name="cellNo03" value="${cellNo03}" class="ipTextSm" title="휴대폰 마지막 번호" maxlength="4">
                         <input type="hidden" id="maPhone" name="maPhone">
                         </div>
                       </div>
               <div class="rrow">
                   <strong class="fftit">주소 <em class="ccompulsory">필수</em></strong>
                   <div class="ffdata">
                       <div class="block">
                           <a href="javascript:;" class="btnTyForm" id="postFind">우편번호 찾기</a>
                       </div>
                       <div class="block">
                       	<input type="text" class="ipTextSm" id="txtOrderZipCode" name="maZipcode" readonly title="배송지 우편번호" value="${param.maZipcode}" maxlength="6">
                        </div>
						<input type="text" class="ipTextXl" id="maAddress1" name="maAddress1" readonly title="기본 주소" value="${param.maAddress1}" maxlength="120">
						<input type="text" class="ipTextXl" id="maAddress2" name="maAddress2" title="상세 주소" value="${param.maAddress2}" maxlength="120">
                   </div>
               </div>
                       <div class="chk_right">
                       <input type="checkbox" id="maDefault" name="maDefault" class="ipChekbox" value="1"  ${param.maDefault == "1"  ? "checked" : ""}>
                         <label for="maDefault">기본 배송지로 저장</label></div>
                     </fieldset>
                 </div>
                 <div class="btnArea">
                     <a href="javascript:;" class="btnTyBfaceLg" id="btnDeliveryUpdate">변경사항 저장</a>
                     <a href="javascript:;" class="btnTyBlineLg" id="btnDeliveryDelete">삭제</a>                            
                 </div>
             </div>
  	</div>
  </form>

<script>

$(window.document).ready(function(){
	
	$("#postFind").click(function(){
		popupDaumPost($("#maZipcode"), $("#maAddress1"), $("#maAddress1"));
	});
	
	$("#cellNo01").val("${cellNo01}");
	
	$("input[name='cellNo02']").keyup(function(){
		OnlyNumberEtcRemove(this);
	});
	
	
	$("input[name='cellNo03']").keyup(function(){
		OnlyNumberEtcRemove(this);
	});
	
	$("#btnDeliveryUpdate").click(function(){
		
			if(checkValidation() == false)
		{
			return;				
		} 
		
		$("#maPhone").val($("#cellNo01").val()+"-"+$("#cellNo02").val()+"-"+$("#cellNo03").val());
		$("form[name='myForm']").attr("action", "/newbalance/my/memberDeliveryUpdateProc.action").attr("target", "_self").submit();
		
	});	
	
	$("#btnDeliveryDelete").click(function(){
		
		$("form[name='myForm']").attr("action", "/newbalance/my/memberDeliveryDeleteProc.action").attr("target", "_self").submit();
		
	});			
	
});


function checkValidation()
{
	
	if($("input[name='maName']").val() == "")
	{
		window.alert("수신자 이름을 입력해 주세요.");
		$("input[name='maName']").focus();
		return false;
	}			

	if($("select[name='cellNo01']").val() == "")
	{
		window.alert("수신자 핸드폰번호 앞자리를 선택해 주세요.");
		$("select[name='cellNo01']").focus();
		return false;
	}
	
	if($("input[name='cellNo02']").val() == "")
	{
		window.alert("수신자 핸드폰번호 가운데 자리를 입력 해주세요.");
		$("input[name='cellNo02']").focus();
		return false;
	}
	
	if($("input[name='cellNo03']").val() == "")
	{
		window.alert("수신자 핸드폰번호 마지막 자리를 입력 해주세요.");
		$("input[name='cellNo03']").focus();
		return false;
	}
	
	if($("input[name='cellNo02']").val().length < 3) {
		window.alert("수신자 핸드폰번호 가운데 자리를 입력 해주세요.");
		$("input[name='cellNo02']").focus();
		return false;				
	}
	
	if($("input[name='cellNo03']").val().length < 4) {
		window.alert("수신자 핸드폰번호 마지막 자리를 입력 해주세요.");
		$("input[name='cellNo03']").focus();
		return false;				
	}			
	
	if($("input[name='maZipcode']").val() == "")
	{
		window.alert("배송지 우편번호를 입력해 주세요.");
		$("input[name='maZipcode']").focus();
		return false;
	}
	
	if($("input[name='maAddress1']").val() == "")
	{
		window.alert("배송지 기본주소를 입력해 주세요.");
		$("input[name='maAddress1']").focus();
		return false;
	}
	
	if($("input[name='maAddress2']").val() == "")
	{
		window.alert("배송지 상세주소를 입력해 주세요.");
		$("input[name='maAddress2']").focus();
		return false;
	}			
	return true;
}		


function popupDaumPost(zipcodeObj, addr1Obj, addr2Obj) {
	var top = 0;
    var left = 0;
    var width = 500;
    var height = 520;
    var borderWidth = 5;

    left = (((window.innerWidth || document.documentElement.clientWidth) - width) / 2 - borderWidth);
    top = (((window.innerHeight || document.documentElement.clientHeight) - height) / 2 - borderWidth);

    new daum.Postcode({
        theme: { searchBgColor: "#000000", queryTextColor: "#FFFFFF" },
        oncomplete: function (data) {
            var fullAddr = data.address;
            var extraAddr = '';

            if (data.addressType === 'R') {
                if (data.bname !== '') {
                    extraAddr += data.bname;
                }
                if (data.buildingName !== '') {
                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                fullAddr += (extraAddr !== '' ? ' (' + extraAddr + ')' : '');
            }
            zipcodeObj.val(data.zonecode);
            addr1Obj.val(fullAddr);
            addr2Obj.focus();
        }
    }).open({ top: top, left: left });
}

function OnlyNumberEtcRemove(obj) {
	return $(obj).val($(obj).val().replace(/[^0-9]/gi,""));
}

</script>
