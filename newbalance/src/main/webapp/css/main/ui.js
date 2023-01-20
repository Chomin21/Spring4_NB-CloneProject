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

/* detail - fixed =============================================================== */
function detailFixed(){
	var browserH = $(window).height();
	var fixedSection1 = $('.detail .detail_wrap');
	var fixedSection2 = $('.detail .detail_bottom');
	var setSection1 = fixedSection1.offset().top;
	var setSection2 = fixedSection2.offset().top;
	var intScrollTop = $(window).scrollTop();
	var stickyTabH = $('.sticky_wrap .tab_box').height()

	var tabbox = $('.tab_box li');
	tabbox.each(function(n){
		$(this).find('a').click(function(){
			$(this).parent().addClass('active').siblings().removeClass('active');
		});
	});

	if(intScrollTop > setSection1 ) {
		fixedSection1.find('.sticky_wrap').css({'top':0});
		fixedSection1.addClass('fixed');
	}
	else if(intScrollTop < setSection1 ){
		fixedSection1.find('.sticky_wrap').css({'top':0});
		fixedSection1.removeClass('fixed');
	}

	if(intScrollTop > setSection2-browserH ) {
		var topN = intScrollTop -(setSection2-browserH);
		fixedSection1.find('.sticky_wrap').css({'top':-topN});
	}

	var secScroll = browserH -1 -($('.sticky_wrap .sec_prices').innerHeight()) - stickyTabH;
	$('.sticky_wrap .option_wrap .sec_scroll').css('height',secScroll);
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
	$('.cal_noti .btn_area input').on('click', function() {
		if ($('.cal_noti .btn_area input').prop('checked')) {
			$('.cal_noti .top_box').addClass('on');
			$('.cal_noti .top_box p').html('알림취소 시 <span class="en">NB</span> 런칭캘린더에 등록되는<br />신규 상품과 기획전에 대한 알림이 제공되지 않습니다.');
			$('.cal_noti .btn_area label').text('캘린더 알림취소');
		} else {
			$('.cal_noti .top_box').removeClass('on');
			$('.cal_noti .top_box p').html('<span class="en">NB</span> 런칭캘린더에 등록되는<br />신규 상품과 기획전에 대한 알림을 받을 수 있습니다.');
			$('.cal_noti .btn_area label').text('캘린더 알림받기');
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
