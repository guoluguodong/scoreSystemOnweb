package com.example.accessingdatamysql.controller;

import com.example.accessingdatamysql.entity.Grade;
import com.example.accessingdatamysql.entity.Student;
import com.example.accessingdatamysql.entity.User;
import com.example.accessingdatamysql.repository.GradeRepository;
import com.example.accessingdatamysql.repository.StudentRepository;
import com.example.accessingdatamysql.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.Optional;

import static java.lang.System.out;

@Controller    // This means that this class is a Controller
@RequestMapping(path = "/grade") // This means URL's start with /demo (after Application path)
public class GradeController {
    @Autowired // This means to get the bean called userRepository
    // Which is auto-generated by Spring, we will use it to handle the data
    private GradeRepository gradeRepository;
    @Autowired
    private StudentRepository studentRepository;
    @CrossOrigin(origins = "http://localhost:8082")
    @PostMapping(path = "/findgradebystudentid")
    public @ResponseBody String findGradeByStudentId(@RequestParam String studentid) {
        studentid = studentid.replace("'", "");
        Iterable<Grade> result = gradeRepository.getByStudentid(studentid);
        StringBuilder response = new StringBuilder();

        for (Grade grade : result) {
            response.append(grade.toString()).append(", ");
        }
        if (!response.isEmpty()) {
            response.setLength(response.length() - 2);
        }
        out.println(response.toString());
        return '[' + response.toString() + ']';
    }
    @CrossOrigin(origins = "http://localhost:8082")
    @PostMapping(path = "/findgradebycourse")
    public @ResponseBody String findGradeByClassId(@RequestParam String classid) {
        out.println("ClassId:"+classid);
        Iterable<Grade> result = gradeRepository.getByClassid(classid);

        StringBuilder response = new StringBuilder();

        for (Grade grade : result) {
            Optional<Student> student = studentRepository.findById(grade.getStudentId());
            if(student.isPresent()){
                String studentname = student.get().getName();
                String record = grade.toString().replace("}","")
                        +", " + "\"studentname\":\"" + studentname + "\"}"+", ";
                response.append(record);
            }

        }
        if (!response.isEmpty()) {
            response.setLength(response.length() - 2);
        }
        out.println(response.toString());
        return '[' + response.toString() + ']';
    }

    @GetMapping(path = "/all")
    public @ResponseBody Iterable<Grade> getAllUser() {
        // This returns a JSON or XML with the users
        return gradeRepository.findAll();
    }
}
