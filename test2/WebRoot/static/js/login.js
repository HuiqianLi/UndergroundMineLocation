function login() {
	var username = $('#username').val();
	var password = $('#password').val();
	if(username.length <= 0) {
		alert("用户名不能为空")
		return;
	}
	if(password.length <= 0) {
		alert("密码不能为空")
		return;
	}

	var url = "http://localhost:8080/test2/user/login?username=" + username + "&password=" + password;
	$.get(url, function(data) {
		if(data.code == 1) {
			window.location.href = "index.html";
		} else {
			alert(data.msg)
		}
	});
}
function register() {
	var username = $('#username').val();
	var email = $('#email').val();
	var password = $('#password').val();
	var password_again = $('#password_again').val();
	if(username.length <= 0) {
		alert("用户名不能为空")
		return;
	}
	if(password.length <= 0) {
		alert("密码不能为空")
		return;
	}
	if(password != password_again) {
		alert("密码输入不一致")
		return;
	}
	var url = "http://localhost:8080/test2/user/addUser?username=" + username + "&password=" + password + "&email=" + email;
	$.get(url, function(data) {
		if(data.code == 1) {
			window.location.href = "login.html";
		} else {
			alert(data.msg)
		}
	});
}
function checkEmail(){
	var username = $('#username').val();
	var email = $('#email').val();
	if(username.length <= 0) {
		alert("用户名不能为空")
		return;
	}
	if(email.length <= 0) {
		alert("邮箱不能为空")
		return;
	}
	var url = "http://localhost:8080/test2/user/check?username=" + username + "&email=" + email;
	$.get(url, function(data) {
		if(data.code == 1) {
			//window.location.href = "forgotPwd2.html";
			window.location.href = "forgotPwd2.html?username=" + username;//链接跳转
		} else {
			alert(data.msg)
		}
	});
}

function resetPwd(){
	//var username = $('#username').val();
	var username;
	var url=window.location.search; //获取url中"?"符后的字串  
	if(url.indexOf("?")!=-1){
	 username = url.substr(url.indexOf("=")+1);
	 }
	console.log(username);
	
	var password = $('#password').val();
	var password_again = $('#password_again').val();
	if(username.length <= 0) {
		alert("用户名不能为空")
		return;
	}
	if(password.length <= 0) {
		alert("密码不能为空")
		return;
	}
	if(password != password_again) {
		alert("密码输入不一致")
		return;
	}
	var url = "http://localhost:8080/test2/user/resetPwd?username=" + username + "&password=" + password;
	$.get(url, function(data) {
		if(data.code == 1) {
			window.location.href = "forgotPwd3.html";
		} else {
			alert(data.msg)
		}
	});   	
}