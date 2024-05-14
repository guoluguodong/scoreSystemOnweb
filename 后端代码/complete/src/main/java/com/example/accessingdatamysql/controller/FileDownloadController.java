package com.example.accessingdatamysql.controller;

import com.example.accessingdatamysql.entity.Grade;
import com.example.accessingdatamysql.entity.Student;
import com.example.accessingdatamysql.repository.GradeRepository;
import com.example.accessingdatamysql.repository.StudentRepository;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Optional;

@Controller
@RequestMapping(path = "/excel")
public class FileDownloadController {

    @Autowired
    private StudentRepository studentRepository;

    @Autowired
    private GradeRepository gradeRepository;

    @CrossOrigin(origins = "http://localhost:8082")
    @GetMapping("/download")
    public ResponseEntity<ByteArrayResource> downloadFile(@RequestParam String classid) throws IOException {
        Iterable<Grade> result = gradeRepository.getByClassid(classid);
        try (Workbook workbook = new XSSFWorkbook()) {
            // 创建一个工作表
            Sheet sheet = workbook.createSheet("Sheet1");

            // 表头
            Row row = sheet.createRow(0);
            Cell cell;
            cell = row.createCell(0);
            cell.setCellValue("学号");
            cell = row.createCell(1);
            cell.setCellValue("姓名");
            cell = row.createCell(2);
            cell.setCellValue("班号");
            cell = row.createCell(3);
            cell.setCellValue("平时分");
            cell = row.createCell(4);
            cell.setCellValue("期中分数");
            cell = row.createCell(5);
            cell.setCellValue("实验分");
            cell = row.createCell(6);
            cell.setCellValue("期末成绩");
            cell = row.createCell(7);
            cell.setCellValue("综合成绩");


            // 创建一行，并在其中创建单元格
            int i=1;
            for (Grade grade : result) {
                Optional<Student> student = studentRepository.findById(grade.getStudentId());
                if(student.isPresent()){
                    String studentname = student.get().getName();
                    row = sheet.createRow(i);
                    cell = row.createCell(0);
                    cell.setCellValue(grade.getStudentId());
                    cell = row.createCell(1);
                    cell.setCellValue(studentname);
                    cell = row.createCell(2);
                    cell.setCellValue(grade.getClassId());
                    cell = row.createCell(3);
                    cell.setCellValue(grade.getAttendanceGrade());
                    cell = row.createCell(4);
                    cell.setCellValue(grade.getMidtermGrade());
                    cell = row.createCell(5);
                    cell.setCellValue(grade.getMidtermGrade());
                    cell = row.createCell(6);
                    cell.setCellValue(grade.getFinalGrade());
                    cell = row.createCell(7);
                    cell.setCellValue(grade.getFinalGrade());
                }
                i++;
            }
            // 写入数据到文件
            try (FileOutputStream fileOut = new FileOutputStream("C:\\Users\\a3840\\Desktop\\gs-accessing-data-mysql-main\\complete\\src\\main\\java\\com\\example\\accessingdatamysql\\excels\\workbook.xlsx")) {
                workbook.write(fileOut);
            }

            System.out.println("Excel 文件生成成功！");
        } catch (IOException e) {
            e.printStackTrace();
        }
        // 读取文件内容
        Path path = Paths.get("C:\\Users\\a3840\\Desktop\\gs-accessing-data-mysql-main\\complete\\src\\main\\java\\com\\example\\accessingdatamysql\\excels\\workbook.xlsx");
        byte[] data = Files.readAllBytes(path);

        // 将文件内容封装为ByteArrayResource对象
        ByteArrayResource resource = new ByteArrayResource(data);

        // 设置HTTP响应头
        HttpHeaders headers = new HttpHeaders();
        String filename= "grade_of_"+classid+".xlsx";
        headers.add(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename="+filename);
        headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);

        // 返回ResponseEntity对象，包含文件内容和响应头
        return ResponseEntity.ok()
                .headers(headers)
                .body(resource);
    }


}

