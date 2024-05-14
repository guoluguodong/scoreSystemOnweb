package com.example.accessingdatamysql.entity;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;

@Entity
public class Course {
    @Id
    private String courseid;

    private String coursename;

    public String getCourseId() {
        return courseid;
    }

    public void setCourseId(String courseid) {
        this.courseid = courseid;
    }

    public String getCourseName() {
        return coursename;
    }

    public void setCourseName(String coursename) {
        this.coursename = coursename;
    }

    @Override
    public String toString() {
        return "{" +
                "\"courseid\":\"" + courseid + "\"" +
                ", \"coursename\":\"" + coursename + "\"" +
                '}';
    }

}
