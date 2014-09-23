$(function() {

	$("[rel=tooltip]").tooltip();

	$('[rel=popover]').popover({
		html : true
	});

	$('[data-spy="affix"]').each(function() {
		// $(this).affix({offset: {y:-100}});
		// Doesn't do anything, to be done later
	});

	$(".lightbox").fancybox({
		helpers : {
			title : {
				type : 'float'
			}
		}
	});

	$(".product").hover(function() {
		$(this).addClass("product-highlight");
	}, function() {
		$(this).removeClass("product-highlight");
	});

	$("#login-button")
			.click(
					function(e) {

						var username = $("#inputUsernameLogin").val();
						var password = $("#inputPasswordLogin").val();

						$
								.ajax({
									type : "POST",
									url : '/user/login.jsp',
									data : {
										inputUsername : username,
										inputPassword : password
									},
									dataType : 'json',
									success : function(response) {
										if (response.result) {

											if ($('#inputRemember').attr(
													'checked') == 'checked') {
												SetCookie("Username", $(
														'#inputUsernameLogin')
														.val(), 60);
												SetCookie("Remember", "true",
														60);
											} else {
												SetCookie("Username", "", 60);
												SetCookie("Remember", "false",
														60);
											}

											$("#login-modal").slideUp(
													function() {
														location.reload();
													});

										} else {
											$("#login-error").show();
											$("#login-modal").effect("shake", {
												direction : "up",
												times : 3,
												distance : 10
											}, 500);
										}
									}
								});

						e.preventDefault();
						return false;
					});

	var show_per_page = 5;
	var number_of_items = $('#content_pagination').children().size();
	var number_of_pages = Math.ceil(number_of_items / show_per_page);

	$('#current_page').val(0);
	$('#show_per_page').val(show_per_page);

	var navigation_html = '<li class="previous_link" onclick="javascript:previous();"><a>Prev</a></li>';
	var current_link = 0;
	while (number_of_pages > current_link) {
		navigation_html += '<li class="page_link" onclick="javascript:go_to_page('
				+ current_link
				+ ')" longdesc="'
				+ current_link
				+ '"><a>'
				+ (current_link + 1) + '</a></li>';
		current_link++;
	}
	navigation_html += '<li class="next_link" onclick="javascript:next();"><a>Next</a></li>';

	$('#page_navigation').html(navigation_html);

	$('#page_navigation .page_link:first').addClass('active');

	$('#content_pagination').children().css('display', 'none');

	$('#content_pagination').children().slice(0, show_per_page).css('display',
			'block');
});

function previous() {

	new_page = parseInt($('#current_page').val()) - 1;
	if ($('.active').prev('.page_link').length == true) {
		go_to_page(new_page);
	}

}

function next() {
	new_page = parseInt($('#current_page').val()) + 1;
	if ($('.active').next('.page_link').length == true) {
		go_to_page(new_page);
	}
}

function go_to_page(page_num) {

	var show_per_page = parseInt($('#show_per_page').val());

	start_from = page_num * show_per_page;

	end_on = start_from + show_per_page;

	$('#content_pagination').children().css('display', 'none').slice(
			start_from, end_on).css('display', 'block');

	$('.page_link[longdesc=' + page_num + ']').addClass('active').siblings(
			'.active').removeClass('active');

	$('#current_page').val(page_num);
}

function SetCookie(cookieName, cookieValue, nDays) {
	var today = new Date();
	var expire = new Date();
	if (nDays == null || nDays == 0)
		nDays = 1;
	expire.setTime(today.getTime() + 3600000 * 24 * nDays);
	document.cookie = cookieName + "=" + escape(cookieValue) + ";expires="
			+ expire.toGMTString();
}

function ReadCookie(cookieName) {
	var theCookie = " " + document.cookie;
	var ind = theCookie.indexOf(" " + cookieName + "=");
	if (ind == -1)
		ind = theCookie.indexOf(";" + cookieName + "=");
	if (ind == -1 || cookieName == "")
		return "";
	var ind1 = theCookie.indexOf(";", ind + 1);
	if (ind1 == -1)
		ind1 = theCookie.length;
	return unescape(theCookie.substring(ind + cookieName.length + 2, ind1));
}
