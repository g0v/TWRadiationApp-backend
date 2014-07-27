
// This is called with the results from from FB.getLoginStatus().
function n_fb_statusChangeCallback() {
	console.log('n_fb_statusChangeCallback');
	FB.getLoginStatus(function(response) {
		console.log(response);
		if (response.status === 'connected') {
			// Logged into your app and Facebook.
			console.log("USER ID:" + response.authResponse.userID);
			console.log('Welcome!  Fetching your information.... ');
			FB.api('/me', function(me_res) {
				console.log('Successful login for: ' + me_res.name + ", email: " + me_res.email);
				console.log("fb_token: " + response.authResponse.accessToken);
				console.log("form_auth_token: " + $('input[name=form_auth_token]')[0].value);
				var pdata = {fb_token: response.authResponse.accessToken,
						fb_email: me_res.email,
						fb_name: me_res.name,
						form_auth_token: $('input[name=form_auth_token]')[0].value,
						action: "signin"};
				jQuery.post($('#userpass_form').attr('action'),
					pdata, function(result){
						if ( typeof(result) != 'undefined') {
							if ((result.ret == 0) && (result.status == 'success')) {
								window.location.href = "http://l.stark.tw";
							} else {
								console.log(result.ret + " " + result.status);
							}
						}
					}, 'json'
				);
			});
		} else if (response.status === 'not_authorized') {
			// The person is logged into Facebook, but not your app.
			console.log('n_fb_statusChangeCallback: not_authorized!');
		} else {
			// The person is not logged into Facebook, so we're not sure if
			// they are logged into this app or not.
			console.log('n_fb_statusChangeCallback: other');
		}
	});
}

jQuery(document).ready(function( $ ) {
	// TOGGLE DROPDOWN
	$('.header_nav_dropdown .header_nav_cancel').on('click', function(e) {
		$(this).closest('.header_nav_dropdown').fadeOut('fast');
		$(this).closest('.header_nav_dropdown').siblings('p').removeClass('active');
	});
	$('.header_nav_has_dropdown > a, .header_nav_actions .header_nav_button_delete, .header_nav_actions .header_nav_button_change').on('click', function(e) {
		$(this).toggleClass('active');
		$(this).siblings('.header_nav_dropdown').fadeToggle('fast')
		e.stopPropagation();
		return false;
	});
	$('.header_nav_actions .header_nav_dropdown').on('click', function(e) {
		e.stopPropagation();
	});

	$('#header_nav_forgot').click(function() {
		$('#header_nav_userforgot_form').toggle('fast');
	});
	
	// Silence JS errors if console not defined (ie. not firebug and not running chrome)
//	if(typeof(console) === 'undefined') {
//		var console = {};
//		console.log = console.error = console.info = console.debug = console.warn = console.trace = console.dir = console.dirxml = console.group = console.groupEnd = console.time = console.timeEnd = console.assert = console.profile = function() {};
//	}
	
	// Trigger pngFix
	if($(document).pngFix)
	{
		$(document).pngFix();
	}

	if ( $(".header_nav_dropdown").attr("data-loginstat") == "false" ) {
		console.log("loginstat = false");
		FB.init({
			appId      : LNM_FBappId,
			cookie     : true,	// enable cookies to allow the server to access the session
			xfbml      : true,	// parse social plugins on this page
			version    : 'v2.0'	// use version 2.0
		});
		FB.getLoginStatus(function(response) {
			console.log(response);
		});
	} else {
		console.log("loginstat = true");
		$("#logout").hover(function(){
			$(this).css('cursor','pointer');
		}).click(function() {
			FB.init({
				appId      : LNM_FBappId,
				cookie     : true,	// enable cookies to allow the server to access the session
				xfbml      : true,	// parse social plugins on this page
				version    : 'v2.0'	// use version 2.0
			});
			FB.getLoginStatus(function(response) {
				if (response.status === 'connected') {
					FB.logout(function(response) {
						window.location.href = "http://" + document.domain + "/logout";
					});
				} else {
					window.location.href = "http://" + document.domain + "/logout";
				}
			});
		});
	}

});

