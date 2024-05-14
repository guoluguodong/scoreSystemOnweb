package com.example.accessingdatamysql.entity;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;

@Entity
public class Student {
    @Id
    private String studentid;

    private String userid;

    private String name;

    private int grade;

    private double averagescore;

    private int ranking;

    public String getStudentId() {
        return studentid;
    }

    public void setStudentId(String studentid) {
        this.studentid = studentid;
    }

    public String getUserId() {
        return userid;
    }

    public void setUserId(String userid) {
        this.userid = userid;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getGrade() {
        return grade;
    }

    public void setGrade(int grade) {
        this.grade = grade;
    }

    public double getAverageScore() {
        return averagescore;
    }

    public void setAverageScore(double averagescore) {
        this.averagescore = averagescore;
    }

    public int getRanking() {
        return ranking;
    }

    public void setRanking(int ranking) {
        this.ranking = ranking;
    }
    @Override
    public String toString() {
        return "{" +
                "\"studentid\":\"" + studentid + "\"" +
                ", \"userid\":\"" + userid + "\"" +
                ", \"name\":\"" + name + "\"" +
                ", \"grade\":" + grade +
                ", \"averagescore\":" + averagescore +
                ", \"ranking\":" + ranking +
                '}';
    }
}
