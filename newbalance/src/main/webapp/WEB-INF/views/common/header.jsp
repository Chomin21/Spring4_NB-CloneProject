<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" uri="http://www.springframework.org/security/tags"%>
<% String contextPath = request.getContextPath(); %>
<script
zsrc="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>

<script type="text/javascript">
	var pre_idx = null;
	var pre_label = null;
	
	
	$(document).ready(function() {
		
		$('div.top_search #schWord').on('keydown', function (event) {
	        if (event.which == 13) {diffColorList
	            event.preventDefault();            
	            
	            var schWord = $('#schWord').val();
				/* var replaceSchWord = schWord.replace(/[\{\}\[\]\/?.,;:|\)*~`!^\-_+<>@#$%&\\\=\(\'\"]/gi, "");
				
				if($.trim(replaceSchWord) != "") {
					//풀스캔 방지
					fnIntegratedSearch(schWord);
				} */
				fnIntegratedSearch(schWord);
	        }
	    });
		
		
		$('div.top_search #btnProdSch').on('click', function () {           
            var schWord = $('#schWord').val();
			/* var replaceSchWord = schWord.replace(/[\{\}\[\]\/?.,;:|\)*~`!^\-_+<>@#$%&\\\=\(\'\"]/gi, "");
			
			if($.trim(replaceSchWord) != "") {
				//풀스캔 방지
				fnIntegratedSearch(schWord);
			} */
			fnIntegratedSearch(schWord);
	    });
		
		
		fnIntegratedSearch = function(schWord) {
			if($.trim(schWord) == "NB" || $.trim(schWord) == "nb") {
				alert("해당 검색어는 사용하실 수 없습니다.");
				return;
			} else if($.trim(schWord) == "") {
				alert("상품검색어를 입력해 주세요.");
				return;
			} else {
				schWord = $.trim(schWord);
				fnAddRecentSearchWord(schWord);
				var schEncWord = encodeURI(encodeURIComponent(schWord));
				var prodPart = $("#prodPart").val();
				var schUrl = "/newbalance/product/searchResult.action?schWord=" + schEncWord + "&prodPart=" + prodPart;
				document.location.replace(schUrl);
				
			}
		}
		
		
		document.title = "뉴발란스 공식 온라인스토어";
				
		
		$("head").append("<meta name='keywords' content='뉴발란스,뉴발란스 신상품, 뉴발란스키즈,뉴발,뉴발란스키즈 신상품, 뉴발란스 키즈 운동화, 뉴발란스 운동화, 뉴발란스327, 뉴발란스992, 뉴발란스530' />");
		$("head").append("<meta name='description' content='WE GOT NOW. 한정상품 발매 정보와 가입시 5,000원 혜택까지' />");
	    
	    
		$('[data-gtag-idx]').on('click', function () {
			var gtagIdx 		= $(this).data("gtagIdx");
			var gtagCategory 	= $(this).data("gtagCate");			
			var gtagEventName 	= $(this).data("gtagEventName");
			var gtagLabel 		= $(this).data("gtagLabel");
			var categoryName	= $(this).data("categoryName");
			var label			= null;
			
			if(nb_gtag_data[gtagIdx]) {
				gtagEventName = gtagEventName == undefined ? '' : gtagEventName;
				gtagLabel = gtagLabel == undefined ? '' : gtagLabel;
				categoryName = categoryName == undefined ? '' : (categoryName + '_');
				
				
				if(nb_gtag_data[gtagIdx].event_info.is_ref == true){
					gtagLabel = $("#" + $(this).data("gtagRef")).val();
				}
				
				// 동적 데이터를 세팅하는 경우 (GNB 카테고리)
				if(gtagCategory) {
					nb_gtag_data[gtagIdx].event_name += gtagEventName;
					nb_gtag_data[gtagIdx].event_info.event_category += gtagCategory;				
					nb_gtag_data[gtagIdx].event_info.event_label = gtagLabel;
				} else {
					if(gtagLabel) {
						gtagLabel = (categoryName + gtagLabel);
						nb_gtag_data[gtagIdx].event_info.event_label += gtagLabel;
						
						// GNB 2depth 세팅하는 경우
						if(categoryName){
							nb_gtag_data[gtagIdx].event_name += $(this).data("categoryName");
						}
					}
				}				
				
				label = nb_gtag_data[gtagIdx].event_info.event_label;
				
				// 동일 gtagIdx, label 값을 클릭 했을 경우 GA_태그 이벤트 발송 제외
				if(!(pre_label == label && pre_idx == gtagIdx)){
					gtag("event", nb_gtag_data[gtagIdx].event_name, nb_gtag_data[gtagIdx].event_info);
					pre_idx	= gtagIdx;
					pre_label = label;
				}				
				// 해당 링크가 새창으로 열릴경우, 이벤트 라벨명이 뉴락되는 현상 방지
				if(gtagLabel) {
					nb_gtag_data[gtagIdx].event_info.event_label = "";
				}				
			}
	    });	    
	    
				
		fnDrawRecentWordArea();
		
		$('.category_box').hover(function() {
            $('.ip_text').click(function() {
                $('.srch_list_area').show();
                $('.category_box').addClass('open');
            });
            
        }, function() {
            $('.srch_list_area').hide();
            $('.category_box').removeClass('open');
        });
        
        $("#btnRecentWordRemoveAll").on('click', function() {        	
        	NbStorage.remove();
        	fnDrawRecentWordArea();
        });
        
        
        $("#recentSearch").on('click', "ul li span[name='btnRecentWordRemove']", function () {        	
        	var idx = $(this).data("key");
        	
        	var recentSearchWordDataJSON = NbStorage.get("recentSearchWordData");
    		var recentSearchWordReNew = {};
    		if(recentSearchWordDataJSON && JSON.parse(recentSearchWordDataJSON)) {
    			
    			var recentSearchWordList = JSON.parse(recentSearchWordDataJSON);
    			var removeWord = recentSearchWordList[idx];
    			var ordNo = 1;
    			
    			for (var i in recentSearchWordList) {
    				var itemWord = recentSearchWordList[i];
    				
    				
    				if(unescape(itemWord) != unescape(removeWord)) {
    					recentSearchWordReNew[ordNo] = itemWord;
    					ordNo ++;
    				}
    			}
    		}
    		
    		NbStorage.set("recentSearchWordData", JSON.stringify(recentSearchWordReNew));
    		fnDrawRecentWordArea();    		
        });
        
    	
        $("#recentSearch").on('click', "ul li a[name='btnRecentWordSearch']", function () {
        	var schWord 	= $(this).data("word");
        	fnAddRecentSearchWord(schWord);
			var schEncWord = encodeURI(encodeURIComponent(schWord));
			document.location.replace("/product/searchResult.action?schWord=" + schEncWord);
        });
        
	});
	
	
	function fnAddRecentSearchWord(schWord) {
		var recentSearchWordDataJSON = NbStorage.get("recentSearchWordData");
		var recentSearchWordAdded = {};
		
		schWord = schWord.toString().replace(/[<>@#$%&\\\=\(\'\"]/ig,"");
		schWord = escape(schWord);
		recentSearchWordAdded[0] = schWord;
		
		if(recentSearchWordDataJSON) {
			var recentSearchWordList = JSON.parse(recentSearchWordDataJSON);
			var ordNo = 1;

			for (var i in recentSearchWordList) {
				if(recentSearchWordList[i] != schWord) {
					recentSearchWordAdded[ordNo]  = recentSearchWordList[i];
					if(ordNo >= 9) break;
					ordNo++;				
				}
			}
		}
		
		NbStorage.set("recentSearchWordData", JSON.stringify(recentSearchWordAdded));		
	}
	
	
	function fnDrawRecentWordArea() {
		
		var recentSearchWordDataJSON = NbStorage.get("recentSearchWordData");
		var recentSearchWordItem = new StringBuilder();
		
		if(JSON.stringify(recentSearchWordDataJSON) && (JSON.stringify(recentSearchWordDataJSON) == "\"{}\"") == false) {
			
			var recentSearchWordList = JSON.parse(recentSearchWordDataJSON);
			recentSearchWordItem.append("<ul>");			
			for (var i in recentSearchWordList) {
				recentSearchWordItem.append("<li>");				
				recentSearchWordItem.append("<a class=\"srch_txt\" href=\"javascript:;\" name=\"btnRecentWordSearch\" data-word=\"" + unescape(recentSearchWordList[i]) + "\" data-gtag-idx=\"fo_common_5_1\" data-gtag-label=\"" + unescape(recentSearchWordList[i]) + "\"><span>" + unescape(recentSearchWordList[i]) + "</span></a>");
				recentSearchWordItem.append("<span class=\"del\" href=\"javascript:;\" name=\"btnRecentWordRemove\" data-key=\"" + i + "\"><img src=\"https://image.nbkorea.com/NBRB_PC/common/btn_delete_15x15.jpg\"></span>"); 
				recentSearchWordItem.append("</li>");
			}
			recentSearchWordItem.append("</ul>");
		} else {
			recentSearchWordItem.append("<p class=\"no_result\">최근 검색어 내역이<br /> 없습니다.</p>");
		}
		
		$("#recentSearch").html(recentSearchWordItem.toString());
		
		// $("#recentSearch").on('click', "ul li a[name='btnRecentWordSearch']", gaTag);
	}
	
	
	
	
	
	
	
		
	function gaTag(){
		var gtagIdx 		= $(this).data("gtagIdx");
		var gtagCategory 	= $(this).data("gtagCate");			
		var gtagEventName 	= $(this).data("gtagEventName");
		var gtagLabel 		= $(this).data("gtagLabel");
		var schWord 		= $(this).data("word");			//최근 검색어
		var label			= null;
		
		if(nb_gtag_data[gtagIdx]) {
			gtagEventName = gtagEventName == undefined ? '' : gtagEventName;
			gtagLabel = gtagLabel == undefined ? '' : gtagLabel;
			schWord = schWord == undefined ? '' : schWord;
			
			
			if(nb_gtag_data[gtagIdx].event_info.is_ref == true){
				gtagLabel = $("#" + $(this).data("gtagRef")).val();
			} 
			
			if(schWord){
				nb_gtag_data[gtagIdx].event_info.event_label += schWord;
			}
			
			
			if(gtagCategory) {
				nb_gtag_data[gtagIdx].event_name += gtagEventName;
				nb_gtag_data[gtagIdx].event_info.event_category += gtagCategory;				
				nb_gtag_data[gtagIdx].event_info.event_label = gtagLabel;
			} else {
				if(gtagLabel) {
					nb_gtag_data[gtagIdx].event_info.event_label += gtagLabel;
				}
			}
			label = nb_gtag_data[gtagIdx].event_info.event_label;
			
			// 동일 gtagIdx, label 값을 클릭 했을 경우 GA_태그 이벤트 발송 제외
			if(!(pre_label == label && pre_idx == gtagIdx)){
				gtag("event", nb_gtag_data[gtagIdx].event_name, nb_gtag_data[gtagIdx].event_info);
				pre_idx	= gtagIdx;
				pre_label = label;
			}			
			
			
			if(gtagLabel) {
				nb_gtag_data[gtagIdx].event_info.event_label = "";
			}			
		}	   
	}
</script>
<style>
</style>
</head>
<body>
<div class = "hhh">
	<div class="header on">
	
	
	<!-- top_menu -->
	<div class="top_menu">
		<div class="inner">
			<a href="/collection/madeusauk.action" class="made" data-gtag-idx="fo_common_1_1"><img src="https://image.nbkorea.com/NBRB_PC/common/btn_made_99x16.png" alt="MADE IN USA /UK"></a>
			<a href="/my/introMyNB.action" class="mynb" data-gtag-idx="fo_common_1_2"><img src="https://image.nbkorea.com/NBRB_PC/common/logo_mynb.png" alt="MYNB"></a>
			<ul class="clearfix">				
						<li><a href="/newbalance/support/storeSearch.action" data-gtag-idx="fo_common_1_3">매장찾기</a></li>
						<li><a href="/newbalance/support/notice.action" data-gtag-idx="fo_common_1_4">공지사항</a></li>
						<li><a href="/newbalance/support/faq.action" data-gtag-idx="fo_common_1_5">FAQS</a></li>
						<li><a href="/newbalance/nbnyou/searchEventList.action" data-gtag-idx="fo_common_1_6">이벤트</a></li>
			</ul>
		</div>
	</div>
	<!-- // top_menu -->
	
	<!-- gnb -->
	<div class="gnb">
		<div class="inner">
			<h1 class="logo"><a href="/" data-gtag-idx="fo_common_2">New Balance</a></h1>

			<!-- global_menu -->
			
			<div class="menu">
				<ul class="clearfix">
				
					<!-- MEN -->
					<li class="nav ">
						<a href="/product/subMain.action?cIdx=1279" class="menu_tit" data-gtag-idx="fo_common_3_1">Men</a>
						<div class="category_box" style="display: none;">
							<div class="inner" id="cateMen">
								<div class="depth">
									<strong class="tit">Featured</strong>
									<ul>
									
												<li class=""><a href="<%=contextPath %>/product/featuredList.action?cateGrpCode=M&cIdx=new" data-gtag-idx="fo_common_gbn_1" data-gtag-label="New" data-category-name="Featured" style="color: #141414;">New</a></li>
												<li class=""><a href="<%=contextPath %>/product/featuredList.action?cateGrpCode=M&cIdx=best" data-gtag-idx="fo_common_gbn_1" data-gtag-label="Best" data-category-name="Featured" style="color: #141414;">Best</a></li>
												<li class=""><a href="https://www.nbkorea.com/product/subMain.action?cIdx=1279" data-gtag-idx="fo_common_gbn_1" data-gtag-label="남성 메인" data-category-name="Featured" style="color: #141414;">남성 메인</a></li>
												<li class=""><a href="https://www.nbkorea.com/collection/nbrunning.action" data-gtag-idx="fo_common_gbn_1" data-gtag-label="NB 러닝" data-category-name="Featured" style="color: #141414;">NB 러닝</a></li>
												<li class=""><a href="https://www.nbkorea.com/collection/classicjogger.action" data-gtag-idx="fo_common_gbn_1" data-gtag-label="Classic Jogger" data-category-name="Featured" style="color: #141414;">Classic Jogger</a></li>
												<li class=""><a href="https://www.nbkorea.com/collection/iu22fw1.action" data-gtag-idx="fo_common_gbn_1" data-gtag-label="NB with IU" data-category-name="Featured" style="color: #141414;">NB with IU</a></li>
												<li class=""><a href="https://www.nbkorea.com/launchingCalendar/list.action" data-gtag-idx="fo_common_gbn_1" data-gtag-label="런칭캘린더" data-category-name="Featured" style="color: ;">런칭캘린더</a></li>
											
																		
									</ul>
								</div>
								
								
								
								
								
								
								
									
									
										
										
										
											<div class="depth">
										
													
									
									<strong class="tit">신발</strong>
									<ul>
										<li><a href="<%=contextPath %>/product/productList.action?cateGrpCode=M&cIdx=F" data-gtag-idx="fo_common_gbn_1" data-gtag-label="전체보기" data-category-name="신발">전체보기</a></li>
											<li><a href="<%=contextPath %>/product/productList.action?cateGrpCode=M&cIdx=F01" data-gtag-idx="fo_common_gbn_1" data-gtag-label="라이프스타일" data-category-name="신발">라이프스타일</a></li>
											<li><a href="<%=contextPath %>/product/productList.action?cateGrpCode=M&amp;cIdx=F02" data-gtag-idx="fo_common_gbn_1" data-gtag-label="클래식조거" data-category-name="신발">클래식조거</a></li>
											<li><a href="<%=contextPath %>/product/productList.action?cateGrpCode=M&amp;cIdx=F03" data-gtag-idx="fo_common_gbn_1" data-gtag-label="Made in USA/UK" data-category-name="신발">Made in USA/UK</a></li>
											<li><a href="<%=contextPath %>/product/productList.action?cateGrpCode=M&amp;cIdx=F04" data-gtag-idx="fo_common_gbn_1" data-gtag-label="러닝" data-category-name="신발">러닝</a></li>
											<li><a href="<%=contextPath %>/product/productList.action?cateGrpCode=M&amp;cIdx=F05" data-gtag-idx="fo_common_gbn_1" data-gtag-label="워킹" data-category-name="신발">워킹</a></li>
											<li><a href="<%=contextPath %>/product/productList.action?cateGrpCode=M&amp;cIdx=F06" data-gtag-idx="fo_common_gbn_1" data-gtag-label="트레일러닝" data-category-name="신발">트레일러닝</a></li>
											<li><a href="<%=contextPath %>/product/productList.action?cateGrpCode=M&amp;cIdx=F07" data-gtag-idx="fo_common_gbn_1" data-gtag-label="샌들/슬라이드" data-category-name="신발">샌들/슬라이드</a></li>
											<li><a href="<%=contextPath %>/product/productList.action?cateGrpCode=M&amp;cIdx=F08" data-gtag-idx="fo_common_gbn_1" data-gtag-label="농구" data-category-name="신발">농구</a></li>
											<li><a href="<%=contextPath %>/product/productList.action?cateGrpCode=M&amp;cIdx=F09" data-gtag-idx="fo_common_gbn_1" data-gtag-label="축구" data-category-name="신발">축구</a></li>
											<li><a href="<%=contextPath %>/product/productList.action?cateGrpCode=M&amp;cIdx=F10" data-gtag-idx="fo_common_gbn_1" data-gtag-label="야구/테니스" data-category-name="신발">야구/테니스</a></li>
											<li><a href="<%=contextPath %>/product/productList.action?cateGrpCode=M&amp;cIdx=F11" data-gtag-idx="fo_common_gbn_1" data-gtag-label="스케이트보딩" data-category-name="신발">스케이트보딩</a></li>
											<li><a href="<%=contextPath %>/product/productList.action?cateGrpCode=M&amp;cIdx=F12" data-gtag-idx="fo_common_gbn_1" data-gtag-label="골프" data-category-name="신발">골프</a></li>
							
											
										
									</ul>
									</div>
										
									
								
								
								
								
								
								
								
								
								
								
								
								
								
								
								
								
								
								
								
								
								
								
								
								
								
								
								
									
									
										
										
										
											<div class="depth">
										
													
									
									<strong class="tit">의류</strong>
									<ul>
										<li><a href="<%=contextPath %>/product/productList.action?cateGrpCode=M&cIdx=C" data-gtag-idx="fo_common_gbn_1" data-gtag-label="전체보기" data-category-name="의류">전체보기</a></li>
											<li><a href="<%=contextPath %>/product/productList.action?cateGrpCode=M&cIdx=C01" data-gtag-idx="fo_common_gbn_1" data-gtag-label="다운 자켓/베스트" data-category-name="의류">다운 자켓/베스트</a></li>
											<li><a href="<%=contextPath %>/product/productList.action?cateGrpCode=M&cIdx=C02" data-gtag-idx="fo_common_gbn_1" data-gtag-label="플리스" data-category-name="의류">플리스</a></li>
											<li><a href="<%=contextPath %>/product/productList.action?cateGrpCode=M&cIdx=C03" data-gtag-idx="fo_common_gbn_1" data-gtag-label="바람막이/자켓" data-category-name="의류">바람막이/자켓</a></li>
											<li><a href="<%=contextPath %>/product/productList.action?cateGrpCode=M&cIdx=C04" data-gtag-idx="fo_common_gbn_1" data-gtag-label="후드티/맨투맨" data-category-name="의류">후드티/맨투맨</a></li>
											<li><a href="<%=contextPath %>/product/productList.action?cateGrpCode=M&cIdx=C05" data-gtag-idx="fo_common_gbn_1" data-gtag-label="롱팬츠" data-category-name="의류">롱팬츠</a></li>
											<li><a href="<%=contextPath %>/product/productList.action?cateGrpCode=M&cIdx=C06" data-gtag-idx="fo_common_gbn_1" data-gtag-label="티셔츠" data-category-name="의류">티셔츠</a></li>
											<li><a href="<%=contextPath %>/product/productList.action?cateGrpCode=M&cIdx=C07" data-gtag-idx="fo_common_gbn_1" data-gtag-label="숏팬츠" data-category-name="의류">숏팬츠</a></li>
											<li><a href="<%=contextPath %>/product/productList.action?cateGrpCode=M&cIdx=C08" data-gtag-idx="fo_common_gbn_1" data-gtag-label="타이즈" data-category-name="의류">타이즈</a></li>
					
										
									</ul>
									</div>
										
									
								
								
								
								
								
								
								
								
								
								
								
								
								
								
								
								
								
								
								
									
									
										
										
										
											<div class="depth">
										
													
									
									<strong class="tit">용품</strong>
									<ul>
										<li><a href="<%=contextPath %>/product/productList.action?cateGrpCode=M&cIdx=T" data-gtag-idx="fo_common_gbn_1" data-gtag-label="전체보기" data-category-name="용품">전체보기</a></li>
											<li><a href="<%=contextPath %>/product/productList.action?cateGrpCode=M&cIdx=T01" data-gtag-idx="fo_common_gbn_1" data-gtag-label="백팩" data-category-name="용품">백팩</a></li>
											<li><a href="<%=contextPath %>/product/productList.action?cateGrpCode=M&cIdx=T02" data-gtag-idx="fo_common_gbn_1" data-gtag-label="가방" data-category-name="용품">가방</a></li>
											<li><a href="<%=contextPath %>/product/productList.action?cateGrpCode=M&cIdx=T03" data-gtag-idx="fo_common_gbn_1" data-gtag-label="양말" data-category-name="용품">양말</a></li>
											<li><a href="<%=contextPath %>/product/productList.action?cateGrpCode=M&cIdx=T04" data-gtag-idx="fo_common_gbn_1" data-gtag-label="모자" data-category-name="용품">모자</a></li>
											<li><a href="<%=contextPath %>/product/productList.action?cateGrpCode=M&cIdx=T05" data-gtag-idx="fo_common_gbn_1" data-gtag-label="기타" data-category-name="용품">기타</a></li>
		
										
									</ul>
									</div>
										
									
								
								
								
								
								
								
								
								
								
								
								
								
								
									
									
										
										
											<div class="depth g_goods">
										
										
													
									
									<strong class="tit">언더웨어</strong>
									<ul>
										<li><a href="<%=contextPath %>/product/productList.action?cateGrpCode=M&cIdx=U" data-gtag-idx="fo_common_gbn_1" data-gtag-label="전체보기" data-category-name="언더웨어">전체보기</a></li>
											<li><a href="<%=contextPath %>/product/productList.action?cateGrpCode=M&cIdx=U01" data-gtag-idx="fo_common_gbn_1" data-gtag-label="드로즈" data-category-name="언더웨어">드로즈</a></li>
											<li><a href="<%=contextPath %>/product/productList.action?cateGrpCode=M&cIdx=U02" data-gtag-idx="fo_common_gbn_1" data-gtag-label="릴랙서" data-category-name="언더웨어">릴랙서</a></li>
										
										
									</ul>
									</div>
										
									
								
								
								
								
								
								
								
								
								
								
								
								
								
								
								<!-- MEN 용품이 태그가 안닫혀서 마무리 태그 작업 -->
								
								<!-- 퍼포먼스 -->
								<div class="depth">
									<strong class="tit">스포츠</strong>
									<!--20210729-1 수정 :: S -->
									<ul>
										<!--20210903 수정 :: S-->
										<li>
											
											<a href="/collection/nbx.action" data-gtag-idx="fo_common_gbn_1" data-gtag-label="RUNNING" data-category-name="스포츠">RUNNING</a>
										</li>
										<!--20210903 수정 :: E-->
										<li>
											
											<a href="/product/productList.action?cateGrpCode=250110&amp;cIdx=1499" data-gtag-idx="fo_common_gbn_1" data-gtag-label="BASKETBALL" data-category-name="스포츠">BASKETBALL</a>
											<!--20200218 수정 -->
										</li>
										<li>
											
											<a href="/collection/Nboutdoor.action" data-gtag-idx="fo_common_gbn_1" data-gtag-label="OUTDOOR" data-category-name="스포츠">OUTDOOR</a>
										</li> 
									</ul>
									<!--20210729-1 수정 :: E -->	
								</div>
								<!--// 퍼포먼스 -->
							</div>
						</div>					
					</li>
					<!-- // MEN -->
					
					
					<!-- WOMEN -->
					<li class="nav ">
						<a href="/product/subMain.action?cIdx=1285" class="menu_tit" data-gtag-idx="fo_common_3_2">Women</a>
						<div class="category_box" style="display: none;">
							<div class="inner" id="cateWomen">
								<div class="depth">
									<strong class="tit">Featured</strong>
									<ul>
									
										
												<li class=""><a href="<%=contextPath %>/product/featuredList.action?cateGrpCode=W&cIdx=new" data-gtag-idx="fo_common_gbn_2" data-gtag-label="New" data-category-name="Featured" style="color: ;">New</a></li>
												<li class=""><a href="<%=contextPath %>/product/featuredList.action?cateGrpCode=W&cIdx=best" data-gtag-idx="fo_common_gbn_2" data-gtag-label="Best" data-category-name="Featured" style="color: #141414;">Best</a></li>
												<li class=""><a href="https://www.nbkorea.com/product/subMain.action?cIdx=1285" data-gtag-idx="fo_common_gbn_2" data-gtag-label="여성 메인" data-category-name="Featured" style="color: #141414;">여성 메인</a></li>
												<li class=""><a href="https://www.nbkorea.com/collection/nbrunning.action" data-gtag-idx="fo_common_gbn_2" data-gtag-label="NB 러닝" data-category-name="Featured" style="color: #141414;">NB 러닝</a></li>
												<li class=""><a href="https://www.nbkorea.com/collection/classicjogger.action" data-gtag-idx="fo_common_gbn_2" data-gtag-label="Classic Jogger" data-category-name="Featured" style="color: #141414;">Classic Jogger</a></li>
												<li class=""><a href="https://www.nbkorea.com/collection/iu22fw1.action" data-gtag-idx="fo_common_gbn_2" data-gtag-label="NB with IU" data-category-name="Featured" style="color: #141414;">NB with IU</a></li>
												<li class=""><a href="https://www.nbkorea.com/launchingCalendar/list.action" data-gtag-idx="fo_common_gbn_2" data-gtag-label="런칭캘린더" data-category-name="Featured" style="color: ;">런칭캘린더</a></li>
									
									
									</ul>
								</div>
					
									
								
									
								
									
									
																			
										
										
											<div class="depth">
										
									
									<strong class="tit">신발</strong>
									<ul>
										<li><a href="<%=contextPath %>/product/productList.action?cateGrpCode=W&cIdx=F" data-gtag-idx="fo_common_gbn_2" data-gtag-label="전체보기" data-category-name="신발">전체보기</a></li>
											<li><a href="<%=contextPath %>/product/productList.action?cateGrpCode=W&cIdx=F01" data-gtag-idx="fo_common_gbn_2" data-gtag-label="라이프스타일" data-category-name="신발">라이프스타일</a></li>
											<li><a href="<%=contextPath %>/product/productList.action?cateGrpCode=W&cIdx=F02" data-gtag-idx="fo_common_gbn_2" data-gtag-label="클래식조거" data-category-name="신발">클래식조거</a></li>
											<li><a href="<%=contextPath %>/product/productList.action?cateGrpCode=W&cIdx=F03" data-gtag-idx="fo_common_gbn_2" data-gtag-label="Made in USA/UK" data-category-name="신발">Made in USA/UK</a></li>
											<li><a href="<%=contextPath %>/product/productList.action?cateGrpCode=W&cIdx=F04" data-gtag-idx="fo_common_gbn_2" data-gtag-label="러닝" data-category-name="신발">러닝</a></li>
											<li><a href="<%=contextPath %>/product/productList.action?cateGrpCode=W&cIdx=F05" data-gtag-idx="fo_common_gbn_2" data-gtag-label="워킹" data-category-name="신발">워킹</a></li>
											<li><a href="<%=contextPath %>/product/productList.action?cateGrpCode=W&cIdx=F06" data-gtag-idx="fo_common_gbn_2" data-gtag-label="트레일러닝" data-category-name="신발">트레일러닝</a></li>
											<li><a href="<%=contextPath %>/product/productList.action?cateGrpCode=W&cIdx=F07" data-gtag-idx="fo_common_gbn_2" data-gtag-label="샌들/슬라이드" data-category-name="신발">샌들/슬라이드</a></li>
											<li><a href="<%=contextPath %>/product/productList.action?cateGrpCode=W&cIdx=F13" data-gtag-idx="fo_common_gbn_2" data-gtag-label="스튜디오/테니스" data-category-name="신발">스튜디오/테니스</a></li>
											<li><a href="<%=contextPath %>/product/productList.action?cateGrpCode=W&cIdx=F11" data-gtag-idx="fo_common_gbn_2" data-gtag-label="스케이트보딩" data-category-name="신발">스케이트보딩</a></li>
											<li><a href="<%=contextPath %>/product/productList.action?cateGrpCode=W&cIdx=F12" data-gtag-idx="fo_common_gbn_2" data-gtag-label="골프" data-category-name="신발">골프</a></li>
							
										
									</ul>
								</div>
								
									
								
									
								
									
								
									
								
									
								
									
								
									
								
									
								
									
								
									
								
									
								
									
									
																			
										
										
											<div class="depth">
										
									
									<strong class="tit">의류</strong>
									<ul>
										<li><a href="<%=contextPath %>/product/productList.action?cateGrpCode=W&cIdx=C" data-gtag-idx="fo_common_gbn_2" data-gtag-label="전체보기" data-category-name="의류">전체보기</a></li>
											<li><a href="<%=contextPath %>/product/productList.action?cateGrpCode=W&cIdx=C01" data-gtag-idx="fo_common_gbn_2" data-gtag-label="다운 자켓/베스트" data-category-name="의류">다운 자켓/베스트</a></li>
											<li><a href="<%=contextPath %>/product/productList.action?cateGrpCode=W&cIdx=C02" data-gtag-idx="fo_common_gbn_2" data-gtag-label="플리스" data-category-name="의류">플리스</a></li>
											<li><a href="<%=contextPath %>/product/productList.action?cateGrpCode=W&cIdx=C03" data-gtag-idx="fo_common_gbn_2" data-gtag-label="바람막이/자켓" data-category-name="의류">바람막이/자켓</a></li>
											<li><a href="<%=contextPath %>/product/productList.action?cateGrpCode=W&cIdx=C04" data-gtag-idx="fo_common_gbn_2" data-gtag-label="후드티/맨투맨" data-category-name="의류">후드티/맨투맨</a></li>
											<li><a href="<%=contextPath %>/product/productList.action?cateGrpCode=W&cIdx=C05" data-gtag-idx="fo_common_gbn_2" data-gtag-label="롱팬츠" data-category-name="의류">롱팬츠</a></li>
											<li><a href="<%=contextPath %>/product/productList.action?cateGrpCode=W&cIdx=C06" data-gtag-idx="fo_common_gbn_2" data-gtag-label="티셔츠" data-category-name="의류">티셔츠</a></li>
											<li><a href="<%=contextPath %>/product/productList.action?cateGrpCode=W&cIdx=C07" data-gtag-idx="fo_common_gbn_2" data-gtag-label="숏팬츠" data-category-name="의류">숏팬츠</a></li>
											<li><a href="<%=contextPath %>/product/productList.action?cateGrpCode=W&cIdx=C09" data-gtag-idx="fo_common_gbn_2" data-gtag-label="레깅스" data-category-name="의류">레깅스</a></li>
											<li><a href="<%=contextPath %>/product/productList.action?cateGrpCode=W&cIdx=C10" data-gtag-idx="fo_common_gbn_2" data-gtag-label="슬리브리스/브라탑" data-category-name="의류">슬리브리스/브라탑</a></li>
											<li><a href="<%=contextPath %>/product/productList.action?cateGrpCode=W&cIdx=C11" data-gtag-idx="fo_common_gbn_2" data-gtag-label="스커트/원피스" data-category-name="의류">스커트/원피스</a></li>
					
										
									</ul>
								</div>
								
									
								
									
								
									
								
									
								
									
								
									
								
									
								
									
								
									
								
									
								
									
								
									
									
																			
										
										
											<div class="depth">
										
									
									<strong class="tit">용품</strong>
									<ul>
										<li><a href="<%=contextPath %>/product/productList.action?cateGrpCode=W&cIdx=T" data-gtag-idx="fo_common_gbn_2" data-gtag-label="전체보기" data-category-name="용품">전체보기</a></li>		
											<li><a href="<%=contextPath %>/product/productList.action?cateGrpCode=W&cIdx=T01" data-gtag-idx="fo_common_gbn_2" data-gtag-label="백팩" data-category-name="용품">백팩</a></li>
											<li><a href="<%=contextPath %>/product/productList.action?cateGrpCode=W&cIdx=T02" data-gtag-idx="fo_common_gbn_2" data-gtag-label="가방" data-category-name="용품">가방</a></li>
											<li><a href="<%=contextPath %>/product/productList.action?cateGrpCode=W&cIdx=T03" data-gtag-idx="fo_common_gbn_2" data-gtag-label="양말" data-category-name="용품">양말</a></li>
											<li><a href="<%=contextPath %>/product/productList.action?cateGrpCode=W&cIdx=T04" data-gtag-idx="fo_common_gbn_2" data-gtag-label="모자" data-category-name="용품">모자</a></li>
											<li><a href="<%=contextPath %>/product/productList.action?cateGrpCode=W&cIdx=T05" data-gtag-idx="fo_common_gbn_2" data-gtag-label="기타" data-category-name="용품">기타</a></li>
											
										
									</ul>
								</div>
								
									
								
									
								
									
								
									
								
									
								
									
								
									
									
																			
										
											<div class="depth g_goods">
										
										
									
									<strong class="tit">언더웨어</strong>
									<ul>
										<li><a href="<%=contextPath %>/product/productList.action?cateGrpCode=W&cIdx=U" data-gtag-idx="fo_common_gbn_2" data-gtag-label="전체보기" data-category-name="언더웨어">전체보기</a></li>
											<li><a href="<%=contextPath %>/product/productList.action?cateGrpCode=W&cIdx=U03" data-gtag-idx="fo_common_gbn_2" data-gtag-label="브라/캐미솔" data-category-name="언더웨어">브라/캐미솔</a></li>
											<li><a href="<%=contextPath %>/product/productList.action?cateGrpCode=W&cIdx=U04" data-gtag-idx="fo_common_gbn_2" data-gtag-label="팬티/드로즈" data-category-name="언더웨어">팬티/드로즈</a></li>
											<li><a href="<%=contextPath %>/product/productList.action?cateGrpCode=W&cIdx=U01" data-gtag-idx="fo_common_gbn_2" data-gtag-label="릴랙서" data-category-name="언더웨어">릴랙서</a></li>
									
										
											
										
									</ul>
								</div>
								
									
								
									
								
									
								
									
								
									
								
									
								
									
								
								
								
								<!-- 퍼포먼스 -->
								<div class="depth">
									<strong class="tit">스포츠</strong>
									<!--20210729-1 수정 :: S -->
									<ul class="sp_bnr">
										<li>
											
											<a href="/product/productList.action?cateGrpCode=250110&amp;cIdx=1336" data-gtag-idx="fo_common_gbn_2" data-gtag-label="STUDIO" data-category-name="스포츠">STUDIO</a>
										</li>
										<!-- 20210903 수정 :: S -->
										<li>
											
											<a href="/collection/nbx.action" data-gtag-idx="fo_common_gbn_2" data-gtag-label="RUNNING" data-category-name="스포츠">RUNNING</a>
										</li>
										<li>
											
											<a href="/etc/collection.action?collectionIdx=4619" data-gtag-idx="fo_common_gbn_2" data-gtag-label="WOMENS" data-category-name="스포츠">WOMENS</a>
										</li>
										<!-- 20210903 수정 :: E -->
									</ul>
									<!--20210729-1 수정 :: E -->		
								</div>
								<!--// 퍼포먼스 -->
							</div>
						</div>
					</li>
					<!-- // WOMEN -->
					
					
					
					<!-- KIDS -->
					<li class="nav ">
						<a href="/product/subMain.action?cIdx=1286" class="menu_tit" data-gtag-idx="fo_common_3_3">Kids</a>
						<div class="category_box" style="display: none;">
							<div class="inner" id="cateKids">
								<div class="depth">
									<strong class="tit">Featured</strong>									
									<ul>
									
										<li class=""><a href="https://www.nbkorea.com/product/subMain.action?cIdx=1286" data-gtag-idx="fo_common_gbn_3" data-gtag-label="키즈 메인" data-category-name="Featured" style="color: #141414;">키즈 메인</a></li>
												<li class=""><a href="<%=contextPath %>/product/featuredList.action?cateGrpCode=K&cIdx=new" data-gtag-idx="fo_common_gbn_3" data-gtag-label="New" data-category-name="Featured" style="color: #141414;">New</a></li>
												<li class=""><a href="<%=contextPath %>/product/featuredList.action?cateGrpCode=K&cIdx=new" data-gtag-idx="fo_common_gbn_3" data-gtag-label="베스트" data-category-name="Featured" style="color: #141414;">베스트</a></li>							
												<li class=""><a href="https://www.nbkorea.com/etc/collection.action?collectionIdx=4705" data-gtag-idx="fo_common_gbn_3" data-gtag-label="NBgC (NB girls CLUB)" data-category-name="Featured" style="color: #ff57ae;">NBgC (NB girls CLUB)</a></li>
												<li class=""><a href="https://www.nbkorea.com/etc/collection.action?collectionIdx=4893" data-gtag-idx="fo_common_gbn_3" data-gtag-label="2023 신학기 책가방" data-category-name="Featured" style="color: #141414;">2023 신학기 책가방</a></li>
												<li class=""><a href="https://www.nbkorea.com/etc/collection.action?collectionIdx=4863" data-gtag-idx="fo_common_gbn_3" data-gtag-label="NEWKIMO DOWN" data-category-name="Featured" style="color: #141414;">NEWKIMO DOWN</a></li>
												<li class=""><a href="https://www.nbkorea.com/etc/collection.action?collectionIdx=4844" data-gtag-idx="fo_common_gbn_3" data-gtag-label="WE LOVE WINTER" data-category-name="Featured" style="color: #000000;">WE LOVE WINTER</a></li>
												<li class=""><a href="https://www.nbkorea.com/etc/collection.action?collectionIdx=4606" data-gtag-idx="fo_common_gbn_3" data-gtag-label="KIDS 878 Collection" data-category-name="Featured" style="color: #000000;">KIDS 878 Collection</a></li>
												<li class=""><a href="https://www.nbkorea.com/etc/collection.action?collectionIdx=4634" data-gtag-idx="fo_common_gbn_3" data-gtag-label="KIDS 327 Collection" data-category-name="Featured" style="color: #141414;">KIDS 327 Collection</a></li>
												<li class=""><a href="https://www.nbkorea.com/etc/collection.action?collectionIdx=4798" data-gtag-idx="fo_common_gbn_3" data-gtag-label="LITTLE 530" data-category-name="Featured" style="color: #000000;">LITTLE 530</a></li>
											
																			
									</ul>
								</div>
					
								
								
								
								
									
									
										
										
											<div class="depth">
										
									
									<strong class="tit">신발</strong>
									<ul>
										<li><a href="<%=contextPath %>/product/productList.action?cateGrpCode=K&cIdx=F" data-gtag-idx="fo_common_gbn_3" data-gtag-label="전체보기" data-category-name="신발">전체보기</a></li>				
											<li><a href="<%=contextPath %>/product/productList.action?cateGrpCode=K&cIdx=F14" data-gtag-idx="fo_common_gbn_3" data-gtag-label="운동화(110~130mm)" data-category-name="신발">운동화(110~130mm)</a></li>
											<li><a href="<%=contextPath %>/product/productList.action?cateGrpCode=K&cIdx=F15" data-gtag-idx="fo_common_gbn_3" data-gtag-label="운동화(130~160mm)" data-category-name="신발">운동화(130~160mm)</a></li>
											<li><a href="<%=contextPath %>/product/productList.action?cateGrpCode=K&cIdx=F16" data-gtag-idx="fo_common_gbn_3" data-gtag-label="운동화(170~220mm)" data-category-name="신발">운동화(170~220mm)</a></li>
											<li><a href="<%=contextPath %>/product/productList.action?cateGrpCode=K&cIdx=F17" data-gtag-idx="fo_common_gbn_3" data-gtag-label="운동화(225~240mm)" data-category-name="신발">운동화(225~240mm)</a></li>
											<li><a href="<%=contextPath %>/product/productList.action?cateGrpCode=K&cIdx=F18" data-gtag-idx="fo_common_gbn_3" data-gtag-label="방한화(120~240mm)" data-category-name="신발">방한화(120~240mm)</a></li>
											<li><a href="<%=contextPath %>/product/productList.action?cateGrpCode=K&cIdx=F19" data-gtag-idx="fo_common_gbn_3" data-gtag-label="슬라이드 (160~210mm)" data-category-name="신발">슬라이드 (160~210mm)</a></li>
					
										
									</ul>
								</div>
								
								
								
								
								
								
								
								
								
								
								
								
								
								
								
									
									
										
										
											<div class="depth">
										
									
									<strong class="tit">의류</strong>
									<ul>
										<li><a href="<%=contextPath %>/product/productList.action?cateGrpCode=K&cIdx=C" data-gtag-idx="fo_common_gbn_3" data-gtag-label="전체보기" data-category-name="의류">전체보기</a></li>											
											<li><a href="<%=contextPath %>/product/productList.action?cateGrpCode=KcIdx=C12" data-gtag-idx="fo_common_gbn_3" data-gtag-label="헤비다운" data-category-name="의류">헤비다운</a></li>
											<li><a href="<%=contextPath %>/product/productList.action?cateGrpCode=K&cIdx=C13" data-gtag-idx="fo_common_gbn_3" data-gtag-label="경량다운" data-category-name="의류">경량다운</a></li>
											<li><a href="<%=contextPath %>/product/productList.action?cateGrpCode=K&cIdx=C14" data-gtag-idx="fo_common_gbn_3" data-gtag-label="스키복" data-category-name="의류">스키복</a></li>
											<li><a href="<%=contextPath %>/product/productList.action?cateGrpCode=K&cIdx=C15" data-gtag-idx="fo_common_gbn_3" data-gtag-label="플리스/덤블/패딩" data-category-name="의류">플리스/덤블/패딩</a></li>
											<li><a href="<%=contextPath %>/product/productList.action?cateGrpCode=K&cIdx=C03" data-gtag-idx="fo_common_gbn_3" data-gtag-label="바람막이/자켓" data-category-name="의류">바람막이/자켓</a></li>								
											<li><a href="<%=contextPath %>/product/productList.action?cateGrpCode=K&cIdx=C16" data-gtag-idx="fo_common_gbn_3" data-gtag-label="맨투맨 세트" data-category-name="의류">맨투맨 세트</a></li>								
											<li><a href="<%=contextPath %>/product/productList.action?cateGrpCode=K&cIdx=C17" data-gtag-idx="fo_common_gbn_3" data-gtag-label="트레이닝 세트" data-category-name="의류">트레이닝 세트</a></li>
											<li><a href="<%=contextPath %>/product/productList.action?cateGrpCode=K&cIdx=C06" data-gtag-idx="fo_common_gbn_3" data-gtag-label="티셔츠" data-category-name="의류">티셔츠</a></li>
											<li><a href="<%=contextPath %>/product/productList.action?cateGrpCode=K&cIdx=C04" data-gtag-idx="fo_common_gbn_3" data-gtag-label="후드티 / 맨투맨" data-category-name="의류">후드티 / 맨투맨</a></li>
											<li><a href="<%=contextPath %>/product/productList.action?cateGrpCode=K&cIdx=C18" data-gtag-idx="fo_common_gbn_3" data-gtag-label="긴바지 / 레깅스" data-category-name="의류">긴바지 / 레깅스</a></li>
											<li><a href="<%=contextPath %>/product/productList.action?cateGrpCode=K&cIdx=C11" data-gtag-idx="fo_common_gbn_3" data-gtag-label="원피스 / 스커트" data-category-name="의류">원피스 / 스커트</a></li>
											<li><a href="<%=contextPath %>/product/productList.action?cateGrpCode=K&cIdx=C19" data-gtag-idx="fo_common_gbn_3" data-gtag-label="홈웨어" data-category-name="의류">홈웨어</a></li>
	
										
											
										
										
									</ul>
								</div>
								
								
								
								
								
								
								
								
								
								
								
								
								
								
								
								
								
								
								
								
								
								
								
								
								
								
								
									
									
										
											<div class="depth g_goods">
										
										
									
									<strong class="tit">용품</strong>
									<ul>
										<li><a href="<%=contextPath %>/product/productList.action?cateGrpCode=K&cIdx=T" data-gtag-idx="fo_common_gbn_3" data-gtag-label="전체보기" data-category-name="용품">전체보기</a></li>																
											<li><a href="<%=contextPath %>/product/productList.action?cateGrpCode=K&cIdx=T06" data-gtag-idx="fo_common_gbn_3" data-gtag-label="신학기 책가방" data-category-name="용품">신학기 책가방</a></li>								
											<li><a href="<%=contextPath %>/product/productList.action?cateGrpCode=K&cIdx=T04" data-gtag-idx="fo_common_gbn_3" data-gtag-label="모자" data-category-name="용품">모자</a></li>
											<li><a href="<%=contextPath %>/product/productList.action?cateGrpCode=K&cIdx=T01" data-gtag-idx="fo_common_gbn_3" data-gtag-label="백팩" data-category-name="용품">백팩</a></li>
											<li><a href="<%=contextPath %>/product/productList.action?cateGrpCode=K&cIdx=T02" data-gtag-idx="fo_common_gbn_3" data-gtag-label="가방" data-category-name="용품">가방</a></li>
											<li><a href="<%=contextPath %>/product/productList.action?cateGrpCode=K&cIdx=T03" data-gtag-idx="fo_common_gbn_3" data-gtag-label="양말" data-category-name="용품">양말</a></li>
											<li><a href="<%=contextPath %>/product/productList.action?cateGrpCode=K&cIdx=T07" data-gtag-idx="fo_common_gbn_3" data-gtag-label="장갑/넥워머" data-category-name="용품">장갑/넥워머</a></li>
											
										
										
									</ul>
								</div>
								
								
								
								
								
								
								
								
								
								
								
								
								
								
								
								<div class="depth">
									<strong class="tit">카테고리</strong>
									<ul class="kids_box">
									
										
											
												 <li>
		                                           	
													<a href="https://www.nbkorea.com/product/productList.action?cateGrpCode=250110&amp;cIdx=1353" data-gtag-idx="fo_common_gbn_3" data-gtag-label="신발" data-category-name="카테고리">신발</a>													
												</li>			 																			
											
											
										
									
										
											
												 <li>
		                                           	
													<a href="https://www.nbkorea.com/product/productList.action?cateGrpCode=250110&amp;cIdx=1354" data-gtag-idx="fo_common_gbn_3" data-gtag-label="의류" data-category-name="카테고리">의류</a>													
												</li>			 																			
											
											
										
									
										
											
												 <li>
		                                           	
													<a href="https://www.nbkorea.com/product/productList.action?cateGrpCode=250110&amp;cIdx=1355" data-gtag-idx="fo_common_gbn_3" data-gtag-label="용품" data-category-name="카테고리">용품</a>													
												</li>			 																			
											
											
										
									
									</ul>
								</div>
							</div>
						</div>
					</li>							
					<!-- // KIDS -->
					
					<!-- NB&amp;YOU -->
					<li class="nav nav-nonecate">
						<a href="/launchingCalendar/list.action" class="menu_tit" data-gtag-idx="fo_common_3_4">런칭캘린더</a>

					</li>
					<!-- //NB&amp;YOU -->
				</ul>
			</div>
			
			<!-- // global_menu -->
			
			<!-- customer -->
			<div class="customer">
				<div class="top_search nav">
					<a href="javascript:;" class="btn_srch" data-gtag-idx="fo_common_4_1">검색</a>
					<div class="category_box" style="display: none;">
						<div class="srch_area srch_area-renewal">
							<span class="sselect_box select_box-srch">
								<select name="prodPart" id="prodPart">
									<option value="A">전체</option>
									<option value="M">MEN</option>
									<option value="W">WOMEN</option>
									<option value="K">KIDS</option>
								</select>
							</span>
							<input type="text" name="schWord" id="schWord" class="ip_text ip_text-srch" title="검색어 입력" placeholder="상품명 혹은 스타일코드 검색" autocomplete="off">
							<button type="submit" class="btn_ty_bface sm" id="btnProdSch" data-gtag-idx="fo_common_5_1" data-gtag-ref="schWord">검색</button>
							
							<div class="srch_list_area" style="display: none;">
							    <div class="list_box list_box01">
							        <p class="list_tit">최근 검색어<a href="javascript:;" id="btnRecentWordRemoveAll">전체 기록 삭제</a></p>
							        <div class="srch_list">
                                    	<div class="srch_list_inner" id="recentSearch"><ul><li><a class="srch_txt" href="javascript:;" name="btnRecentWordSearch" data-word="NB 쿠셔닝 슬라이드 / SD1501BK2" data-gtag-idx="fo_common_5_1" data-gtag-label="NB 쿠셔닝 슬라이드 / SD1501BK2"><span>NB 쿠셔닝 슬라이드 / SD1501BK2</span></a><span class="del" href="javascript:;" name="btnRecentWordRemove" data-key="0"><img src="https://image.nbkorea.com/NBRB_PC/common/btn_delete_15x15.jpg"></span></li><li><a class="srch_txt" href="javascript:;" name="btnRecentWordSearch" data-word="NB 쿠셔닝 슬라이드 / SD1501BE2" data-gtag-idx="fo_common_5_1" data-gtag-label="NB 쿠셔닝 슬라이드 / SD1501BE2"><span>NB 쿠셔닝 슬라이드 / SD1501BE2</span></a><span class="del" href="javascript:;" name="btnRecentWordRemove" data-key="1"><img src="https://image.nbkorea.com/NBRB_PC/common/btn_delete_15x15.jpg"></span></li><li><a class="srch_txt" href="javascript:;" name="btnRecentWordSearch" data-word="NB 쿠셔닝 슬라이드" data-gtag-idx="fo_common_5_1" data-gtag-label="NB 쿠셔닝 슬라이드"><span>NB 쿠셔닝 슬라이드</span></a><span class="del" href="javascript:;" name="btnRecentWordRemove" data-key="2"><img src="https://image.nbkorea.com/NBRB_PC/common/btn_delete_15x15.jpg"></span></li><li><a class="srch_txt" href="javascript:;" name="btnRecentWordSearch" data-word="Pouch 2-WAY Backpack" data-gtag-idx="fo_common_5_1" data-gtag-label="Pouch 2-WAY Backpack"><span>Pouch 2-WAY Backpack</span></a><span class="del" href="javascript:;" name="btnRecentWordRemove" data-key="3"><img src="https://image.nbkorea.com/NBRB_PC/common/btn_delete_15x15.jpg"></span></li><li><a class="srch_txt" href="javascript:;" name="btnRecentWordSearch" data-word="TREE 코듀로이 멜빵 스커트" data-gtag-idx="fo_common_5_1" data-gtag-label="TREE 코듀로이 멜빵 스커트"><span>TREE 코듀로이 멜빵 스커트</span></a><span class="del" href="javascript:;" name="btnRecentWordRemove" data-key="4"><img src="https://image.nbkorea.com/NBRB_PC/common/btn_delete_15x15.jpg"></span></li><li><a class="srch_txt" href="javascript:;" name="btnRecentWordSearch" data-word="[뉴발란스 키즈 X 이피] 스웻셔츠 스커트 세트" data-gtag-idx="fo_common_5_1" data-gtag-label="[뉴발란스 키즈 X 이피] 스웻셔츠 스커트 세트"><span>[뉴발란스 키즈 X 이피] 스웻셔츠 스커트 세트</span></a><span class="del" href="javascript:;" name="btnRecentWordRemove" data-key="5"><img src="https://image.nbkorea.com/NBRB_PC/common/btn_delete_15x15.jpg"></span></li><li><a class="srch_txt" href="javascript:;" name="btnRecentWordSearch" data-word="패딩스커트" data-gtag-idx="fo_common_5_1" data-gtag-label="패딩스커트"><span>패딩스커트</span></a><span class="del" href="javascript:;" name="btnRecentWordRemove" data-key="6"><img src="https://image.nbkorea.com/NBRB_PC/common/btn_delete_15x15.jpg"></span></li><li><a class="srch_txt" href="javascript:;" name="btnRecentWordSearch" data-word="NB Turning Skirt_W플레어" data-gtag-idx="fo_common_5_1" data-gtag-label="NB Turning Skirt_W플레어"><span>NB Turning Skirt_W플레어</span></a><span class="del" href="javascript:;" name="btnRecentWordRemove" data-key="7"><img src="https://image.nbkorea.com/NBRB_PC/common/btn_delete_15x15.jpg"></span></li><li><a class="srch_txt" href="javascript:;" name="btnRecentWordSearch" data-word="NB Turning Skirt_W랩플리츠" data-gtag-idx="fo_common_5_1" data-gtag-label="NB Turning Skirt_W랩플리츠"><span>NB Turning Skirt_W랩플리츠</span></a><span class="del" href="javascript:;" name="btnRecentWordRemove" data-key="8"><img src="https://image.nbkorea.com/NBRB_PC/common/btn_delete_15x15.jpg"></span></li><li><a class="srch_txt" href="javascript:;" name="btnRecentWordSearch" data-word="NB Turning Skirt_W에센셜플리츠" data-gtag-idx="fo_common_5_1" data-gtag-label="NB Turning Skirt_W에센셜플리츠"><span>NB Turning Skirt_W에센셜플리츠</span></a><span class="del" href="javascript:;" name="btnRecentWordRemove" data-key="9"><img src="https://image.nbkorea.com/NBRB_PC/common/btn_delete_15x15.jpg"></span></li></ul></div>
							        </div>
							    </div>
							    <div class="list_box list_box02">
							        <p class="list_tit">추천 검색어</p>
							        <div class="srch_list">
							            <ul>
							            	
											
												
											
												
												<li>
												
													
													
														<a href="https://www.nbkorea.com/product/searchResult.action?schWord=NB%25ED%258C%25A8%25EB%2594%25A9" data-gtag-idx="fo_common_6_1" data-gtag-label="패딩">1. 패딩</a>
													
												
												</li>
												
												
											
												
											
												
												<li>
												
													
													
														<a href="https://www.nbkorea.com/product/searchResult.action?schWord=%25EB%25A1%25B1%25ED%258C%25A8%25EB%2594%25A9" data-gtag-idx="fo_common_6_1" data-gtag-label="롱패딩">2. 롱패딩</a>
													
												
												</li>
												
												
											
												
												<li>
												
													
													
														<a href="https://www.nbkorea.com/product/searchResult.action?schWord=%25EC%2588%258F%25ED%258C%25A8%25EB%2594%25A9" data-gtag-idx="fo_common_6_1" data-gtag-label="숏패딩">3. 숏패딩</a>
													
												
												</li>
												
												
											
												
											
												
											
												
											
												
												<li>
												
													
													
														<a href="https://www.nbkorea.com/product/searchResult.action?schWord=%25EB%2589%25B4%25EB%25B0%259C%25EB%259E%2580%25EC%258A%25A4%2520530" data-gtag-idx="fo_common_6_1" data-gtag-label="뉴발란스 530">4. 뉴발란스 530</a>
													
												
												</li>
												
												
											
												
												<li>
												
													
													
														<a href="https://www.nbkorea.com/product/searchResult.action?schWord=fwFleece" data-gtag-idx="fo_common_6_1" data-gtag-label="기모&amp;플리스">5. 기모&amp;플리스</a>
													
												
												</li>
												
												
											
												
											
												
											
												
											
											
							            </ul>
							        </div>
							    </div>
							</div>
							
						</div>
						<div class="keyword" id="keyword">
						
						
							
						
							
							<span>
							
								
								
									<a href="https://www.nbkorea.com/product/searchResult.action?schWord=NB%25ED%258C%25A8%25EB%2594%25A9" data-gtag-idx="fo_common_6_1" data-gtag-label="패딩">패딩</a>
								
							
							</span>
							
							
						
							
						
							
							<span>
							
								
								
									<a href="https://www.nbkorea.com/product/searchResult.action?schWord=%25EB%25A1%25B1%25ED%258C%25A8%25EB%2594%25A9" data-gtag-idx="fo_common_6_1" data-gtag-label="롱패딩">롱패딩</a>
								
							
							</span>
							
							
						
							
							<span>
							
								
								
									<a href="https://www.nbkorea.com/product/searchResult.action?schWord=%25EC%2588%258F%25ED%258C%25A8%25EB%2594%25A9" data-gtag-idx="fo_common_6_1" data-gtag-label="숏패딩">숏패딩</a>
								
							
							</span>
							
							
						
							
						
							
						
							
						
							
							<span>
							
								
								
									<a href="https://www.nbkorea.com/product/searchResult.action?schWord=%25EB%2589%25B4%25EB%25B0%259C%25EB%259E%2580%25EC%258A%25A4%2520530" data-gtag-idx="fo_common_6_1" data-gtag-label="뉴발란스 530">뉴발란스 530</a>
								
							
							</span>
							
							
						
							
							<span>
							
								
								
									<a href="https://www.nbkorea.com/product/searchResult.action?schWord=fwFleece" data-gtag-idx="fo_common_6_1" data-gtag-label="기모&amp;플리스">기모&amp;플리스</a>
								
							
							</span>
							
							
						
							
						
							
						
							
													
						</div>
						<div class="collection" id="collection">
							<ul>
							
								
								<li><a href="https://www.nbkorea.com/etc/collection.action?collectionIdx=4837" data-collection="4837" data-gtag-idx="fo_common_7_1" data-gtag-label="YUNA's DOWN"><img src="https://image.nbkorea.com/NBRB_Collection/20221024/NB20221024134109632001.jpg" alt="" onerror="this.src='https://image.nbkorea.com/NBRB_PC/dummy/img_gnb01.png'"><span>YUNA's DOWN</span></a></li>
								
							
								
							
								
								<li><a href="https://www.nbkorea.com/etc/collection.action?collectionIdx=4835" data-collection="4835" data-gtag-idx="fo_common_7_1" data-gtag-label="NB DOWN COLLECTION"><img src="https://image.nbkorea.com/NBRB_Collection/20221018/NB20221018131631582001.jpg" alt="" onerror="this.src='https://image.nbkorea.com/NBRB_PC/dummy/img_gnb01.png'"><span>NB DOWN COLLECTION</span></a></li>
								
							
								
							
								
							
								
								<li><a href="https://www.nbkorea.com/etc/collection.action?collectionIdx=4821" data-collection="4821" data-gtag-idx="fo_common_7_1" data-gtag-label="NBSC Re-stock"><img src="https://image.nbkorea.com/NBRB_Collection/20221014/NB20221014154304779001.jpg" alt="" onerror="this.src='https://image.nbkorea.com/NBRB_PC/dummy/img_gnb01.png'"><span>NBSC Re-stock</span></a></li>
								
							
								
								<li><a href="https://www.nbkorea.com/etc/collection.action?collectionIdx=4867" data-collection="4867" data-gtag-idx="fo_common_7_1" data-gtag-label="NB KIDS 22FW Layer.1 2nd Drop"><img src="https://image.nbkorea.com/NBRB_Collection/20221028/NB20221028101952810001.jpg" alt="" onerror="this.src='https://image.nbkorea.com/NBRB_PC/dummy/img_gnb01.png'"><span>NB KIDS 22FW Layer.1 2nd Drop</span></a></li>
								
							
								
								<li><a href="https://www.nbkorea.com/etc/collection.action?collectionIdx=4863" data-collection="4863" data-gtag-idx="fo_common_7_1" data-gtag-label="NB KIDS 22FW NEWKIMO PREMIUM DOWN"><img src="https://image.nbkorea.com/NBRB_Collection/20221110/NB20221110100549538001.jpg" alt="" onerror="this.src='https://image.nbkorea.com/NBRB_PC/dummy/img_gnb01.png'"><span>NB KIDS 22FW NEWKIMO PREMIUM DOWN</span></a></li>
								
							
								
							
								
							
								
							
								
							
								
							
							</ul>
						</div>
					</div>
				</div>
				<div class="mymenu">
					<s:authorize access="isAuthenticated()">
						<a href="/newbalance/my/main.action" data-gtag-idx="fo_common_4_2">마이페이지</a>
					</s:authorize>
					 <s:authorize access="!isAuthenticated()">
						<a href="/newbalance/customer/login.action" data-gtag-idx="fo_common_4_4">로그인</a>
						<a href="/newbalance/customer/joinn.action" data-gtag-idx="fo_common_4_5">회원가입</a>
					</s:authorize>
							
							
							
						
						
					
				</div>
				<div class="cart none_count">
					<a href="/newbalance/my/cartList.action" data-gtag-idx="fo_common_4_3">
						<span class="blind"></span>
						<c:if test="${cartCount != 0 && not empty cartCount}">
							<span class="count">${cartCount}</span>					
						</c:if>
					</a>
				</div>
			</div>
			<!-- // customer -->
		</div>
	</div>
	<!-- // gnb -->
</div>
</div>
<div class="dimm_gnb" style="display: none;"></div>
<script type="text/javascript">

/* $(function(){
	debugger;
var hUserCode = "${sessionScope.member.getUserCode()}";
	
	if(hUserCode != "" && hUserCode != null){
		
		
		$.ajax({
	           url : '/newbalance/my/getCartCount.ajx',
	           type : 'POST',   
	           async : false,
	           dataType : 'json',
	           cache : false,
	           data : {
	              "userCode" : hUserCode
	           },        
	           success : function(data){	
	        	   console.log(data.result);
	           },
	           error: function(data){
	               alert("cart count 에러가 발생했습니다.");
	           }
	        });
	}
}) */


	var h_offset = $(".header").offset().top;
	$(window).on('scroll',function(){
		var w_offset = $(window).scrollTop();
		if (!$(".wrap").hasClass("detail")) {
			if (w_offset > h_offset) {
				$(".header").removeClass("on")
				$(".container").css({
					"padding-top": "110px"
				})
			} else {
				$(".header").addClass("on");
				$(".container").css({
					"padding-top": "0"
				})
			}
		}
	});
</script>
		
		

<script src="https://cdn.devy.kr/dist/vue-2.6.10/vue.min.js"></script>
<script src="https://cdn.devy.kr/dist/element-ui-2.1.3/lib/index.js"></script>
<script src="https://cdn.devy.kr/dist/jquery-validation-1.17.0/jquery.validate.min.js"></script>
<script type="text/javascript" charset="UTF-8" src="//t1.daumcdn.net/adfit/static/kp.js"></script>
<script type="text/javascript">
 	window.cremaAsyncInit = function() {
		 if('' != null){
			 crema.init('', '');	 
		 }else{
			 crema.init(null, null);
		 }
	}  
</script>



<script >
function hasJqueryObject( elem ){return elem.length > 0;}
var app = {};
window.onload=function(){ init(); };
$(window).bind({
	'scroll.listNone' : function (){
		//if( hasJqueryObject( $("body").find(".main") ) ) parallax.moveParallax();
		if( hasJqueryObject( $("body").find(".detail .detail_wrap") ) ) detailFixed();
	},
	'resize' : function(){

		if( hasJqueryObject( $("body").find(".detail .detail_wrap") ) ) detailFixed();
	}
});
//$(document).ready(function(){ initLoad (); });
function init()
{
	app.$body = $("body");
	if( hasJqueryObject( app.$body.find(".main") ) ) parallax.settings(); parallax.moveParallax(); navigation.gnb();
	if( hasJqueryObject( app.$body.find(".sub_main .main_visual") ) ) initMainRolling();
	if( hasJqueryObject( app.$body.find(".nbtag .tag_list") ) ) initNbTag();
	/*if( hasJqueryObject( app.$body.find(".nbpeople") ) ) initBtnSlide( '.nbpeople .img_box', 5 );*/
	if( hasJqueryObject( app.$body.find(".pr_livefit") ) ) initBtnSlide( '.pr_livefit .img_box', 2 );
	if( hasJqueryObject( app.$body.find(".nbpp_bottom") ) ) initBtnSlide( '.nbpp_bottom .img_box', 1 );
	if( hasJqueryObject( app.$body.find(".exp_tab") ) ) initTabList();
	if( hasJqueryObject( app.$body.find(".detail .detail_wrap") ) ) detailFixed();
	if( hasJqueryObject( app.$body.find(".placeholder") ) ) initPlachehoder();
	if( hasJqueryObject( app.$body.find(".filter_title") ) ) filter ();
	if( hasJqueryObject( app.$body.find(".gathering") ) ) gatClick ();
	if( hasJqueryObject( app.$body.find(".goods_com") ) ) compareChk ();
	if( hasJqueryObject( app.$body.find(".goods_list02") ) ) quickV ();
	if( hasJqueryObject( app.$body.find(".inq_list") ) ) initToggleList ('.inq_list');
	if( hasJqueryObject( app.$body.find(".qna_list") ) ) initToggleList ('.qna_list');
	if( hasJqueryObject( app.$body.find(".pay_opt") ) ) payOpt ();
	if( hasJqueryObject( app.$body.find(".gallery") ) ) initBtnSlide( '.gallery .img_box', 1 );
	if( hasJqueryObject( app.$body.find(".parcel_company") ) ) parcelOpt ();
	if( hasJqueryObject( app.$body.find(".cal_noti") ) ) calNoti ();
	if( hasJqueryObject( app.$body.find(".bfgoods_list") ) ) quickVEvt ("bfgoods_list");
	if( hasJqueryObject( app.$body.find(".mwgoods_list") ) ) quickVEvt ("mwgoods_list");
	if( hasJqueryObject( app.$body.find(".photoR") ) ) initBtnSlide( '.photoR .img_box', 1 ); //20190903 추가
	//if( hasJqueryObject( app.$body.find(".prdSwiper"))) prodSwiper('.prdSwiper'); //20210309추가
	if (hasJqueryObject(app.$body.find(".scroll_slide"))) slideSwiper('.scroll_slide');
	if (hasJqueryObject(app.$body.find(".productList"))) listHover(); //20210721 추가
}


/* common - header */
/* 20210401 수정 :: S */
var navigation = {
	gnb: function () { // global navigation
		var initMenu = $('.header .gnb .nav');
		initMenu.each(function () {
			$(this).mouseenter(function () {
				if ($(this).hasClass("nav-nonecate")) {
					initMenu.find('.category_box').hide();
					initMenu.find('.current').removeClass('current');
					$('.dimm_gnb').hide();
				} else {
					initMenu.find('.category_box').hide();
					initMenu.find('.current').removeClass('current');
					$(this).children('a').addClass('current');
					$('> .category_box', $(this)).show();
					$('.dimm_gnb').show();
				}
			});
		});
		$('.header .gnb > .inner').mouseleave(function () {
			initMenu.find('.current').removeClass('current');
			$('.nav > .category_box', $(this)).hide();
			$('.dimm_gnb').hide();
		});
	}
}
/* 20210401 수정 :: E */

/* NbTag Tab  =============================================================== */
function initNbTag(){
	var tagList = $('.tag_list li');
	tagList.each(function(n){
		$(this).find('a').click(function(){
			tagList.find('a').removeClass('active');
			$(this).addClass('active');
			//$(".tag_prod ul").removeClass('active');
			//$(".tag_prod ul").eq(n).addClass('active');
		});
	});
}

/* Main rolling  =============================================================== */
function initMainRolling(){
	var slider_01 = $('.main_visual ul').bxSlider({
			auto: true,autoControls: true, mode:'fade'
		});

	$(document).on('click','.bx-next, .bx-prev',function() {
		slider_01.stopAuto();
		slider_01.startAuto();
	});
	$(document).on('mouseover','.bx-pager, #bx-pager1',function() {
		slider_01.stopAuto();
		slider_01.startAuto();
	});
}



/* common rolling  =============================================================== */
function initBtnSlide( slideWrap, count ){

	var mySwiper = new Swiper( slideWrap,{
		paginationClickable: true,
		slidesPerView: count,
		simulateTouch: false,
	})
	var listbox = $(slideWrap).closest('.btn_slide');
	var thislist = $(slideWrap).find('.swiper-slide');
	var idx = thislist.length;

	moving();
	listbox.find('.btn').on('click', function(e){
		if ($(this).hasClass('prev')){
			e.preventDefault()
			mySwiper.swipePrev()
		} else if($(this).hasClass('next')){
			e.preventDefault()
			mySwiper.swipeNext()
		}
		moving();
	})
	function moving(){
		if(thislist.eq(0).hasClass('swiper-slide-active')){listbox.find('.prev').addClass('hide'); }else{ listbox.find('.prev').removeClass('hide');};
		if(thislist.eq(idx-count).hasClass('swiper-slide-active')){ listbox.find('.next').addClass('hide'); }else{ listbox.find('.next').removeClass('hide');};
	}
}

/* popSwiper - 슬라이드 총개수 변동없을때 =============================================================== 20210708 추가*/
/* popSwiper - 슬라이드 총개수 변동없을때 =============================================================== 20210709 추가*/
var popSwipe;
function popSwiper(popSlide,perNum) {
	popSwipe = new Swiper(popSlide, {
		slidesPerView: perNum,
		calculateHeight:true,
		freeModeFluid:true,
		scrollbar: {
			container: '.swiper-scrollbar',
		},
	});
}

function popSwiperReInit(){
	popSwipe.reInit();
}

/* tab list  =============================================================== */
function initTabList(){
	var tabList = $('.exp_tab .exp_list li');
	tabList.each(function(n){
		$(this).find('a').click(function(){
			var tabCont = $(this).closest('.exp_list').next('.tab_cont').find('.cont');
			$(this).parent().addClass('active').siblings().removeClass('active');
			tabCont.eq(n).addClass('active').siblings().removeClass('active');
		});
	});
}

/* initPlachehoder  =============================================================== */
function initPlachehoder(){
	var focusForm = $('.placeholder').find('.ip_text');
	var focusForm2 = $('.placeholder').find('.textarea');

	function placeHolder (focusIp){
		focusIp.focus(function(){	$(this).prev('.assi').hide();	});
		focusIp.focusout(function(){
			$(this).val() ? $(this).prev('.assi').hide() : $(this).prev('.assi').show();
		});
		$(focusIp).prev('.assi').click(function(){
			$(this).hide();
			$(this).next('.ip_text').focus();
		});
	}
	placeHolder(focusForm);
	placeHolder(focusForm2);
}

/* initToggleList  =============================================================== */
function initToggleList(toggleWrap){
	$(toggleWrap).find('.row_q .ttl').click(function(){
		if ($(this).parents('li').hasClass('open')) {
			$(this).parents(toggleWrap).find('.open .row_a').slideUp(300, function() {
				$(this).parents('.open').removeClass('open');
			});
		}else{
			$(this).parents(toggleWrap).find('.open .row_a').slideUp(300, function() {
					$(this).parents('.open').removeClass('open');
			});
			$(this).parents('li').find('.row_a').slideDown(300);
			$(this).parents('li').addClass('open');
		}
	});
}

/* main -parallax =============================================================== */
var WINDOW = $(window);
var windowH = WINDOW.height();
var arrSectionOffset = new Array(8);
var parallax = {
	settings : function(){
		var parallax01 = $('.parallax01');
		var parallax02 = $('.parallax02');
		var parallax03 = $('.parallax03');
		var parallax04 = $('.parallax04');
		var parallax05 = $('.parallax05');
		//var parallax06 = $('.parallax06');

		if(parallax01.length >0 ){
			arrSectionOffset[0] = parallax01.offset().top;
		}
		if(parallax02.length >0 ){
			arrSectionOffset[1] = parallax02.offset().top;
		}
		if(parallax03.length >0 ){
			arrSectionOffset[2] = parallax03.offset().top;
		}
		if(parallax04.length >0 ){
			arrSectionOffset[3] = parallax04.offset().top;
		}
		if(parallax05.length >0 ){
			arrSectionOffset[4] = parallax05.offset().top;
		}
		//arrSectionOffset[5] = parallax06.offset().top;
	},
	moveParallax : function () {
		var intScrollTop = WINDOW.scrollTop();
		var gnbH = $(".header").height();
		var windowHalf  = windowH/2

		/*parallax01*/
		if(intScrollTop > arrSectionOffset[0]-windowHalf-gnbH  ) {
			if(!$('.parallax01 div').hasClass('on')){
				$('.parallax01 .pro_img').addClass('on');
				$('.parallax01 .pro_txt').addClass('on');
			}
		}
		else if(intScrollTop < arrSectionOffset[0]-windowHalf-gnbH ){
			if($('.parallax01 div').hasClass('on')){
				$('.parallax01 .pro_img').removeClass('on');
				$('.parallax01 .pro_txt').removeClass('on');
			}
		}
		/*parallax02*/
		if(intScrollTop > arrSectionOffset[1]-windowHalf-gnbH) {
			if(!$('.parallax02 div').hasClass('on')){
				$('.parallax02 .pro_img').addClass('on');
				$('.parallax02 .pro_txt').addClass('on');
			}
		}
		else if(intScrollTop < arrSectionOffset[1]-windowHalf-gnbH ){
			if($('.parallax02 div').hasClass('on')){
				$('.parallax02 .pro_img').removeClass('on');
				$('.parallax02 .pro_txt').removeClass('on');
			}
		}
		/*parallax03*/
		if(intScrollTop > arrSectionOffset[2]-windowHalf-gnbH) {
			var i = 0;
			var setBox = setInterval(function(){
				var target = $(".parallax03");
				if(target.offset().top < (intScrollTop+windowH)){
					$(".parallax03 div:eq("+i+")").addClass("up");
					i++;
				}
			}, 100);
		}
		else if(intScrollTop < arrSectionOffset[2]-windowHalf-gnbH ){
			$(".parallax03 div").removeClass("up");
		}
		/*parallax04*/
		var targetFlow = $(".parallax04 p");
		var resetPos = WINDOW.width();
		var maxPos = -(targetFlow.width());
		var init = resetPos*0.3;
		if(intScrollTop > arrSectionOffset[3]-windowH-gnbH) {
			if(!$(".parallax04 p").hasClass('on')){
				targetFlow.addClass('on')
				flowBox = setInterval(function(){
					/* proccess */
					var val = targetFlow.css('left').replace('px','') - 2;
					if(val < maxPos){
						val = resetPos;
					}
					targetFlow.css('left', val);
				}, 10);
			}
		}else if(intScrollTop < arrSectionOffset[3]-windowH-gnbH){
			if($(".parallax04 p").hasClass('on')){
				targetFlow.removeClass('on');
				clearInterval(flowBox);
				/* reset */
				targetFlow.css('left', init);
			}
		}
		/*parallax05*/
		if(intScrollTop > arrSectionOffset[4]-windowH-gnbH  ) {
			if(!$('.parallax05 .p_video').hasClass('up')){
				$('.parallax05 .p_video').addClass('up');
				/*룩샵 비디오 재생*/
				var videocontrolStart = document.getElementById("lookShopVideo");
				if(videocontrolStart) {
					videocontrolStart.play();
				}
			}
		}
		else if(intScrollTop < arrSectionOffset[4]-windowH-gnbH ){
			if($('.parallax05 .p_video').hasClass('up')){
				$('.parallax05 .p_video').removeClass('up');
				/*룩샵 비디오 정지*/
				var videocontrolStop = document.getElementById("lookShopVideo");
				if(videocontrolStop) {
					videocontrolStop.pause();
				}
			}
		}
		if(intScrollTop > arrSectionOffset[4]-windowHalf-gnbH  ) {
			if(!$('.parallax05 .p_list').hasClass('up')){
				$('.parallax05 .p_list').addClass('up');
			}
		}
		else if(intScrollTop < arrSectionOffset[4]-windowHalf-gnbH ){
			if($('.parallax05 .p_list').hasClass('up')){
				$('.parallax05 .p_list').removeClass('up');
			}
		}

		/*parallax06*/
		if(intScrollTop > arrSectionOffset[5]-windowHalf ) {
			var k = intScrollTop -(arrSectionOffset[5]-windowHalf);
			if (k<251){
				$(".parallax06 .sharp1").css({'margin-left':k});
				$(".parallax06 .sharp2").css({'margin-right':k});
			}else if (k<0){
				$(".parallax06 .sharp1").css({'margin-left':0});
				$(".parallax06 .sharp2").css({'margin-right':0});
			}else{
				$(".parallax06 .sharp1").css({'margin-left':250});
				$(".parallax06 .sharp2").css({'margin-right':250});
			}
		}else if(intScrollTop < arrSectionOffset[5]-windowHalf ){
			$(".parallax06 .sharp1").css({'margin-left':0});
			$(".parallax06 .sharp2").css({'margin-right':0});
		}
	}
}



/* product - list =============================================================== */
// filter
function filter () {
	var title = $('.filter_title');
	var filterBox = $('.filter_group');
	filterBox.hide();

	title.find('li a').each(function(i) {
		$(this).on('click focusein', function() {
			if ($(this).parent('li').hasClass('on')) {
				title.find('li').removeClass('on');
				filterBox.hide();
				filterBox.find('> div').removeClass('on');
			} else {
				title.find('li').removeClass('on');
				filterBox.find('> div').removeClass('on');
				filterBox.show();
				$(this).parent('li').addClass('on');
				filterBox.find('> div').eq(i).addClass('on');
			}
		});
	});
}

// gathering
function gatClick () {
	$('.gathering ul > li > a').on('click', function() {
		$('.gathering ul > li').removeClass('on');
		$(this).parent('li').addClass('on');
	});
}

// 비교하기 토글
function compareChk () {
	$('.goods_com .btn_ty_compare').on('click', function() {
		$(this).toggleClass('on');
		$('.inner_box').toggleClass('on');
	});
}

// quick view
function quickV () {
	var list = $('.goods_list02');
	var qView = list.find('.quick_view.on');

	list.find('li').on('mouseover', function() {
		$('.pro_area').removeClass('on');
		$('.quick_view').removeClass('on');
		$(this).find('.pro_area').addClass('on');
		$(this).find('.quick_view').addClass('on');
	});
	list.find('li').on('mouseout', function() {
		$('.pro_area').removeClass('on');
		$('.quick_view').removeClass('on');;
	});
}

// black friday - quick view
function quickVBf () {
	var list = $('.bfgoods_list');
	var qView = list.find('.quick_view.on');

	list.find('li').on('mouseover', function() {
		$('.pro_area').removeClass('on');
		$('.quick_view').removeClass('on');
		$(this).find('.pro_area').addClass('on');
		$(this).find('.quick_view').addClass('on');
	});
	list.find('li').on('mouseout', function() {
		$('.pro_area').removeClass('on');
		$('.quick_view').removeClass('on');;
	});
}

// event - quick view
function quickVEvt (eventProdList) {
	var list = $('.' + eventProdList);
	var qView = list.find('.quick_view.on');

	list.find('li').on('mouseover', function() {
		$('.pro_area').removeClass('on');
		$('.quick_view').removeClass('on');
		$(this).find('.pro_area').addClass('on');
		$(this).find('.quick_view').addClass('on');
	});
	list.find('li').on('mouseout', function() {
		$('.pro_area').removeClass('on');
		$('.quick_view').removeClass('on');;
	});
}

/* payment =============================================================== */
// 결제 방법 라디오 버튼 선택 시, 내용 보기
function payOpt (i) {
	var list = $('.pay_opt input');
	var box = $('.pay_option_group > div');

	list.each(function(i) {
		$(this).on('click', function() {
			box.removeClass('on');
			box.eq(i).addClass('on');
		});
	});
}

/* my =============================================================== */
// 반송 정보 입력란 - 택배사 라디오버튼 선택
function parcelOpt () {
	var box = $('.parcel_company');
	var radioCh = $('.parcel_company .chk input');
	var radioNum = radioCh.length;

	radioCh.each(function(numCh) {
		$(this).on('click', function() {
			if ($(this).index(numCh)) {
				box.find('.select_box').removeClass('disabled');
				box.find('select').removeAttr('disabled');
			} else {
				box.find('.select_box').addClass('disabled');
				box.find('select').attr('disabled','');
			}
		});
	});
}

/* NB 런칭 캘린더 =============================================================== */
// 캘린더 알림 - 체크박스 버튼 선택 시, 텍스트&이미지 교체
function calNoti () {
	$('.cal_noti . input').on('click', function() {
		if ($('.cal_noti . input').prop('checked')) {
			$('.cal_noti .top_box').addClass('on');
			$('.cal_noti .top_box p').html('알림취소 시 <span class="en">NB</span> 런칭캘린더에 등록되는<br />신규 상품과 기획전에 대한 알림이 제공되지 않습니다.');
			$('.cal_noti . label').text('캘린더 알림취소');
		} else {
			$('.cal_noti .top_box').removeClass('on');
			$('.cal_noti .top_box p').html('<span class="en">NB</span> 런칭캘린더에 등록되는<br />신규 상품과 기획전에 대한 알림을 받을 수 있습니다.');
			$('.cal_noti . label').text('캘린더 알림받기');
		}
	});
}

/* =============================================================== */
;(function($){
    $(function () {
        //ie9 placeholder
        isPlaceholder = ('placeholder' in document.createElement('input'));
        if (!isPlaceholder) {
            $("[placeholder]").focus(function () {
                if ($(this).val() == $(this).attr("placeholder")) $(this).val("").css('color','#141414');
            }).blur(function () {
                if ($(this).val() == "") $(this).val($(this).attr("placeholder")).css('color','#777');
            }).blur();
            $("[placeholder]").parents("form").submit(function () {
                $(this).find('[placeholder]').each(function() {
                    if ($(this).val() == $(this).attr("placeholder")) {
                        $(this).val("");
                        //console.log("입력값이 placeholder값과 같습니다.");
                    }
                });
            });
        }
        //my > 사용가능매장 || 펼쳐보기
        $(".btn_store_use").click(function(){
            if($(".icon_arrow").hasClass("on")){
                $(".list_store_use").removeClass("on");
                $(".icon_arrow").removeClass("on");
            }else{
                $(".list_store_use").addClass("on");
                $(".icon_arrow").addClass("on");
            }
        });
        //su > 세탁 및 손질 방법 안내 || 페이지 앵커
        $(".info_trim_shoes .btn_list li").mouseup(function(){
            setTimeout(function(){
                $(window).scrollTop($(window).scrollTop()-110)
            },10)
        })
    });
})(jQuery);
//ie checkbox radio bugfix
$(window).load(function(){
    var agent = navigator.userAgent.toLowerCase();
    if ( (navigator.appName == 'Netscape' && agent.indexOf('trident') != -1) || (agent.indexOf("msie") != -1)) {
        $("input[type='checkbox']+label, input[type='radio']+label").each(function(){
            var str = $(this).html();
            $(this).html(str);
        });
    }
});
//couponpopup 20180918			
function wrapWindowByMask(){
	var maskHeight = $(document).height();
	var maskWidth = $(window).width();

	$('.coupondimm').css({'width':maskWidth,'height':maskHeight});

	$('.coupondimm').fadeIn();

	var left = ( $(window).scrollLeft() + ( $(window).width() - $('.coupon_wrap').width()) / 2 );
	var top = ( $(window).scrollTop() + ( $(window).height() - $('.coupon_wrap').height()) / 2 );

	$('.coupon_wrap').css({'left':left,'top':top, 'position':'absolute'});
	$('.coupon_wrap').show();
}

$(document).ready(function(){
	$('.open').click(function(e){
		e.preventDefault();
		wrapWindowByMask();
	});

	$('.coupon_wrap .close').click(function (e) {
		e.preventDefault();
		$('.coupondimm, .coupon_wrap').hide();
	});
});

/* slide swiper =============================================================== 20220224 수정*/
function slideSwiper(scrollSlide) {
	$(scrollSlide + ".swiper-container").each(function (index, element) {
		var $this = $(this);
		$this.addClass('instanceScroll-' + index);
		var eachSlide = '.instanceScroll-' + index;
		var slideLength = $(eachSlide + " .swiper-slide li").length;
		var mgLeft = 0;
		var mgNum = 0;
		if (slideLength > 2) {
			mgLeft = $(eachSlide + " .swiper-slide li+li").css("margin-left");
			mgNum = mgLeft.replace(/[^0-9]/g, "");
		}
		var slideWidth = $(eachSlide + " .swiper-slide li").width();
		var rSlideWidth = slideWidth * slideLength + (mgNum * (slideLength - 1)); 
		var eachWidth = $(eachSlide).width();
		if (rSlideWidth < eachWidth) {
			$(eachSlide + ' .swiper-scrollbar').hide();
			$(eachSlide + ' .swiper-slide').parent().removeAttr('style').addClass('noScroll clearfix');
			//슬라이드 사이즈 다시구하기
			$(eachSlide + ".swiper-slide > li").css("width","");
			slideWidth = $(eachSlide + " .swiper-slide li").width();
		}				
		$(eachSlide + " .swiper-slide li").css("width", slideWidth + "px");
		$(eachSlide + " .swiper-slide").css("white-space", "nowrap");
		var swiper = new Swiper('.instanceScroll-' + index, {
			scrollContainer: true,
			scrollbar: {
				container: '.instanceScroll-' + index + ' .swiper-scrollbar'
			},
		})
	});
}

/* slide swiper =============================================================== 20210811 수정*/
var colorSwiper = new Array();
function prodSwiper(prodSlide) {
    colorSwiper.length=0;
    
    $(prodSlide).each(function (index) {        
        var $this = $(this);
        $this.addClass('instance-' + index);
        var eachSlide = '.instance-' + index;
        var eachSlideSwiper = '.instance-' + index + ' .swiper-container';

        // 스와이퍼 갯수에 따른 옵션 담기
        var swiperOption={};
        if($(eachSlide).find(".swiper-slide").length < 7){
            swiperOption={
                slidesPerView: 6,
                spaceBetween: 20,
                simulateTouch:false,
            }
            $this.find(".btn").hide();// 슬라이드 갯수가 7개 미만일 경우 버튼 숨기기  
        }else{
            swiperOption ={
                slidesPerView: 6,
                spaceBetween: 20,
                loop: true,
            }
			$this.find(".btn").show();
        }
        
        // colorSwiper 배열에 스와이퍼 객체 만들면서 넣기
        colorSwiper.push(new Swiper(eachSlideSwiper, swiperOption));        
        
        // 버튼 클릭시 부모의 클래스 이름에 따라 해당 스와이퍼 조작
        $(eachSlide).find(".btn.prev").on('click', function(){          
            var cl = $(this).parent().attr('class');
            // 클래스 이름에서 숫자만 가져오기
            var clTxt = cl.replace(/[^0-9]/g,'');           
            colorSwiper[clTxt].swipePrev();
            return false;
        });
        $(eachSlide).find('.btn.next').on('click', function(){
            var cl = $(this).parent().attr('class');
            var clTxt = cl.replace(/[^0-9]/g,'');
            colorSwiper[clTxt].swipeNext();
            return false;
        });
    });
}

/* 20210324 메인개편 탭추가 :: S */
function mainTab() {
	$('.main_subTab li').on('click',function(){
		$(this).addClass('on').siblings('li').removeClass('on');
	})
}
/* 20210324 메인개편 탭추가 :: E */

/* 20210721 리스트 호버 추가 :: S */
function listHover(){
	$(".productList > li").hover(function () {
		$(".productList > li").removeClass("on")
		$(this).addClass("on")
	}, function () {
		$(".productList > li").removeClass("on")
	});
}
/* 20210721 리스트 호버 추가 :: E */ 
</script>
