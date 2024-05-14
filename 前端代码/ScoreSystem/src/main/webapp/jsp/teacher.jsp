<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>管理班级学生成绩</title>
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

        .CustomWindow {
            display: none; /* 初始状态隐藏 */
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
        #uploadForm {
            width: 300px;
        }
        input[type="file"] {
            margin-bottom: 10px;
        }
        #message {
            margin-top: 10px;
        }
    </style>
    </style>
</head>
<body>
<h1>教师信息</h1>
<div id="TeacherInformation"></div>
<h1>所授课程班</h1>
<div id="TeacherClass"></div>
<div id="uploadForm">
    <h2>录入学生成绩</h2>
    <form id="fileUploadForm" enctype="multipart/form-data">
        <input type="file" name="file" id="file">
        <button type="button" onclick="uploadFile()">Upload</button>
    </form>
    <div id="message"></div>
</div>
<%--自定义弹窗--%>
<!-- 弹窗内容 -->
<div id="customWindow" class="CustomWindow">
    <h2>班级成绩一览</h2>
    <div id="StudentInClass"></div>
    <div><canvas id="myPieChart" width="300" height="300"></canvas></div>
    <button class="custom-button" onclick="HideWindow()">关闭</button>
</div>
<%
    // 获取查询参数 studentId
    String userid = request.getParameter("userid");
%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script>
    // Define a variable to keep track of the sorting order for each column
    var grades = []
    var ascend = true;
    var userId = '<%= request.getParameter("userid") %>';
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
            grades = sortByKey(grades,'studentid',ascend);
        }
        if(a===1){
            grades = sortByKey(grades,'studentname',ascend);
        }
        if(a===2){
            grades = sortByKey(grades,'attendancegrade',ascend);
        }
        if(a===3){
            grades = sortByKey(grades,'midtermgrade',ascend);
        }
        if(a===4){
            grades = sortByKey(grades,'labgrade',ascend);
        }
        if(a===5){
            grades = sortByKey(grades, 'finalgrade', ascend);
        }
        if(a===6){
            grades = sortByKey(grades, 'comprehensivegrade', ascend);
        }
        ascend = !ascend;
        buildTable();
    }
    function buildTable()
    {
        var tableHTML = '<table border="1"><tr>';
        tableHTML += '<th onclick="sortTable(0)">学号 &#x25BE</th>';
        tableHTML += '<th onclick="sortTable(1)">姓名 &#x25BE</th>';
        tableHTML += '<th onclick="sortTable(2)">Attendance Grade &#x25BE</th>';
        tableHTML += '<th onclick="sortTable(3)">Midterm Grade &#x25BE</th>';
        tableHTML += '<th onclick="sortTable(4)">Lab Grade &#x25BE</th>';
        tableHTML += '<th onclick="sortTable(5)">Final Grade &#x25BE</th>';
        tableHTML += '<th onclick="sortTable(6)">综合成绩 &#x25BE</th></tr>';
        grades.forEach(function (grade) {
            tableHTML += '<tr>';
            tableHTML += '<td>' + grade.studentid + '</td>';
            tableHTML += '<td>' + grade.studentname + '</td>';
            tableHTML += '<td>' + grade.attendancegrade + '</td>';
            tableHTML += '<td>' + grade.midtermgrade + '</td>';
            tableHTML += '<td>' + grade.labgrade + '</td>';
            tableHTML += '<td>' + grade.finalgrade + '</td>';
            tableHTML += '<td>' + grade.comprehensivegrade + '</td>';
            tableHTML += '</tr>';
        });
        tableHTML += '</table>';
        var tableWrapper = '<div style="overflow:auto; max-height: 400px;">' + tableHTML + '</div>';

        // Display the table in the StudentGrade div
        $('#StudentInClass').html(tableWrapper);
    }
    function staisticComprehensiveScore(){
        var comprehensivedata = [0,0,0,0,0];
        // 60下，60-70，70-80，80-90，90+
        grades.forEach(function (grade) {
            if(grade.comprehensivegrade<60)
                comprehensivedata[0]++;
            else if(grade.comprehensivegrade>60&&grade.comprehensivegrade<70)
                comprehensivedata[1]++;
            else if(grade.comprehensivegrade>70&&grade.comprehensivegrade<80)
                comprehensivedata[2]++;
            else if(grade.comprehensivegrade>80&&grade.comprehensivegrade<80)
                comprehensivedata[3]++;
            else if(grade.comprehensivegrade>90)
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
    function showWindow(message) {
        var classid = message;
        $.ajax({
            type: 'POST',
            url: 'http://localhost:8080/grade/findgradebycourse',
            data: {classid: classid},
            success: function (response) {
                console.log(response);
                console.log(classid);
                grades = JSON.parse(response); // Assuming the response is in JSON format
                console.log(grades);
                buildTable();
                staisticComprehensiveScore();
            },
            error: function (xhr, status, error) {
                console.error('Error:', error);
            }
        });
        document.getElementById("customWindow").style.display = "block";
    }

    function HideWindow() {
        document.getElementById("customWindow").style.display = "none";
    }
    function DownloadFile(message) {
        var classid = message;
        window.location.href = 'http://localhost:8080/excel/download?classid=' + classid;
    }
    function uploadFile() {
        const fileInput = document.getElementById('file');
        const file = fileInput.files[0];
        const formData = new FormData();
        formData.append('file', file);

        fetch('http://localhost:8080/excel/upload', {
            method: 'POST',
            body: formData
        })
            .then(response => {
                if (response.ok) {
                    document.getElementById('message').innerText = 'File uploaded successfully';
                } else {
                    document.getElementById('message').innerText = 'Failed to upload file';
                }
            })
            .catch(error => {
                console.error('Error:', error);
                document.getElementById('message').innerText = 'An error occurred while uploading the file';
            });
    }
</script>
<script>
    $(document).ready(function () {
        var userid = '<%= userid %>';
        var studentData = {};
        var teaid = "";
        $.ajax({
            type: 'POST',
            url: 'http://localhost:8080/teacher/findteacherid',
            data: {userid: userid},
            success: function (response) {
                var teacher = JSON.parse(response); // Assuming the response is in JSON format
                var tableHTML = '<table border="1"><tr><th>教职工编号</th><th>账号</th><th>姓名</th></tr>';
                console.log(teacher);
                tableHTML += '<tr>';
                teaid = teacher.teacherid;
                tableHTML += '<td>' + teacher.teacherid + '</td>';
                tableHTML += '<td>' + teacher.userid + '</td>';
                tableHTML += '<td>' + teacher.name + '</td>';
                tableHTML += '</tr>';
                tableHTML += '</table>';
                // Display the table in the TeacherClass div
                $('#TeacherInformation').html(tableHTML);
                $.ajax({
                    type: 'POST',
                    url: 'http://localhost:8080/class/findmyclassbyteacherid',
                    data: {teacherid: teaid},
                    success: function (response) {
                        var classes = JSON.parse(response); // Assuming the response is in JSON format
                        var tableHTML = '<table border="1"><tr><th>教学班号</th><th>教职工编号</th><th>课程编号</th><th>学生总数</th><th>功能</th><th>功能</th></tr>';
                        classes.forEach(function (myclass) {
                            tableHTML += '<tr>';
                            tableHTML += '<td>' + myclass.classid + '</td>';
                            tableHTML += '<td>' + myclass.teacherid + '</td>';
                            tableHTML += '<td>' + myclass.courseid + '</td>';
                            tableHTML += '<td>' + myclass.totalstudents + '</td>';
                            var message = myclass.classid;
                            var functionCall = "showWindow('" + message + "')";
                            tableHTML += '<td><button onClick="' + functionCall + '" style="width: 100%; padding: 10px; \
                            border: none; background-color: #007bff; color: #fff; cursor: pointer; border-radius: 3px">查看成绩</button></td>';

                            var message1 = myclass.classid;
                            var functionCall1 = "DownloadFile('" + message1 + "')";
                            tableHTML += '<td><button onClick="' + functionCall1 + '" style="width: 100%; padding: 10px; \
                            border: none; background-color: #007bff; color: #fff; cursor: pointer; border-radius: 3px">导出班级成绩</button></td>';
                            tableHTML += '</tr>';
                        });

                        tableHTML += '</table>';

                        // Display the table in the StudentGrade div
                        $('#TeacherClass').html(tableHTML);
                    },
                    error: function (xhr, status, error) {
                        console.error('Error:', error);
                    }
                });
            },
            error: function (xhr, status, error) {
                console.error('Error:', error);
            }
        });

    });
</script>
</body>
</html>
