package com.example.accessingdatamysql.repository;

import com.example.accessingdatamysql.entity.Student;
import com.example.accessingdatamysql.entity.Teacher;
import org.springframework.data.repository.CrudRepository;

import java.util.Optional;

// This will be AUTO IMPLEMENTED by Spring into a Bean called userRepository
// CRUD refers Create, Read, Update, Delete

public interface StudentRepository extends CrudRepository<Student, String> {
    Iterable<Student> getByUserid(String userid);

    @Override
    Optional<Student> findById(String s);
}
