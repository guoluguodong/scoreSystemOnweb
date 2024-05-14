package com.example.accessingdatamysql.entity;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;

@Entity
public class Teacher {
	@Id
	private String teacherid;

	private String userid;

	private String name;

	public String getTeacherId() {
		return teacherid;
	}

	public void setTeacherId(String teacherid) {
		this.teacherid = teacherid;
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
	@Override
	public String toString() {
		return "{" +
				"\"teacherid\":\"" + teacherid + "\"" +
				", \"userid\":\"" + userid + "\"" +
				", \"name\":\"" + name + "\"" +
				'}';
	}
}

