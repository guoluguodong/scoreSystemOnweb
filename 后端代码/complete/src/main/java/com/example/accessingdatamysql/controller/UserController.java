package com.example.accessingdatamysql.controller;

import com.example.accessingdatamysql.entity.Student;
import com.example.accessingdatamysql.entity.Teacher;
import com.example.accessingdatamysql.entity.User;
import com.example.accessingdatamysql.repository.StudentRepository;
import com.example.accessingdatamysql.repository.TeacherRepository;
import com.example.accessingdatamysql.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.Objects;
import java.util.Optional;

import static java.lang.System.out;

@Controller    // This means that this class is a Controller
@RequestMapping(path = "/demo") // This means URL's start with /demo (after Application path)
public class UserController {
    @Autowired
    private UserRepository userRepository;
    @Autowired
    private StudentRepository studentRepository;
    @Autowired
    private TeacherRepository teacherRepository;

    @CrossOrigin(origins = "http://localhost:8082")
    @PostMapping(path = "/signup")
    public @ResponseBody String addNewUser(@RequestParam String userid, @RequestParam String password, @RequestParam String accounttype, @RequestParam String id) {
        out.println("注册：" + userid + password + accounttype);
        if (accounttype.equals("student")) {
            Optional<Student> optionalStudent = studentRepository.findById(id);
            if (optionalStudent.isPresent()) {
                Student student = optionalStudent.get();
                student.setUserId(userid);
                studentRepository.save(student);
                User n = new User();
                n.setUserid(userid);
                n.setPassword(password);
                n.setAccountType(accounttype);
                userRepository.save(n);
                return "注册成功";
            } else {
                return "没有此学工号";
            }
        } else if (accounttype.equals("teacher")) {
            Optional<Teacher> optionalTeacher = teacherRepository.findById(id);
            if (optionalTeacher.isPresent()) {
                Teacher teacher = optionalTeacher.get();
                teacher.setUserId(userid);
                teacherRepository.save(teacher);
                User n = new User();
                n.setUserid(userid);
                n.setPassword(password);
                n.setAccountType(accounttype);
                userRepository.save(n);
                return "注册成功";
            } else {
                return "没有此学工号";
            }
        } else if (accounttype.equals("officer")) {
            User n = new User();
            n.setUserid(userid);
            n.setPassword(password);
            n.setAccountType(accounttype);
            userRepository.save(n);
            return "注册成功";
        }
        return "注册失败";
    }

    @CrossOrigin(origins = "http://localhost:8082")
    @PostMapping(path = "/close")
    public @ResponseBody String deleteUser(@RequestParam String userid, @RequestParam String password, @RequestParam String accounttype, @RequestParam String id) {
        out.println("注销：" + userid + password + accounttype);
        Optional<User> result = userRepository.findById(userid);
        User user = result.orElse(null);
        if (user != null && Objects.equals(user.getPassword(), password)) {
            switch (accounttype) {
                case "student" -> {
                    Optional<Student> optionalStudent = studentRepository.findById(id);
                    if (optionalStudent.isPresent()) {
                        Student student = optionalStudent.get();
                        student.setUserId("");
                        studentRepository.save(student);
                        userRepository.deleteById(userid);
                        return "销户成功";
                    } else {
                        return "没有此学工号";
                    }
                }
                case "teacher" -> {
                    Optional<Teacher> optionalTeacher = teacherRepository.findById(id);
                    if (optionalTeacher.isPresent()) {
                        Teacher teacher = optionalTeacher.get();
                        teacher.setUserId("");
                        teacherRepository.save(teacher);
                        userRepository.deleteById(userid);
                        return "销户成功";
                    } else {
                        return "没有此学工号";
                    }
                }
                case "officer" -> {
                    userRepository.deleteById(userid);
                    return "销户成功";
                }
            }
        }
        return "注销失败";
    }

    @CrossOrigin(origins = "http://localhost:8082")
    @PostMapping(path = "/login") // Map ONLY GET Requests
    public @ResponseBody String loginPage(@RequestParam String userid, @RequestParam String password) {
        Optional<User> result = userRepository.findById(userid);
        User user = result.orElse(null);
        if (user != null && Objects.equals(user.getPassword(), password)) {
            return user.getAccountType();
        }
        return "密码错误";
    }

    @GetMapping(path = "/all")
    public @ResponseBody Iterable<User> getAllUser() {
        // This returns a JSON or XML with the users
        return userRepository.findAll();
    }
}
