package com.example.accessingdatamysql.controller;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.apache.poi.ss.usermodel.*;

import java.io.File;
import java.io.IOException;

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

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Optional;

@Controller
@RequestMapping(path = "/excel")
public class FileUploadController {
    @Autowired
    private GradeRepository gradeRepository;

    @CrossOrigin(origins = "http://localhost:8082")
    @PostMapping("/upload")
    public @ResponseBody ResponseEntity<String> handleFileUpload(@RequestParam("file") MultipartFile file) {
        if (file.isEmpty()) {
            return new ResponseEntity<>("No file uploaded", HttpStatus.BAD_REQUEST);
        }
        try {
            // 保存文件到指定目录（例如，当前项目根目录下的 uploads 文件夹）
            String uploadsDir = "C:\\Users\\a3840\\Desktop\\gs-accessing-data-mysql-main\\complete\\src\\main\\java\\com\\example\\accessingdatamysql\\excels\\";
            String filePath = uploadsDir + file.getOriginalFilename();
            File dest = new File(filePath);
            file.transferTo(dest);
            try {
                FileInputStream excelFile = new FileInputStream(new File(filePath));
                Workbook workbook = WorkbookFactory.create(excelFile);
                Sheet sheet = workbook.getSheetAt(0);
                int i = 0, j = 0;
                for (Row row : sheet) {

                    if (i == 0) {
                        i++;
                        continue;
                    }
                    j = 0;
                    String studentid="", studentname, classid="";
                    double attendancegrade = 0;
                    double midtermgrade = 0;
                    double labgrade= 0;
                    double finalgrade= 0;
                    double comprehensivegrade;
                    for (Cell cell : row) {
                        switch (cell.getCellType()) {
                            case STRING:
                                System.out.print(cell.getStringCellValue() + "\t");
                                break;
                            case NUMERIC:
                                System.out.print(cell.getNumericCellValue() + "\t");
                                break;
                            case BOOLEAN:
                                System.out.print(cell.getBooleanCellValue() + "\t");
                                break;
                            default:
                                System.out.print("Unknown type\t");
                        }

                        if (j == 0) {
                            studentid = cell.getStringCellValue();
                        } else if (j == 1) {
                            studentname = cell.getStringCellValue();
                        }
                        else if (j == 2) {
                            classid = cell.getStringCellValue();
                        }
                        else if (j == 3) {
                            attendancegrade = cell.getNumericCellValue();
                        }
                        else if (j == 4) {
                            midtermgrade = cell.getNumericCellValue();
                        }
                        else if (j == 5) {
                            labgrade = cell.getNumericCellValue();
                        }
                        else if (j == 6) {
                            finalgrade = cell.getNumericCellValue();
                        }
                        j++;
                    }
                    comprehensivegrade = (attendancegrade+midtermgrade+labgrade+labgrade)/4;
                    Iterable<Grade> grades = gradeRepository.getByStudentidAndClassid(studentid,classid);
                    for(Grade grade: grades){
                        grade.setAttendanceGrade(attendancegrade);
                        grade.setMidtermGrade(midtermgrade);
                        grade.setLabGrade(labgrade);
                        grade.setFinalGrade(finalgrade);
                        grade.setComprehensiveGrade();
                        gradeRepository.save(grade);
                    }
                    System.out.println();
                }

                workbook.close();
                excelFile.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
            return new ResponseEntity<>("File uploaded successfully", HttpStatus.OK);
        } catch (IOException e) {
            e.printStackTrace();
            return new ResponseEntity<>("Failed to upload file", HttpStatus.INTERNAL_SERVER_ERROR);
        }

    }
}
