<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>登录</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-image: url("/image/ssobgimg.jpg");
        }
        .login-box {
            width: 300px;
            margin: 100px auto;
            background-color: #fff;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
        }
        .login-box h2 {
            text-align: center;
        }
        .login-box input[type="text"],
        .login-box input[type="password"] {
            width: calc(100% - 40px);
            padding: 10px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 3px;
        }
        .login-box input[type="submit"],
        .login-box input[type="button"] {
            width: calc(100% - 20px);
            padding: 10px;
            border: none;
            background-color: #007bff;
            color: #fff;
            cursor: pointer;
            border-radius: 3px;
            margin: 10px;

        }
        .login-box input[type="submit"],
        .login-box input[type="button"]:hover {
            background-color: #0056b3;
        }
        .error-message {
            color: red;
            margin-top: 5px;
        }
    </style>
</head>
<body>
<div class="login-box">
    <h2>用户登录</h2>
    <form id="loginForm">
        <input type="text" name="userid" id="userid" placeholder="用户名/邮箱">
        <input type="password" name="password" id="password" placeholder="密码">
        <input type="button" id="loginButton" value="登录">
    </form>
    <div id="loginMessage"></div>
    <form id="signup" action="jsp/signup.jsp">
        <input type="submit" id="signupbutton" value="注册">
    </form>
    <form id="close" action="jsp/close.jsp">
        <input type="submit" id="closebutton" value="注销">
    </form>

    <script>
        $(document).ready(function() {
            $('#loginButton').click(function() {
                var userid = $('#userid').val();
                var password = $('#password').val();

                $.ajax({
                    type: 'POST',
                    url: 'http://localhost:8080/demo/login',
                    data: { userid: userid, password: password },
                    success: function(response) {
                        $('#loginMessage').text(response);
                        console.log(response)
                        if(response!=="密码错误")
                            window.location.href = 'http://localhost:8082/jsp/'+response+'.jsp?userid=' + userid;
                    },
                    error: function(xhr, status, error) {
                        console.error('Error:', error);
                    }
                });
            });
        });
    </script>
</div>
</body>
</html>
