package com.example.accessingdatamysql.entity;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;

@Entity // This tells Hibernate to make a table out of this class
public class User {
	@Id
	private String userid;

	private String accounttype;

	private String password;

	public String getUserid() {
		return userid;
	}

	public void setUserid(String userId) {
		this.userid = userId;
	}

	public String getAccountType() {
		return accounttype;
	}

	public void setAccountType(String accountType) {
		this.accounttype = accountType;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}
	@Override
	public String toString() {
		return "{" +
				"\"userid\":\"" + userid + "\"" +
				", \"accounttype\":\"" + accounttype + "\"" +
				", \"password\":\"" + password + "\"" +
				'}';
	}
}
