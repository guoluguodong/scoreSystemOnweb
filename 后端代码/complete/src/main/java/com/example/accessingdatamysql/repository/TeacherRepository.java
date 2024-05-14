package com.example.accessingdatamysql.repository;

import com.example.accessingdatamysql.entity.Student;
import com.example.accessingdatamysql.entity.Teacher;
import com.example.accessingdatamysql.entity.User;
import org.springframework.data.repository.CrudRepository;

// This will be AUTO IMPLEMENTED by Spring into a Bean called userRepository
// CRUD refers Create, Read, Update, Delete

public interface TeacherRepository extends CrudRepository<Teacher, String> {
    Iterable<Teacher> getByUserid(String userid);
}
