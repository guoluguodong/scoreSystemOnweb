package com.example.accessingdatamysql.entity;

import jakarta.persistence.*;

@Entity
public class Grade {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    Long id;

    private String studentid;
    private String classid;
    private double attendancegrade = 0;

    private double midtermgrade;

    private double labgrade;

    private double finalgrade;

    private double comprehensivegrade;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getStudentId() {
        return studentid;
    }

    public void setStudentId(String studentid) {
        this.studentid = studentid;
    }

    public String getClassId() {
        return classid;
    }

    public void setClassId(String classid) {
        this.classid = classid;
    }

    public double getAttendanceGrade() {
        return attendancegrade;
    }

    public void setAttendanceGrade(double attendancegrade) {
        this.attendancegrade = attendancegrade;
    }

    public double getMidtermGrade() {
        return midtermgrade;
    }

    public void setMidtermGrade(double midtermgrade) {
        this.midtermgrade = midtermgrade;
    }

    public double getLabGrade() {
        return labgrade;
    }

    public void setLabGrade(double labgrade) {
        this.labgrade = labgrade;
    }

    public double getFinalGrade() {
        return finalgrade;
    }

    public void setFinalGrade(double finalgrade) {
        this.finalgrade = finalgrade;
    }

    public double getComprehensiveGrade() {
        return comprehensivegrade;
    }

    public void setComprehensiveGrade()
    {
        this.comprehensivegrade = (attendancegrade+midtermgrade+labgrade+finalgrade)/4;
    }

    @Override
    public String toString() {
        return "{" +
                "\"id\":" + id +
                ", \"studentid\":\"" + studentid  +"\""+
                ", \"classid\":\"" + classid + "\""+
                ", \"attendancegrade\":" + attendancegrade +
                ", \"midtermgrade\":" + midtermgrade +
                ", \"labgrade\":" + labgrade +
                ", \"finalgrade\":" + finalgrade +
                ", \"comprehensivegrade\":" + comprehensivegrade +
                '}';
    }
}
