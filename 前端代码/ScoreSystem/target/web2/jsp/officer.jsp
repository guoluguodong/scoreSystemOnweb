<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>课程班级开设管理</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 20px;
            background-image: url("/image/ssobgimg1.jpg");
        }

        .container {
            max-width: 800px;
            margin: 0 auto;
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        h1 {
            color: #333;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: center;
        }

        th {
            background-color: #f2f2f2;
        }

        .login-box {
            display: none; /* 初始状态隐藏 */
            position: fixed;
            width: 300px;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
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

        .custom-button {
            background-color: #4CAF50; /* 按钮背景色 */
            border: none; /* 移除边框 */
            color: white; /* 按钮文本颜色 */
            padding: 10px 20px; /* 按钮内边距 */
            text-align: center; /* 文本居中 */
            text-decoration: none; /* 移除下划线 */
            display: inline-block; /* 内联块元素 */
            font-size: 16px; /* 字体大小 */
            margin: 4px 2px; /* 外边距 */
            cursor: pointer; /* 光标样式 */
            border-radius: 4px; /* 圆角 */
            transition-duration: 0.4s; /* 过渡效果时长 */
            box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2); /* 阴影 */
        }

        .custom-button:hover {
            background-color: #45a049; /* 按钮悬停时的背景色 */
        }
        .customWindow3 {
            display: none;
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            background-color: #fff;
            padding: 20px;
            border: 2px solid #333;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.5);
            z-index: 9999;
            width: 400px; /* 设置宽度 */
            height: 350px; /* 设置高度 */
        }

    </style>
</head>
<body>
<h1>课程信息</h1>
<button class="custom-button" onclick="showWindow()">新增课程</button>
<div id="CourseInformation"></div>
<h1>班级信息</h1>
<button class="custom-button" onclick="showWindow2()">新增教学班</button>
<div id="ClassGrade"></div>
<h1>学生信息</h1>
<button class="custom-button" onclick="showWindow3()">统计学生</button>
<div id="StudentGrade"></div>

<div id="customWindow" class="login-box">
    <h2>新增课程</h2>
    <form id="loginForm">
        <input type="text" name="userid" id="userid" placeholder="课程编号">
        <input type="text" name="password" id="password" placeholder="课程名">
        <input type="button" id="loginButton" value="添加">
    </form>
    <button class="custom-button" onclick="HideWindow()">关闭</button>
</div>
<div id="customWindow2" class="login-box">
    <h2>新增教学班</h2>
    <form id="addclassForm">
        <input type="text" name="classid" id="classid" placeholder="班级编号">
        <input type="text" name="courseid" id="courseid" placeholder="课程编号">
        <input type="text" name="teacherid" id="teacherid" placeholder="教师编号">
        <input type="button" id="AddClassButton" value="添加">
    </form>
    <button class="custom-button" onclick="HideWindow2()">关闭</button>
</div>
<div id="customWindow3" class="customWindow3">
    <h2>全校学生统计</h2>
    <div><canvas id="myPieChart" width="300" height="300"></canvas></div>
    <button class="custom-button" onclick="HideWindow3()">关闭</button>
</div>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script>
    var students;
    function showWindow(message) {
        document.getElementById("customWindow").style.display = "block";
    }

    function HideWindow() {
        document.getElementById("customWindow").style.display = "none";
    }

    function showWindow2(message) {
        document.getElementById("customWindow2").style.display = "block";
    }

    function HideWindow2() {
        document.getElementById("customWindow2").style.display = "none";
    }
    function showWindow3(message) {
        staisticComprehensiveScore()
        document.getElementById("customWindow3").style.display = "block";
    }

    function HideWindow3() {

        document.getElementById("customWindow3").style.display = "none";
    }
    function staisticComprehensiveScore(){
        var comprehensivedata = [0,0,0,0,0];
        // 60下，60-70，70-80，80-90，90+
        students.forEach(function (grade) {
            if(grade.averagescore<60)
                comprehensivedata[0]++;
            else if(grade.averagescore>60&&grade.averagescore<70)
                comprehensivedata[1]++;
            else if(grade.averagescore>70&&grade.averagescore<80)
                comprehensivedata[2]++;
            else if(grade.averagescore>80&&grade.averagescore<80)
                comprehensivedata[3]++;
            else if(grade.averagescore>90)
                comprehensivedata[4]++;
        });
        console.log(comprehensivedata)
        var data = {
            labels: ["60分以下: "+ String(comprehensivedata[0]), "60分-70分: "+ String(comprehensivedata[1]), "70分-80分: "+ String(comprehensivedata[2]), "80分-90分: "
            + String(comprehensivedata[3]), "90分以上: "+ String(comprehensivedata[4])],
            datasets: [{
                data: comprehensivedata,
                backgroundColor: [
                    'red',
                    'blue',
                    'yellow',
                    'green',
                    'purple'
                ]
            }]
        };
        var options = {
            responsive: true,
            maintainAspectRatio: false
        };
        var ctx = document.getElementById('myPieChart').getContext('2d');
        var myPieChart = new Chart(ctx, {
            type: 'pie',
            data: data,
            options: options
        });

    }

    function deletecourse(message) {
        courseid = message;
        $.ajax({
            type: 'POST',
            url: 'http://localhost:8080/course/deletecourse',
            data: {courseid: courseid},
            success: function (response) {
                window.location.href = 'http://localhost:8082/jsp/officer.jsp';
            },
            error: function (xhr, status, error) {
                console.error('Error:', error);
            }
        });
    }

    function deleteclass(message) {
        classid = message;
        $.ajax({
            type: 'POST',
            url: 'http://localhost:8080/class/deleteclass',
            data: {classid: classid},
            success: function (response) {
                window.location.href = 'http://localhost:8082/jsp/officer.jsp';
            },
            error: function (xhr, status, error) {
                console.error('Error:', error);
            }
        });
    }
    var ascend = true;
    function sortByKey(jsonArray, key, ascending = true) {
        return jsonArray.sort(function(a, b) {
            let comparison = 0;
            if (a[key] > b[key]) {
                comparison = 1;
            } else if (a[key] < b[key]) {
                comparison = -1;
            }
            return ascending ? comparison : comparison * -1;
        });
    }
    function sortTable(a){
        if(a===0){
            students = sortByKey(students,'studentid',ascend);
        }
        if(a===1){
            students = sortByKey(students,'userid',ascend);
        }
        if(a===2){
            students = sortByKey(students,'name',ascend);
        }
        if(a===3){
            students = sortByKey(students,'grade',ascend);
        }
        if(a===4){
            students = sortByKey(students,'averagescore',ascend);
        }
        if(a===5){
            students = sortByKey(students, 'ranking', ascend);
        }
        ascend = !ascend;
        buildTable();
    }
    function buildTable()
    {
        var tableHTML = '<table border="1"><tr>';
        tableHTML += '<th onclick="sortTable(0)">学号 &#x25BE</th>';
        tableHTML += '<th onclick="sortTable(1)">用户号 &#x25BE</th>';
        tableHTML += '<th onclick="sortTable(2)">姓名 &#x25BE</th>';
        tableHTML += '<th onclick="sortTable(3)">年级 &#x25BE</th>';
        tableHTML += '<th onclick="sortTable(4)">平均分 &#x25BE</th>';
        tableHTML += '<th onclick="sortTable(5)">排名 &#x25BE</th>';
        students.forEach(function (student) {
            tableHTML += '<tr>';
            tableHTML += '<td>' + student.studentid + '</td>';
            tableHTML += '<td>' + student.userid + '</td>';
            tableHTML += '<td>' + student.name + '</td>';
            tableHTML += '<td>' + student.grade + '</td>';
            tableHTML += '<td>' + student.averagescore + '</td>';
            tableHTML += '<td>' + student.ranking + '</td>';
            tableHTML += '</tr>';
        });
        tableHTML += '</table>';
        // Display the table in the StudentGrade div
        var tableWrapper = '<div style="overflow:auto; max-height: 400px;">' + tableHTML + '</div>';
        // Display the table in the StudentGrade div
        $('#StudentGrade').html(tableWrapper);
    }

    $(document).ready(function () {
        $('#loginButton').click(function () {
            var userid = $('#userid').val();
            var password = $('#password').val();
            $.ajax({
                type: 'POST',
                url: 'http://localhost:8080/course/addcourse',
                data: {courseid: userid, coursename: password},
                success: function (response) {
                    window.location.href = 'http://localhost:8082/jsp/officer.jsp';
                },
                error: function (xhr, status, error) {
                    console.error('Error:', error);
                }
            });
        });
        $('#AddClassButton').click(function () {
            var classid = $('#classid').val();
            var courseid = $('#courseid').val();
            var teacherid = $('#teacherid').val();
            $.ajax({
                type: 'POST',
                url: 'http://localhost:8080/class/addclass',
                data: {classid: classid, courseid: courseid, teacherid: teacherid},
                success: function (response) {
                    window.location.href = 'http://localhost:8082/jsp/officer.jsp';
                },
                error: function (xhr, status, error) {
                    console.error('Error:', error);
                }
            });
        });
        $.ajax({
            type: 'POST',
            url: 'http://localhost:8080/course/all',
            data: {},
            success: function (response) {
                var classes = JSON.parse(response); // Assuming the response is in JSON format
                var tableHTML = '<table border="1"><tr><th>课程号</th><th>课程名</th><th>操作</th></tr>';
                courses = JSON.parse(response);
                // tableHTML += '<tr>';
                courses.forEach(function (course) {
                    tableHTML += '<td>' + course.courseid + '</td>';
                    tableHTML += '<td>' + course.coursename + '</td>';
                    var message = course.courseid;
                    var functionCall = "deletecourse('" + message + "')";
                    tableHTML += '<td><button onClick="' + functionCall + '" style="width: 100%; padding: 10px; \
                            border: none; background-color: #007bff; color: #fff; cursor: pointer; border-radius: 3px">删除课程</button></td>';
                    tableHTML += '<tr>';
                });
                tableHTML += '</table>';
                // Display the table in the StudentGrade div
                $('#CourseInformation').html(tableHTML);

            },
            error: function (xhr, status, error) {
                console.error('Error:', error);
            }
        });
        $.ajax({
            type: 'POST',
            url: 'http://localhost:8080/class/all',
            data: {},
            success: function (response) {
                var classes = JSON.parse(response); // Assuming the response is in JSON format
                console.log(classes);
                var tableHTML = '<table border="1"><tr><th>班号</th><th>教师号</th><th>课程号</th><th>总学生数</th><th>操作</th></tr>';

                // tableHTML += '<tr>';
                classes.forEach(function (myclass) {
                    tableHTML += '<td>' + myclass.classid + '</td>';
                    tableHTML += '<td>' + myclass.teacherid + '</td>';
                    tableHTML += '<td>' + myclass.courseid + '</td>';
                    tableHTML += '<td>' + myclass.totalstudents + '</td>';
                    var message = myclass.classid;
                    var functionCall = "deleteclass('" + message + "')";
                    tableHTML += '<td><button onClick="' + functionCall + '" style="width: 100%; padding: 10px; \
                            border: none; background-color: #007bff; color: #fff; cursor: pointer; border-radius: 3px">删除课程</button></td>';
                    tableHTML += '<tr>';
                    tableHTML += '<tr>';
                });
                tableHTML += '</table>';
                // Display the table in the StudentGrade div
                $('#ClassGrade').html(tableHTML);
            },
            error: function (xhr, status, error) {
                console.error('Error:', error);
            }
        });
        $.ajax({
            type: 'POST',
            url: 'http://localhost:8080/student/all',
            data: {},
            success: function (response) {
                students = JSON.parse(response); // Assuming the response is in JSON format
                buildTable();
            },
            error: function (xhr, status, error) {
                console.error('Error:', error);
            }
        });
    });
</script>
</body>
</html>
