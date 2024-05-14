package com.example.accessingdatamysql.controller;

import com.example.accessingdatamysql.entity.Grade;
import com.example.accessingdatamysql.entity.Myclass;
import com.example.accessingdatamysql.entity.Student;
import com.example.accessingdatamysql.entity.User;
import com.example.accessingdatamysql.repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.Objects;
import java.util.Optional;
import java.util.Random;

import static java.lang.System.out;

@Controller    // This means that this class is a Controller
@RequestMapping(path = "/student") // This means URL's start with /demo (after Application path)
public class StudentController {


    @Autowired
    private StudentRepository studentRepository;
    @Autowired
    private ClassRepository classRepository;
    @Autowired
    private GradeRepository gradeRepository;

    @CrossOrigin(origins = "http://localhost:8082")
    @PostMapping(path = "/findstudentid")
    public @ResponseBody String findStudentByUserId(@RequestParam String userid) {
        Iterable<Student> result = studentRepository.getByUserid(userid);
        StringBuilder response = new StringBuilder();
        for (Student student : result) {
            response.append(student.toString()).append(", ");
        }
        if (!response.isEmpty()) {
            response.setLength(response.length() - 2);
        }
        out.println(response.toString());
        return response.toString();
    }

//    @GetMapping(path = "/all")
//    public @ResponseBody Iterable<Student> getAllStudent() {
//        // This returns a JSON or XML with the users
//        return studentRepository.findAll();
//    }
    @CrossOrigin(origins = "http://localhost:8082")
    @PostMapping(path = "/all")
    public @ResponseBody String getAllStudent() {
        Iterable<Student> result = studentRepository.findAll();
        StringBuilder response = new StringBuilder();
        response.append('[');
        for (Student student : result) {
            response.append(student.toString()).append(", ");
        }
        if (!response.isEmpty()) {
            response.setLength(response.length() - 2);
        }
        response.append(']');
        out.println(response.toString());
        return response.toString();
    }
//    初始化学生选课，运行该接口即可
//    @GetMapping(path = "/selectcourse")
//    public @ResponseBody void getAllGrade() {
//        // This returns a JSON or XML with the users
//        Iterable<Student> students =  studentRepository.findAll();
//        Iterable<Myclass> classes = classRepository.findAll();
//        int a = 1;
//        Long gradeid= 0L;
//        Random random = new Random();
//        int min = 60; // 最小值
//        int max = 100; // 最大值
//        for(Student student:students){
//            int classid = 0;
//            for(Myclass myclass:classes){
//                classid++;
//                if(classid%2==a){
//                    Grade grade = new Grade();
////                    grade.setId(gradeid);
//                    gradeid =gradeid+1;
//                    grade.setStudentId(student.getStudentId());
//                    grade.setClassId(myclass.getClassId());
//                    grade.setAttendanceGrade(random.nextInt(max - min + 1) + min);
//                    grade.setMidtermGrade(random.nextInt(max - min + 1) + min);
//                    grade.setLabGrade(random.nextInt(max - min + 1) + min);
//                    grade.setFinalGrade(random.nextInt(max - min + 1) + min);
//                    grade.setComprehensiveGrade();
//                    gradeRepository.save(grade);
//                }
//            }
//            a = (a==1)?0:1;
//        }
//    }
}
