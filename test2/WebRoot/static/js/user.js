var userId;
/**
 * 获取全部用户
 */
getUser();
function getUser() {
	var url = "http://localhost:8080/test2/user/getUser";
	$.get(url, function(data) {
		if (data.code == 1) {
			var html = template('user_list', data.data);
			document.getElementById('users_content').innerHTML = html;
		} else if (data.code == 101) {
			// 登录失效

		} else {
			alert(data.msg)
		}
	});
}
//添加用户弹窗
function showAddDialog() {
	$('#id').val('');
	$('#username').val('');
	$('#password').val('');
	$('#phone').val('');
	$('#email').val('');

	$('#myUser').html("添加用户");
	//显示弹窗
	$('#addUser').modal('show');

}
//编辑用户弹窗
function showEditDialog(id) {
	var url = "http://localhost:8080/test2/user/getUser?userId=" + id;
	$.get(url, function(data) {
		if (data.code == 1) {
			$('#id').val(data.data[0].id);
			$('#username').val(data.data[0].username);
			$('#password').val(data.data[0].password);
			$('#phone').val(data.data[0].phone);
			$('#email').val(data.data[0].email);
			$('#myUser').html("修改用户");
			//显示弹窗
			$('#addUser').modal('show');
		} else if (data.code == 101) {
			// 登录失效

		} else {
			alert(data.msg)
		}
	});

}
//添加/编辑用户
function addorEditUser() {
	if($('#id').val()!=null)
		var id = $('#id').val();
	var username = $('#username').val();
	var password = $('#password').val();
	var phone = $('#phone').val();
	var email = $('#email').val();
	if (username.length <= 0) {
		alert("用户名不能为空")
		return;
	}
	if (password.length <= 0) {
		alert("密码不能为空")
		return;
	}
	if (email.length <= 0) {
		alert("邮箱不能为空")
		return;
	}
	var title = $('#myUser').html();
	if (title.indexOf("修改") != -1) {
		//var id = $('#id').val();
		var url = "http://localhost:8080/test2/user/updateUser?username="
			+ username + "&password=" + password + "&phone=" + phone
			+ "&email=" + email + "&id=" + id;
		$.get(url, function(data) {
			if (data.code == 1) {
				//隐藏弹窗                              
				$('#addUser').modal('hide');
				// 刷新界面
				window.location.reload();
			} else if (data.code == 101) {
				// 登录失效

			} else {
				alert(data.msg);
			}
		});

	} else {
		var url = "http://localhost:8080/test2/user/addUser?username="
			+ username + "&password=" + password + "&phone=" + phone
			+ "&email=" + email;
		$.get(url, function(data) {
			if (data.code == 1) {
				//隐藏弹窗  
				$('#addUser').modal('hide');
				// 刷新界面
				window.location.reload();
			} else if (data.code == 101) {
				// 登录失效

			} else {
				alert(data.msg);
			}
		});
	}

}
//删除用户弹窗
function showDeleteDialog(id) {
	userId = id;
	$('#deleteUser').modal('show');
}

//删除用户
function deleteUser() {
	if (userId.length <= 0) {
		alert("id不能为空")
		return;
	}
	var url = "http://localhost:8080/test2/user/deleteUser?userId=" + userId;
	$.get(url, function(data) {
		if (data.code == 1) {
			// 刷新界面
			window.location.reload();
		} else if (data.code == 101) {
			// 登录失效

		} else {
			alert(data.msg);
		}
	});

}
