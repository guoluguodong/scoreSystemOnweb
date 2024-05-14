package com.example.accessingdatamysql.entity;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;

@Entity
public class Myclass {
    @Id
    private String classid;

    private String teacherid;

    private String courseid;

    private int totalstudents = 0;

    public String getClassId() {
        return classid;
    }

    public void setClassId(String classid) {
        this.classid = classid;
    }

    public String getTeacherId() {
        return teacherid;
    }

    public void setTeacherId(String teacherid) {
        this.teacherid = teacherid;
    }

    public String getCourseId() {
        return courseid;
    }

    public void setCourseId(String courseid) {
        this.courseid = courseid;
    }

    public int getTotalStudents() {
        return totalstudents;
    }

    public void setTotalStudents(int totalstudents) {
        this.totalstudents = totalstudents;
    }
    @Override
    public String toString() {
        return "{" +
                "\"classid\":\"" + classid + "\"" +
                ", \"teacherid\":\"" + teacherid + "\"" +
                ", \"courseid\":\"" + courseid + "\"" +
                ", \"totalstudents\":" + totalstudents +
                '}';
    }
}
