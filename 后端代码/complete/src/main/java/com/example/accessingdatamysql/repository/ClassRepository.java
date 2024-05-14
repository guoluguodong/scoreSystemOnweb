package com.example.accessingdatamysql.repository;

import com.example.accessingdatamysql.entity.Course;
import com.example.accessingdatamysql.entity.Myclass;
import org.springframework.data.repository.CrudRepository;

// This will be AUTO IMPLEMENTED by Spring into a Bean called userRepository
// CRUD refers Create, Read, Update, Delete

public interface ClassRepository extends CrudRepository<Myclass, String> {
    Iterable<Myclass> getByTeacherid(String teacherid);
}
