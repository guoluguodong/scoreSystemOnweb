package com.example.accessingdatamysql.controller;

import com.example.accessingdatamysql.entity.Course;
import com.example.accessingdatamysql.entity.Grade;
import com.example.accessingdatamysql.entity.Myclass;
import com.example.accessingdatamysql.repository.ClassRepository;
import com.example.accessingdatamysql.repository.CourseRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import static java.lang.System.out;

@Controller    // This means that this class is a Controller
@RequestMapping(path = "/class") // This means URL's start with /demo (after Application path)
public class ClassController {
    @Autowired // This means to get the bean called userRepository
    // Which is auto-generated by Spring, we will use it to handle the data
    private ClassRepository classRepository;

    @CrossOrigin(origins = "http://localhost:8082")
    @PostMapping(path = "/findmyclassbyteacherid")
    public @ResponseBody String findMyclassByTeacherid(@RequestParam String teacherid) {
        teacherid = teacherid.replace("'", "");
        Iterable<Myclass> result = classRepository.getByTeacherid(teacherid);
        StringBuilder response = new StringBuilder();

        for (Myclass myclass : result) {
            response.append(myclass.toString()).append(", ");
        }
        if (!response.isEmpty()) {
            response.setLength(response.length() - 2);
        }
        out.println(response.toString());
        return '[' + response.toString() + ']';
    }

    @CrossOrigin(origins = "http://localhost:8082")
    @PostMapping(path = "/all")
    public @ResponseBody String getAllClass() {
        Iterable<Myclass> result = classRepository.findAll();
        StringBuilder response = new StringBuilder();
        response.append('[');
        for (Myclass myclass : result) {
            response.append(myclass.toString()).append(", ");
        }
        if (!response.isEmpty()) {
            response.setLength(response.length() - 2);
        }
        response.append(']');
        out.println(response.toString());
        return response.toString();
    }

    @CrossOrigin(origins = "http://localhost:8082")
    @PostMapping(path = "/addclass")
    public @ResponseBody String addClass(String classid, String courseid, String teacherid) {
        Myclass myclass = new Myclass();
        myclass.setClassId(classid);
        myclass.setCourseId(courseid);
        myclass.setTeacherId(teacherid);
        myclass.setTotalStudents(0);
        classRepository.save(myclass);
        return "saved";
    }

    @CrossOrigin(origins = "http://localhost:8082")
    @PostMapping(path = "/deleteclass")
    public @ResponseBody String deleteClass(String classid) {
        classRepository.deleteById(classid);
        return "deleted";
    }
}
