package com.example.accessingdatamysql.repository;

import com.example.accessingdatamysql.entity.Course;
import com.example.accessingdatamysql.entity.Teacher;
import org.springframework.data.repository.CrudRepository;

// This will be AUTO IMPLEMENTED by Spring into a Bean called userRepository
// CRUD refers Create, Read, Update, Delete

public interface CourseRepository extends CrudRepository<Course, String> {

}
