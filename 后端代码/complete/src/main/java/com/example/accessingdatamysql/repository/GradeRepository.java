package com.example.accessingdatamysql.repository;

import com.example.accessingdatamysql.entity.Grade;
import com.example.accessingdatamysql.entity.User;
import org.springframework.data.repository.CrudRepository;

// This will be AUTO IMPLEMENTED by Spring into a Bean called userRepository
// CRUD refers Create, Read, Update, Delete

public interface GradeRepository extends CrudRepository<Grade, Long> {
    Iterable<Grade> getByStudentid(String studentid);
    Iterable<Grade> getByClassid(String classid);
    Iterable<Grade> getByStudentidAndClassid(String studentid,String classid);
}
