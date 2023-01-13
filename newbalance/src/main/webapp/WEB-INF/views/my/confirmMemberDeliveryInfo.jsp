<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>뉴발란스 공식 온라인스토어</title>
<link rel="icon" type="image/x-icon"
   href="https://image.nbkorea.com/NBRB_Favicon/favicon.ico">
   <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
</head>
<body>

</body>
<script>
$(function(){
	if ('${process}' == 'delete') {
		if ('${result}'== 'success'){
			alert("배송지가 삭제되었습니다.");
		} else {
			alert("배송지 삭제에 실패했습니다.");
		}
	} else if('${process}' == 'update') {
		if ('${result}'== 'success'){
			alert("배송지가 수정되었습니다.");
		} else {
			alert("배송지 수정에 실패했습니다.");
		}
	} else if ('${process}' == 'insert') {
		if ('${result}'== 'success') {
			alert("배송지 추가가 정상적으로 처리 되었습니다.");
		} else if ('${result}'== 'duplicate'){
			alert("이미 동일주소로 배송지 주소록에 존재하고 있습니다. 다시 시도해주시기 바랍니다.");
		}else {
			alert("배송지 추가에 실패했습니다.");
		}
	}
	location.href = "/newbalance/my/memberDeliveryInfo.action";
});

</script>
</html>