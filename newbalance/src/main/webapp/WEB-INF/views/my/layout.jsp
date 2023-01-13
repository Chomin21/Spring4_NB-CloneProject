<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">

	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
		<title><tiles:getAsString name="title" /></title>
		<link href='<tiles:getAsString name="css"/>' type="text/css" rel="stylesheet" />
		<link rel="icon" type="image/x-icon" href="https://image.nbkorea.com/NBRB_Favicon/favicon.ico"/>
		<link rel="stylesheet" href="/newbalance/css/common/common.css"/>
		<link rel="stylesheet" href="/newbalance/css/common/header.css"/>
		<link rel="stylesheet" href="/newbalance/css/my/myLeftMenu.css" />
		<link rel="stylesheet" href="/newbalance/css/common/footer.css"/>
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
	</head>
	<body>
		<!-- header 부분 -->
		<tiles:insertAttribute name="header" />
		
		<!-- main content -->
		<div class="container">
		<div class="contents">
				<div class="my_wrap">
					<tiles:insertAttribute name="myLeftMenu" />
					<!-- content -->
					<tiles:insertAttribute name="content" />
				</div>
			</div>
		</div>
		
		<!-- footer 부분 -->	
		<tiles:insertAttribute name="footer" />
	</body>


	
</html>
