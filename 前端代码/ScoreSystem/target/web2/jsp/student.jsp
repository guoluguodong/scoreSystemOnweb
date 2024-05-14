<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>学生信息与成绩</title>
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
    </style>
</head>
<body>
<h1>学生信息</h1>
<div id="StudentInformation"></div>
<h1>学生成绩</h1>
<div id="StudentGrade"></div>
<%
    // 获取查询参数 studentId
    String userid = request.getParameter("userid");
%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
    $(document).ready(function () {
        var userid = '<%= userid %>';
        var studentData = {};
        var stuid = "";
        $.ajax({
            type: 'POST',
            url: 'http://localhost:8080/student/findstudentid',
            data: {userid: userid},
            success: function (response) {
                var students = JSON.parse(response); // Assuming the response is in JSON format
                var tableHTML = '<table border="1"><tr><th>学号</th><th>账号</th><th>姓名</th><th>年级</th><th>平均分</th><th>排名</th></tr>';
                console.log(students);
                    tableHTML += '<tr>';
                    stuid = students.studentid;
                    tableHTML += '<td>' + students.studentid + '</td>';
                    tableHTML += '<td>' + students.userid + '</td>';
                    tableHTML += '<td>' + students.name + '</td>';
                    tableHTML += '<td>' + students.grade + '</td>';
                tableHTML += '<td>' + students.averagescore + '</td>';
                    tableHTML += '<td>' + students.ranking + '</td>';


                    tableHTML += '</tr>';
                tableHTML += '</table>';
                // Display the table in the StudentGrade div
                $('#StudentInformation').html(tableHTML);
                $.ajax({
                    type: 'POST',
                    url: 'http://localhost:8080/grade/findgradebystudentid',
                    data: {studentid: stuid},
                    success: function (response) {
                        // $('#StudentGrade').text(response);
                        console.log(response);
                        console.log(stuid);
                        var grades = JSON.parse(response); // Assuming the response is in JSON format
                        var tableHTML = '<table border="1"><tr><th>Class ID</th><th>Attendance Grade</th><th>Midterm Grade</th><th>Lab Grade</th><th>Final Grade</th><th>Comprehensive Grade</th></tr>';
                        console.log(grades);
                        grades.forEach(function (grade) {
                            tableHTML += '<tr>';
                            tableHTML += '<td>' + grade.classid + '</td>';
                            tableHTML += '<td>' + grade.attendancegrade + '</td>';
                            tableHTML += '<td>' + grade.midtermgrade + '</td>';
                            tableHTML += '<td>' + grade.labgrade + '</td>';
                            tableHTML += '<td>' + grade.finalgrade + '</td>';
                            tableHTML += '<td>' + grade.comprehensivegrade + '</td>';
                            tableHTML += '</tr>';
                        });

                        tableHTML += '</table>';

                        // Display the table in the StudentGrade div
                        $('#StudentGrade').html(tableHTML);
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
