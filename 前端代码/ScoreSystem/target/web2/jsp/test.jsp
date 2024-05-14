<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>File Upload</title>
    <style>
        body {
            font-family: Arial, sans-serif;
        }
        #uploadForm {
            width: 300px;
            margin: 0 auto;
        }
        input[type="file"] {
            margin-bottom: 10px;
        }
        #message {
            margin-top: 10px;
        }
    </style>
</head>
<body>
<div id="uploadForm">
    <h2>Upload File</h2>
    <form id="fileUploadForm" enctype="multipart/form-data">
        <input type="file" name="file" id="file">
        <button type="button" onclick="uploadFile()">Upload</button>
    </form>
    <div id="message"></div>
</div>

<script>
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
</body>
</html>
