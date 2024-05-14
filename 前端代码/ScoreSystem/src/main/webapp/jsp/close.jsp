<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>注销</title>
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

        .login-box input[type="button"] {
            width: 100%;
            padding: 10px;
            border: none;
            background-color: #007bff;
            color: #fff;
            cursor: pointer;
            border-radius: 3px;
        }

        .login-box input[type="button"]:hover {
            background-color: #0056b3;
        }

        .error-message {
            color: red;
            margin-top: 5px;
        }

        label {
            font-weight: bold;
            color: #333;
            margin-right: 10px;
        }

        /* 复选框样式 */
        input[type="checkbox"] {
            margin-right: 5px;
            transform: scale(1.5); /* 调整复选框的大小 */
        }

        /* 当复选框被选中时的样式 */
        input[type="checkbox"]:checked + label {
            color: #007bff; /* 改变标签颜色 */
        }
    </style>
</head>
<body>
<div class="login-box">
    <h2>用户注销</h2>
    <form id="loginForm">
        <input type="text" name="userid" id="userid" placeholder="用户名/邮箱">
        <input type="password" name="password" id="password" placeholder="密码">
        <label>账户类型:</label>
        <input type="checkbox" name="accounttype" id="accounttype_student" value="student"> 学生
        <input type="checkbox" name="accounttype" id="accounttype_teacher" value="teacher"> 教师
        <input type="checkbox" name="accounttype" id="accounttype_officer" value="officer"> 教务
        <input type="text" name="stuOrteaid" id="stuOrteaid" placeholder="学工号">
        <input type="button" id="signButton" value="注销">
    </form>
    <div id="loginMessage"></div>

    <script>
        $(document).ready(function () {
            $("#signButton").click(function () {
                var userid = $("#userid").val();
                var password = $("#password").val();
                var accountType = $("input[name='accounttype']:checked").val();
                var stuOrteaid = $("#stuOrteaid").val();
                var data = {
                    userid: userid,
                    password: password,
                    accounttype: accountType,
                    id:stuOrteaid
                };
                $.ajax({
                    type: "POST",
                    url: 'http://localhost:8080/demo/close', // 这里填写处理请求的Servlet的URL
                    data: data,
                    success: function (response) {
                        // 处理成功响应
                        alert(response);
                        window.location.href = 'http://localhost:8082';
                    },
                    error: function (xhr, status, error) {
                        alert("发生错误：" + error);
                    }
                });
            });
        });
    </script>
</div>
</body>
</html>
