<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>

<div class="dimm_pop" id="dimmOptionPopup" style="display: none;"></div>
<div class="layer_pop w450" id="wishListPopup" style="display:none">
	<div class="pop_inner">
		<div class="square">
			<div class="interest">
				<strong class="comp_txt1"></strong>
				<p class="comp_txt2">등록하신 내역은 <em class="point_b">‘마이페이지 &gt; 상품내역 &gt; 관심상품’</em>에서<br>확인하실 수 있습니다.</p>
				<div class="btn_area">
					<a href="javascript:;" id="btnWishListPopupClose" class="btn_ty_bface sm">확인</a>
				</div>
			</div>
			<button type="button" class="close" id="btnLayerPopupClose"><img src="https://image.nbkorea.com/NBRB_PC/common/btn_pop_close.png" alt="팝업 닫기"></button>
		</div>
	</div>
</div>

<!-- 옵션 변경 모달 start -->
<div class="layer_pop w700" id="optionPopup" style="display:none;" >

<script type="text/javascript">

$(document).ready(function(){
	
	var prodCode = "";
	var colCode = "";
	var sizeCode = "" ;
	
	
	$("#btnCloseOptionPopup").click(function(){
		$("#optColor").empty();
		$("#optSize").empty();
		$("#optionPopup").hide();
		$(".dimm_pop").hide();
	});
	 
	
	$("input:radio[name=pr_color]").click(function(){
		choiceColor($(this).val());
		
		$("#newProdCode").val("");
	});
	
	
	$("input:radio[name=pr_size]").click(function(){
		choiceSize($(this));
	});
	
	
	
	$("#optionChange").click(function(){
		if(!$("#pdSizeCode").val()){
			alert("사이즈를 선택하여 주세요.");
			return false;
		}
		
		$.ajax({
			async: false,
			url: "/newbalance/customer/updateCartOption.ajx",
			type: "POST",
			data: JSON.stringify({
				"pdCode" : $("#pdCode").val()
				,"color" : $("#pdColor").val()
				, "sizeCode" : $("#pdSizeCode").val()
				, "cartNum" : $("#cartNum").val()
			}),
			dataType: 'json',
			contentType : 'application/json',
			success: function (data) {
				if(data.result == "00") {
					alert("옵션이 변경되었습니다.");
				} else if(data.result = "22"){
					alert("이미 장바구니에 존재하는 옵션입니다.");
				}else if(data.result == "99") {
					alert("수량 변경에 실패했습니다.");
				}
			},
			error:function(p) {
				alert(p.error_message);
			},
			complete : function() {
				document.location.reload();
			}		
		});
	});
	
	function qtyChange(obj) {
		if(confirm("수량을 변경 하시겠습니까?")) {
			var qty = $(obj).parents("#cartRow").find("#selectbox option:selected").val();
			var cartNum =  $(obj).parents("#cartRow").find("input[name=prodCode]").data("cartnum");

			$.ajax({
				async: false,
				url: "/newbalance/customer/updateCartQty.ajx",
				type: "POST",
				data: JSON.stringify({
					"qty" : qty
					,"cartNum" : cartNum
				}),
				dataType: 'json',
				contentType : 'application/json',
				success: function (data) {
					if(data.result == "00") {
						alert("수량이 변경되었습니다.");
					} else if(data.result == "99") {
						alert("수량 변경에 실패했습니다.");
					}
				},
				error:function(p) {
					alert(p.error_message);
				},
				complete : function() {
					document.location.reload();
				}		
			});
		}
	}
	
	
	$("#optionCancel").click(function(){
		$("#optColor").empty();
		$("#optSize").empty();
		$("#optionPopup").hide();
		$(".dimm_pop").hide();
	});
	
	choiceColor(colCode);
	
	//라디오 버튼 값으로 선택
    $("input:radio[name=pr_size][value="+ sizeCode +"]").prop("checked", true); 
});

var prod_opt;
var cSize;
function fOptionChange(pdName, cartNum, pdCode, color, size, prodImg){
	$.ajax({
        url : '/newbalance/customer/getCartOption.ajx',
        type : 'POST',   
        async : false,
        dataType : 'json',
        cache : false,
        data : JSON.stringify({"pdCode" : pdCode}),        
        contentType : 'application/json',
        success : function(data){

        	console.log(data.result);
        	prod_opt = data.result;
        	$("#optionPopImg").attr("src", prodImg);
     	 	cSize = size;
			$("#p_name").text(pdName);
			$("#cartNum").val(cartNum);
			$("#pdCode").val(pdCode);
			
        	chooseColor(color);
			
        },
        error: function(data){
            alert("에러가 발생했습니다.");
        },
        complete : function(){
        	$("#optionPopup").show();
        	$("#dimmOptionPopup").show();
        	$("#optionPopup").center();
        }
     });
	
}
	function chooseColor(color){
		$("#optColor").empty();
		$("#optSize").empty();
		
		$("#pdColor").val(color);
		for(let i = 0; i < prod_opt.length; i++){

	   		   	$("#optColor").append("<li><input type='radio' id='color_"+ i +"' name='pr_color' value='"+prod_opt[i].color+"' onclick=chooseColor('"+prod_opt[i].color+"') style='border:1px solid red;'><label for='color_"+i+"'><img src="+prod_opt[i].colorUrl+"></label></li>");
	   		   if(prod_opt[i].color == color ){
	   			  $("#color_"+i).attr("checked", true);
	   			  var dataObj = prod_opt[i].options;
				  chooseSize(dataObj);
	   		}
		}
	}
	
	function chooseSize(dataObj){
		  for(let j = 0; j < dataObj.length; j++){
			    console.log(dataObj.length);
			 	$("#optSize").append("<li><input type='radio' id='size_"+dataObj[j].size+"' name='pr_size' value='"+dataObj[j].sizeCode+ "' data-prodcode='"+dataObj[j].pdCode+"' data-qty='"+dataObj[j].maxCount +"' onclick='choiceSize(this)'><label for='size_"+dataObj[j].size+"'>"+dataObj[j].size+"</label></li>");
			 	
			 	let qtyCheck = dataObj[j].maxCount < 1;
			 	
			 	if(qtyCheck){
			 		$("#size_"+dataObj[j].size).attr("disabled", true);
			 	}
			 	if(dataObj[j].size == cSize){
			 		if(!qtyCheck) {
			 			$("#size_"+dataObj[j].size).attr("checked", true); 			
			 		}
			 	} 
	     	 	
			}
	}

function choiceSize(obj){
	$("#pdSizeCode").val($(obj).val());
}

</script>
	<form id="optionform" name="optionform" method="post">
		<input type="hidden" id="pdCode" name="pdCode">
		<input type="hidden" id="pdColor" name="pdColor">
		<input type="hidden" id="pdSizeCode" name="pdSizeCode">
		<input type="hidden" id="cartNum" name="cartNum">
	</form>
	<div class="pop_inner">
		<div class="popTitle">
			<strong>색상/사이즈 변경하기</strong>
		</div>
		<div class="contents">
			<div class="option_change">
				<div class="pr_visual"><img id="optionPopImg" ></div>
				<div class="pr_select">
					<strong class="p_name" id="p_name"></strong>
					<div class="color_chip">
						<p class="tit">색상</p>
						<ul class="items" id="optColor">
							
						</ul>
					</div>
					<div class="size">
						<p class="tit">사이즈</p>
						<ul class="items" id="optSize">
						
						</ul>
					</div>
				</div>
			</div>
			<div class="btn_area wid140">
				<a href="#none" class="btn_ty_bface sm" id="optionChange">변경하기</a>
				<a href="#none" class="btn_ty_bline sm" id="optionCancel">취소하기</a>
			</div>
		</div>
		<button type="button" class="close" id="btnCloseOptionPopup"><img src="https://image.nbkorea.com/NBRB_PC/common/btn_pop_close.png" alt="팝업 닫기"></button>
	</div>
	</div>

<!-- 옵션 변경 모달 end -->

<form id="sendform" name="sendform" method="post" novalidate="novalidate">
	<input type="hidden" id="inType" name="inType" value="cart"/>
	<!-- container -->
	<div class="cartContainer" style="padding-top: 0px;">
		<div class="cartContents">
			<!-- basket_wrap -->
			<div class="basketWrap">
				<div class="titleArea">
					<h2 class="pgTitle">장바구니</h2>
					<div class="ttStep">
						<span class="currStatus">장바구니</span>
						<span>주문/결제</span>
						<span>주문완료</span>
					</div>
				</div>
				<div class="tblCount">
					<p class="totalCount">총 <strong>${fn:length(cartData)}</strong>개</p>
				</div>
				<div class="topTbl">
					<table class="tbl_basket">
						<caption>장바구니 담긴 내역</caption>
						<colgroup>
							<col style="width:38px">
							<col style="width:auto">
							<col style="width:190px">
							<col style="width:180px">
							<col style="width:120px">
						</colgroup>
						<thead>
							<tr>
								<th scope="col" class="chkBox"><em class="chk"><input type="checkbox" id="checkbox_all" name="checkbox_all" class="ipChekbox" checked=""><label for="checkbox_all"><span class="bblind">전체선택</span></label></em></th>
								<th scope="col">상품/옵션 정보</th>
								<th scope="col">수량</th>
								<th scope="col">주문금액</th>
								<th scope="col"><span class="bblind">내역 제어</span></th>
							</tr>
						</thead>
						<tbody>
						
						<c:forEach items="${cartData}" var="data" varStatus="status">
							<tr id="cartRow" name="cartRow" class="${data.maxCount == 0 ? 'pd_soldout' : '' }">
								<td class="chkBox">
									<em class="chk">
										<input type="checkbox" id="checkbox_sharePurchaseIdx_${status.index}" name="sharePurchaseIdx" value="0" style="display: none;" checked="checked">
										<input type="checkbox" id="checkbox_prodCode_${status.index}" name="prodCode" class="ipChekbox" value="${data.pdCode}" data-pdPrice="${data.pdPrice}" data-pdName="${data.pdName}" data-qty="${data.cartCount}" data-cartnum="${data.cartNum}"  ${data.maxCount == 0 ? 'disabled' : ' checked="checked"'} data-sizecode="${data.sizeCode}">
										<label for="checkbox_prodCode_${status.index}"><span class="bblind">상품선택</span></label>
									</em>
								</td>
								<td>
									<div class="img">
										<img src="${data.pdImage}" alt="">
										<c:if test="${data.maxCount == 0}">
											<span class="soldOut">
												<em>SOLD<br>OUT</em>
											</span>
										</c:if>
									</div>
									
									<div class="pr">
												<a href="/newbalance/product/productDetail.action?pdCode=${data.pdCode}" class="p_name">${data.pdName}</a>					 
										<p class="p_opt">(${fn:substring(data.pdCode ,8,10)})${data.color}, ${data.size}</p>
										<p class="p_opt"><fmt:formatNumber type = "number"  maxFractionDigits = "10" value = "${data.pdPrice}" />원</p>										
												<a href="javascript:;" class="btnLine" onclick="fOptionChange('${data.pdName}', '${data.cartNum}', '${data.pdCode}', '${data.color}', '${data.size}', '${data.pdImage}')">변경</a>						
									</div>
								</td>
								<td>
									<div class="selectWrap">							
										<span class="selectBox ssmall" style="width:82px">
											<c:choose>
												<c:when test="${data.maxCount eq 0}">
													<select id="selectbox" name="selectbox" title="수량 선택" disabled>	
														<option value="${data.cartCount}" selected disabled>${data.cartCount}</option>
													</select>
												</c:when>
												<c:otherwise>
													<select id="selectbox" name="selectbox" title="수량 선택" >	
														<c:forEach var="cnt" begin="1" end="${data.maxCount}" step="1">
														  <option value="${cnt}" ${data.cartCount == cnt ? 'selected="selected"' : ''}>${cnt}</option>
														</c:forEach>	
													</select>
												</c:otherwise>
											</c:choose> 
										</span>
										<c:choose>
											<c:when test="${data.maxCount eq 0}">
												<a href="javascript:;" class="btnLine">변경</a>
											</c:when>
											<c:otherwise>
												<a href="javascript:;" class="btnLine" onclick="qtyChange(this);">변경</a>
											</c:otherwise>
										</c:choose>
									</div>
								</td>
								<td class="price">
									<strong id="price"><fmt:formatNumber type = "number"  maxFractionDigits = "10" value = "${data.pdPrice * data.cartCount}" /></strong>원
								</td>
								<td class="control">
									<c:choose>
										<c:when test="${data.maxCount eq 0}">
											<a href="javascript:;" class="btnTyRface xs" onclick="warehousingAlarmApply(${data.pdCode})" data-gtag-idx="fo_cartList_1" data-gtag-label="입고알림">입고알림</a>
										</c:when>
										<c:otherwise>
											<a href="javascript:;" class="btnTyRface xs" onclick="cartOrder(${data.pdCode})" data-gtag-idx="fo_cartList_1" data-gtag-label="주문하기">주문하기</a>
										</c:otherwise>
									</c:choose>
									<a href="javascript:;" class="btnTyGface xs" onclick="likeWishList('${data.pdCode}');" data-gtag-idx="fo_cartList_1" data-gtag-label="관심상품">관심상품</a>
									<a href="javascript:;" class="btnTyBline xs" onclick="deleteCart('${data.cartNum}')" data-gtag-idx="fo_cartList_1" data-gtag-label="삭제하기">삭제하기</a>
								</td>
							</tr>
						
						</c:forEach>
							
						
						</tbody>
					</table>
				</div>
				
				<div class="btmTbl">
					<div class="tbl_control">
						<span>선택상품 <strong id="choiceCount"></strong>개</span>
						<a href="javascript:;" id="wishListBtn" class="btnTyGface xs">관심상품</a>
						<a href="javascript:;" id="deleteCartBtn" class="btnTyBline xs">삭제하기</a>
					</div>
					<p class="info_txt">* 장바구니에 담긴 상품은 30일 동안 보관됩니다. 더 오래 상품을 보관하시려면 관심 상품에 담아주시기 바랍니다.</p>
				</div>

				<div class="sec_price">
					<div class="calc">
						<div class="clearfix">
							<p>
								<span class="ttl">주문금액</span>
								<span class="price"><em id="orderPrice"></em>원</span>
							</p>
						</div>
						<div class="clearfix">
							<p>
								<span class="ttl">배송료</span>
								<span class="price"><em id="dlvyPrice"></em>원</span>
							</p>
						</div>
					</div>
					<div class="total">
						<p class="txt1">결제 예정 금액</p>
						<span class="txt2">주문금액 + 배송료</span>
						<strong class="txt3"><em id="totalPrice"></em>원</strong>
					</div>
				</div>

				<div class="btnArea">
					<a href="javascript:;" class="btnTyRface lg" id="totalProductOrder" data-gtag-idx="fo_cartList_2">전체 상품 주문하기</a>
					<a href="javascript:;" class="btnTyBline lg" id="choiceProductOrder" data-gtag-idx="fo_cartList_2">선택 상품 주문하기</a>
				</div>
				
			</div>
			<!-- // basket_wrap -->

			<!-- product -->
			<div class="goods">
				<h3 class="title_goods">함께 구매하면 좋은 상품</h3>
				<ul class="goods_list01" id="customerRelatedProdList">
						<li>
							<a href="/product/productDetail.action?styleCode=NBPDCF008A&amp;colCode=35&amp;rccode=pc_cart_a3" data-gtag-idx="fo_cartList_3" data-gtag-label="ML610TBC_NBPDCF008A35Fix" class="pro_area gaTag">
								<img src="https://image.nbkorea.com/NBRB_Product/20221103/NB20221103110054085001.jpg" alt="ML610TBC" class="img_goods">
								
								<p class="trade_name">ML610TBC</p>
								<div class="price">
									<del style="display:none">119,000<span>원</span></del>
									<p>119,000<span>원</span></p>
								</div>
							</a>
						</li>
					
						<li>
							<a href="/product/productDetail.action?styleCode=NBP7CF753T&amp;colCode=35&amp;rccode=pc_cart_a3" data-gtag-idx="fo_cartList_3" data-gtag-label="CM878EC1_NBP7CF753T35Fix" class="pro_area gaTag">
								<img src="https://image.nbkorea.com/NBRB_Product/20221109/NB20221109172848971001.jpg" alt="CM878EC1" class="img_goods">
								
								<p class="trade_name">CM878EC1</p>
								<div class="price">
									<del style="display:none">129,000<span>원</span></del>
									<p>129,000<span>원</span></p>
								</div>
							</a>
						</li>
					
						<li>
							<a href="/product/productDetail.action?styleCode=NBPDDS160A&amp;colCode=35&amp;rccode=pc_cart_a3" data-gtag-idx="fo_cartList_3" data-gtag-label="MR530KOB_NBPDDS160A35Fix" class="pro_area gaTag">
								<img src="https://image.nbkorea.com/NBRB_Product/20221208/NB20221208102049117001.jpg" alt="MR530KOB" class="img_goods">
								
								<p class="trade_name">MR530KOB</p>
								<div class="price">
									<del style="display:none">109,000<span>원</span></del>
									<p>109,000<span>원</span></p>
								</div>
							</a>
						</li>
					
						<li>
							<a href="/product/productDetail.action?styleCode=NBPDDS164G&amp;colCode=15&amp;rccode=pc_cart_a3" data-gtag-idx="fo_cartList_3" data-gtag-label="MR530CB_NBPDDS164G15Fix" class="pro_area gaTag">
								<img src="https://image.nbkorea.com/NBRB_Product/20221215/NB20221215091514033001.jpg" alt="MR530CB" class="img_goods">
								
								<p class="trade_name">MR530CB</p>
								<div class="price">
									<del style="display:none">129,000<span>원</span></del>
									<p>129,000<span>원</span></p>
								</div>
							</a>
						</li>
					</ul>
					<template id="customer-related-template" style="display:none;">
						<li>
							<a href="/product/productDetail.action?styleCode=#styleCode&amp;colCode=#colCode&amp;rccode=#rccode" data-gtag-idx="fo_cartList_3" data-gtag-label="#gaRelItemFix" class="pro_area gaTag">
								<img src="#itemImage" alt="#itemName" class="img_goods">
								
								<p class="trade_name">#itemName</p>
								<div class="price">
									<del style="display:none">#originalPrice<span>원</span></del>
									<p>#salePrice<span>원</span></p>
								</div>
							</a>
						</li>
					</template>
					<template id="customer-related-templateFix" style="display:none;">
						<li>
							<a href="/product/productDetail.action?styleCode=#styleCode&amp;colCode=#colCode" data-gtag-idx="fo_cartList_3" data-gtag-label="#gaRelItemFix" class="pro_area gaTag">
							<img src="#itemImage" alt="#itemName" class="img_goods">
							
							<p class="trade_name">#itemName</p>
							<div class="price">
								<del style="display:none">#originalPrice<span>원</span></del>
								<p>#salePrice<span>원</span></p>
							</div>
							</a>
						</li>
					</template>



			<!-- //product -->

			<div class="cscenter">
				<ul class="clearfix">
					<li class="faq"><a href="/support/searchFaqList.action"><strong>FAQs</strong><span>가장 자주 묻는 질문과 답변을 찾아보세요.</span></a></li>
					<li class="inq"><a href="/my/qna/searchQuestionList.action"><strong>1:1 문의</strong><span>1:1 문의를 남겨 주시면 빠른 시간 내에 도와드리겠습니다.</span></a></li>
				</ul>
				<div class="cs_number">
					<div class="box clearfix">
						<div class="number as">
							<dl>
								<dt>뉴발란스/뉴발란스키즈 온라인스토어 고객센터</dt>
								<dd>TEL. 1566-0086</dd>
							</dl>
						</div>
						<div class="time">
							<p>운영시간</p>
							<!-- 20211207 수정 :: S -->
							<dl>
								<dt>평일</dt>
								<dd>10:00 - 17:00</dd>
							</dl>
							<dl>
								<dt>점심시간</dt>
								<dd>12:00 - 13:00</dd>
							</dl>
							<span>(토·일·공휴일 휴무)</span>
							<!-- 20211207 수정 :: E -->
						</div>
					</div>
					<div class="box clearfix">
						<div class="number">
							<dl>
								<dt>A/S 및 뉴발란스 고객센터</dt>
								<dd>080 - 999 - 0456</dd>
							</dl>
						</div>
						<div class="time">
							<p>오프라인 매장 상품, 재고 문의 및 구입한 상품 A/S 문의 </p>
							<dl>
								<dt>평일</dt>
								<dd>09:00 - 18:00</dd>
							</dl>
							<dl>
								<dt>점심시간</dt>
								<dd>12:00 - 13:00</dd>
							</dl>
							<span>(토·일·공휴일 휴무)</span>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- // container -->
	</div>
</form>

<script>

$(function() {	
	totalAmount();
	$("#checkbox_all").click(function() { 
		if($("#checkbox_all").prop("checked")) { 
			$("input[type=checkbox]:not(:disabled)").prop("checked",true);
			totalAmount();
		} else { 
			$("input[type=checkbox]").prop("checked",false);
			totalAmount();
		} 
	});

	$("input:checkbox[name=prodCode]").click(function(){
		var selectedIndex = $("input:checkbox[name=prodCode]").index(this);
		var isChecked = $(this).prop("checked");
		$("input:checkbox[name='sharePurchaseIdx']").eq(selectedIndex).prop("checked", isChecked);
		
		
		if($("input:checkbox[name=prodCode]:checked").length == 0) {
			$("input:checkbox[name='checkbox_all']").prop("checked",false); 
		}

	});
	
	
	$("input:checkbox[name=prodCode]").click(function(){
		totalAmount();
	});
	
	
	
	//상품 삭제
	$("#deleteCartBtn").click(function() {
		var delArray = new Array();		
		if($("input:checkbox[name=prodCode]:checked").length == 0){
			alert("상품을 먼저 선택해 주시기 바랍니다.");
			return false;
		}
		
		$("input:checkbox[name=prodCode]:checked").each(function() {
			delArray.push($(this).data("cartnum"));
		});

        console.log(delArray);
    
        $.ajax({
           url : '/newbalance/customer/deleteCartProduct.ajx',
           type : 'POST',   
           async : false,
           dataType : 'json',
           cache : false,
           data : JSON.stringify({
              "delList" : delArray
           }),   
           contentType : 'application/json',
           success : function(data){
              if(data.result == "00"){
            	  alert("선택한 상품을 장바구니에서 삭제했습니다.");
              } else{
            	  alert("선택한 상품을 장바구니에서 삭제하는데 실패했습니다.");
              }
           },
           error: function(data){
               alert("에러가 발생했습니다.");
           },
           complete : function() {
				document.location.reload();
			}	
        });
	});
	
	
	
	//관심상품 등록
	$("#wishListBtn").click(function() {	
		var wishArray = new Array();		
		if($("input:checkbox[name=prodCode]:checked").length == 0) {
			alert("상품을 먼저 선택해 주시기 바랍니다.");
			return false;
		}
			
		$("input:checkbox[name=prodCode]:checked").each(function() {
			wishArray.push($(this).val());
		});

        console.log(wishArray);
    
        $.ajax({
           url : '/newbalance/product/wishList.ajx',
           type : 'POST',   
           async : false,
           dataType : 'json',
           cache : false,
           data : JSON.stringify({
              "pdCode" : wishArray
           }),
           contentType : 'application/json',
           success : function(data){
              if(data.result == "00"){
            	  $(".comp_txt1").html("관심 상품으로 등록되었습니다.");						
					$("#wishListPopup").show();
					$("#wishListPopup").center();
			   		$(".dimm_pop").show();
              } else{
            	  $(".comp_txt1").html("이미 관심상품으로 등록된 상품입니다.");		        		
					$("#wishListPopup").show();
					$("#wishListPopup").center();
					$(".dimm_pop").show();
              }
           },
           error: function(data){
               alert("에러가 발생했습니다.");
           }
        });

	});
	
});

$("#totalProductOrder").click(function(){
	let totalArray = new Array();
	let obj = null;
	$("tr[name=cartRow]").not(".pd_soldout").each(function(i, e){
		obj = new Object();
		obj.pdCode = $(this).find("input[name=prodCode]").val();
		obj.pdPrice = $(this).find("input[name=prodCode]").data("pdprice");
		obj.pdName = $(this).find("input[name=prodCode]").data("pdname");
		obj.qty = $(this).find("input[name=prodCode]").data("qty");
		obj.cartNum = $(this).find("input[name=prodCode]").data("cartnum");
		obj.imgUrl = $(this).find("img").attr("src");
		obj.opt = $(this).find(".p_opt:nth-child(2)").text();
		obj.sizeCode = $(this).find("input[name=prodCode]").data("sizecode");
		totalArray.push(obj);

	});
	console.log(totalArray);
	
	 $.ajax({
         url : '/newbalance/payment/order.action',
         type : 'POST',   
         async : false,
         dataType : 'json',
         cache : false,
         data : {
            "productList" : JSON.stringify(totalArray)
         },        
         success : function(data){
        	 console.log(data);
        	 location.href = "/newbalance/payment/order.action";
        	 console.log(111111);
         }
      });
	 
});

$("#choiceProductOrder").click(function(){
	let totalArray = new Array();
	let obj = null;
	$("tr[name=cartRow] input[name=prodCode]:checked").each(function(i, e){
		obj = new Object();
		obj.pdCode = $(this).parents("#cartRow").find("input[name=prodCode]").val();
		obj.pdPrice = $(this).parents("#cartRow").find("input[name=prodCode]").data("pdprice");
		obj.pdName = $(this).parents("#cartRow").find("input[name=prodCode]").data("pdname");
		obj.qty = $(this).parents("#cartRow").find("input[name=prodCode]").data("qty");
		obj.cartNum = $(this).parents("#cartRow").find("input[name=prodCode]").data("cartnum");
		obj.imgUrl = $(this).parents("#cartRow").find("img").attr("src");
		obj.opt = $(this).parents("#cartRow").find(".p_opt:nth-child(2)").text();
		obj.sizeCode = $(this).parents("#cartRow").find("input[name=prodCode]").data("sizecode");
		totalArray.push(obj);

	});
	//console.log(totalArray);
	
	 $.ajax({
         url : '/newbalance/payment/order.action',
         type : 'POST',   
         async : false,
         dataType : 'json',
         cache : false,
         data : {
            "productList" : JSON.stringify(totalArray)
         },        
         success : function(data){
         },
         error: function(data){
             alert("에러가 발생했습니다.");
         }
      });
});

function deleteCart(prod){
		var delArray = new Array();		
		delArray.push(prod);

        console.log(delArray);
    
        $.ajax({
           url : '/newbalance/customer/deleteCartProduct.ajx',
           type : 'POST',   
           async : false,
           dataType : 'json',
           cache : false,
           data : JSON.stringify({
              "delList" : delArray
           }),       
           contentType : 'application/json',
           success : function(data){
              if(data.result == "00"){
            	  alert("선택한 상품을 장바구니에서 삭제했습니다.");
              } else{
            	  alert("선택한 상품을 장바구니에서 삭제하는데 실패했습니다.");
              }
           },
           error: function(data){
               alert("에러가 발생했습니다.");
           },
           complete : function() {
				document.location.reload();
			}	
        });
	}
	
function likeWishList(prod) {
	var array = new Array();		
	array.push(prod);
	$.ajax({
        url : '/newbalance/product/wishList.ajx',
        type : 'POST',   
        async : false,
        dataType : 'json',
        cache : false,
        data : JSON.stringify({
           "pdCode" : array
        }),        
        contentType : 'application/json',
        success : function(data){
           if(data.result == "00"){
         	  $(".comp_txt1").html("관심 상품으로 등록되었습니다.");						
					$("#wishListPopup").show();
					$("#wishListPopup").center();
			   		$(".dimm_pop").show();
           } else{
         	  $(".comp_txt1").html("이미 관심상품으로 등록된 상품입니다.");		        		
					$("#wishListPopup").show();
					$("#wishListPopup").center();
					$(".dimm_pop").show();
           }
        },
        error: function(data){
            alert("에러가 발생했습니다.");
        }
     });
}
function qtyChange(obj) {
		if(confirm("수량을 변경 하시겠습니까?")) {
			var qty = $(obj).parents("#cartRow").find("#selectbox option:selected").val();
			var cartNum =  $(obj).parents("#cartRow").find("input[name=prodCode]").data("cartnum");

			$.ajax({
				async: false,
				url: "/newbalance/customer/updateCartQty.ajx",
				type: "POST",
				data: JSON.stringify({
					"qty" : qty
					,"cartNum" : cartNum
				}),
				dataType: 'json',
				contentType : 'application/json',
				success: function (data) {
					if(data.result == "00") {
						alert("수량이 변경되었습니다.");
					} else if(data.result == "99") {
						alert("수량 변경에 실패했습니다.");
					}
				},
				error:function(p) {
					alert(p.error_message);
				},
				complete : function() {
					document.location.reload();
				}		
			});
		}
	}
$("#btnWishListPopupClose").click(function() {
	$("#wishListPopup").hide();
	$(".dimm_pop").hide();
});


$("#btnLayerPopupClose").click(function() {
	$("#wishListPopup").hide();
	$(".dimm_pop").hide();
});

function totalAmount(){
	var checkbox  = $("input:checkbox[name=prodCode]:checked");
	var orderPrice = 0;
	var dlvyPrice = 0;
	
	checkbox.each(function(i) {
		orderPrice += parseInt($(this).parents("#cartRow").find("#price").text().replace(/,/g, ''));
	});
	
	$("#choiceCount").text(checkbox.length);
	$("#orderPrice").text(fnNumFormat(orderPrice));
	$("#dlvyPrice").text(fnNumFormat(dlvyPrice));
	$("#totalPrice").text(fnNumFormat(orderPrice + dlvyPrice));
}

function fnNumFormat(n) {
	var reg = /(^[+-]?\d+)(\d{3})/; // 정규식
	n = String(n); //숫자 -> 문자변환
	while (reg.test(n)) {
		n = n.replace(reg, "$1" + "," + "$2");
	}
	return n;
}

jQuery.fn.center = function () {
    this.css("position","absolute");
    this.css("top", Math.max(0, (($(window).height() - $(this).outerHeight()) / 2) + $(window).scrollTop()) + "px");
    this.css("left", Math.max(0, (($(window).width() - $(this).outerWidth()) / 2) + $(window).scrollLeft()) + "px");
    return this;
}
</script>
