<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>

<!-- 콘텐트 구현 부분 start -->
<div class="my_cont">
	<div class="title_area">
	<h3 class="page_tit">관심상품</h3>
	<ul class="page_txt_info">
		<li>상품 정보는 1달 동안 유지되며, 이후에는 자동 삭제됩니다.</li>
		<li>관심 상품에 담은 시점과 구매 시점의 <strong class="point">상품 가격 및 할인 정보</strong>가 다를 수 있으니 유의해 주시기 바랍니다.</li>
	</ul>
	</div>
	<!-- 상품 정보 리스트 -->
	<div class="my_pro_list">
		<div class="top_area">
			<input type="checkbox" id="checkbox_all" name="checkbox_all" class="ip_chekbox" onclick="checkbox_all()"><label for="checkbox_all"><span class="blind">전체선택</span></label>
		<a href="javascript:;" class="btn_ty_bface xs" id="chooseDeleteWish" >선택삭제</a>
	</div>
	<!-- 리스트 목록 -->
	<div class="list_area">
	<ul class="goods_list02">
		<c:if test="${not empty wishData }">
		<c:forEach items="${wishData}" var = "wishdto" varStatus="status">
			<li>
				<span class="img_tag">	
				</span>
				<a href="/newbalance/product/productDetail.action" class="pro_area">
					<img src="${wishdto.imgUrl}" alt="${wishdto.pdCode}" class="img_goods">
					<span class="img_made">
					</span>
					<div class="badge"></div>
					<p class="trade_name">${wishdto.pdName}</p>
					<div class="price"><p><fmt:formatNumber type = "number"  maxFractionDigits = "10" value = "${wishdto.pdPrice}" /><span>원</span></p></div>
					<div class="sale_info"></div>
				</a>
				<p class="pro_check"><input type="checkbox" id="check_${status.count}" class="ip_chekbox" value="${wishdto.wishCode}"><label for="check_${status.count}"><span class="blind">해당 제품 선택</span></label></p>
			</li>

		</c:forEach>
		</c:if>
	</ul>
	</div>
	<!-- //리스트 목록 -->
	</div>
	<!-- //상품 정보 리스트 -->
</div>

    
<script>
// 상품 정보는 1달동안 유지 후 자동 삭제
// 맨 위 체크박스 선택시 전체 선택
// 삭제할 상품 선택 후 선택삭제 버튼 클릭
// 삭제 확인 문구의 경고창 띄우기
</script>
<script type="text/javascript">
$(document).ready(function(){	
	
	var wishCode; // 삭제할 위시리스트 번호
	
		//전체선택 체크박스 클릭 
		$("#checkbox_all").click(function(){
			if($("#checkbox_all").prop("checked")) { 
				//해당화면에 전체 checkbox들을 체크해준다 
				$("input[type=checkbox]").prop("checked",true); 
			} else { 
				//해당화면에 모든 checkbox들의 체크를해제시킨다. 
				$("input[type=checkbox]").prop("checked",false); 
			} 
		});
		
		//상품 삭제
		$("#chooseDeleteWish").click(function() {
		   var wishArray = new Array();      
		   if($("input[id^='check_']:checked").length == 0){
				alert("체크박스를 선택해 주세요.");
				return false;
		   }
		   
		   $("input[id^='check_']:checked").each(function() {
			   wishArray.push($(this).val());
		   });
		
		     console.log(wishArray);
		 
		     $.ajax({
		        url : '/newbalance/my/deleteWishList.ajx',
		        type : 'POST',   
		        async : false,
		        dataType : 'json',
		        cache : false,
		        data :  JSON.stringify({
		           "wishList" : wishArray
		        }),        
		        contentType : 'application/json',
		        success : function(data){
		           if(data.result == "00"){
		        	   alert('관심상품이 삭제되었습니다.'); 
		           } else{
		              alert("선택한 상품을 관심상품에서 삭제하는데 실패했습니다.");
		           }
		        },
		        error: function(data){
		        },
		        complete : function() {
		         document.location.reload();
		      }   
		     });
		});
});	
</script>
