<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<form method="post" name="myForm">
<input type="hidden" id="deliveryCnt" name="deliveryCnt" value="${delData['deliveryCnt']}">
<input type="hidden" id="maName" name="maName" value="">
<input type="hidden" id="maPhone" name="maPhone" value="">
<input type="hidden" id="maDefault" name="maDefault" value="">
<input type="hidden" id="maZipcode" name="maZipcode" value="">
<input type="hidden" id="maAddress1" name="maAddress1" value="">
<input type="hidden" id="maAddress2" name="maAddress2" value="">
<input type="hidden" id="maSeq" name="maSeq" value="">
</form>
<div class="my_cont">
	<div class="title_area">
              <h3 class="page_tit">배송지 관리</h3>
              <ul class="page_txt_info">
              	
              			<li>자주 쓰는 배송지 주소를 저장하시면 보다 편리하게 이용이 가능합니다.</li>
                   	<li>새로운 주소로 발송 시, 최신 순으로 최대 10개까지 배송지 주소록에 자동 저장됩니다.</li>
              		
              </ul>
          </div>
	<div class="con_list_info">
		<c:choose>
             		<c:when test="${delData['delCount'] == 0}">
				<h4 class="row_title">자주 쓰는 배송지 주소를 설정해주세요.</h4>
              </c:when>
             		<c:otherwise>
             			<c:forEach var="data" items="${delData['myData']}" varStatus="status">
             				<li>
             					<dl>
                                  <dt class="name">
                                      <span>${data.maName}</span>
                                      <c:if test="${data.maDefault == 1}">
                                      	<span class="default">기본배송지</span>   
                                      </c:if>                                     
                                  </dt>
                                  <dd class="tel">${data.maPhone}</dd>
                                  <dd class="adr">${data.maZipcode}<br>${data.maAddress1}<br>${data.maAddress2}</dd>
						</dl>
              				<div class="btn_modify">
                                  <a href="javascript:void(0);" onclick="deliveryMod(${status.index});" class="btn_ty_gface1">수정</a><br>
                                  <a href="javascript:void(0);" onclick="deliveryDel(${status.index});" class="btn_ty_bline">삭제</a>
                             	</div>
                             	<input type="hidden" id="maSeq${status.index}" name="maSeq${status.index}" value="${data.maSeq}">
                             	<input type="hidden" id="maName${status.index}" name="maName${status.index}" value="${data.maName}">
						<input type="hidden" id="maPhone${status.index}" name="maPhone${status.index}" value="${data.maPhone}">
						<input type="hidden" id="maDefault${status.index}" name="maDefault${status.index}" value="${data.maDefault}">
						<input type="hidden" id="maZipcode${status.index}" name="maZipcode${status.index}" value="${data.maZipcode}">
						<input type="hidden" id="maAddress1${status.index}" name="maAddress1${status.index}" value="${data.maAddress1}">
						<input type="hidden" id="maAddress2${status.index}" name="maAddress2${status.index}" value="${data.maAddress2}">											
             				</li>
             			</c:forEach>
             		</c:otherwise>
                    
             	</c:choose> 
              <div class="btn_area">
                  <a href="javascript:;" class="btn_ty_rface lg" id="btndeliveryAdd">배송지 추가</a>
              </div>
            	</div>
</div>
	
<script>
$(function(){
	$("#btndeliveryAdd").click(function(){
		
		if(Number($("input[name='deliveryCnt']").val()) >= 10)
		{
			window.alert("배송지는 최대 10개까지 추가가 가능 합니다.");
			return;				
		}
			
		$("form[name='myForm']").attr("action", "/newbalance/my/memberDeliveryInsert.action").attr("target", "_self").submit();
	});
	
});	

function deliveryMod(idx) {
	$("input[name='maSeq']").val($("input[name='maSeq"+idx+"']").val());
	$("input[name='maName']").val($("input[name='maName"+idx+"']").val());
	$("input[name='maPhone']").val($("input[name='maPhone"+idx+"']").val());
	$("input[name='maDefault']").val($("input[name='maDefault"+idx+"']").val());
	$("input[name='maZipcode']").val($("input[name='maZipcode"+idx+"']").val());
	$("input[name='maAddress1']").val($("input[name='maAddress1"+idx+"']").val());
	$("input[name='maAddress2']").val($("input[name='maAddress2"+idx+"']").val());
	
	$("form[name='myForm']").attr("action", "/newbalance/my/memberDeliveryUpdate.action").attr("target", "_self").submit();
}



function deliveryDel(idx) {
	if(confirm("배송지를 삭제하시겠습니까?")) {
		console.log(idx);
		$("input[name='maSeq']").val($("input[name='maSeq"+idx+"']").val());
		$("form[name='myForm']").attr("action", "/newbalance/my/memberDeliveryDeleteProc.action").attr("target", "_self").submit();
	}
}
</script>
