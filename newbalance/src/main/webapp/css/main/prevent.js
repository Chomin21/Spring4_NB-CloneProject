/** NEWBALANCE Front Office에서 목록화면에 사용하기 위한 스크립트입니다.
 *  오른쪽 마우스 컨택스트 메뉴, 선택, 드래그, 터치를 차단하기 위한 공통 스크립트
 *  필요한 영역이 있을경우 
 */

$(function() {
	// 상품리뷰 팝업
	$("#reviewWriteLayerPopup").on("contextmenu", function(event) {event.preventDefault(); return false;});
	$("#reviewWriteLayerPopup").on("selectstart", function(event) {event.preventDefault(); return false;});
	$("#reviewWriteLayerPopup").on("dragstart", function(event) {event.preventDefault(); return false;});
	
	// 메인
	$("div.main").on("contextmenu", function(event) {event.preventDefault(); return false;});
	$("div.main").on("selectstart", function(event) {event.preventDefault(); return false;});
	$("div.main").on("dragstart", function(event) {event.preventDefault(); return false;});
	
	// IMC MD'S CHOICE, LOOKSHOP
	$("div.collection").on("contextmenu", function(event) {event.preventDefault(); return false;});
	$("div.collection").on("selectstart", function(event) {event.preventDefault(); return false;});
	$("div.collection").on("dragstart", function(event) {event.preventDefault(); return false;});
	
	// 상품목록퀵뷰, 검색, 상품목록, 상품상세, 상품상세(expand view)
	$("div[data-gesture='prevent']").on("contextmenu", function(event) {event.preventDefault(); return false;});
	$("div[data-gesture='prevent']").on("selectstart", function(event) {event.preventDefault(); return false;});
	$("div[data-gesture='prevent']").on("dragstart", function(event) {event.preventDefault(); return false;});
});