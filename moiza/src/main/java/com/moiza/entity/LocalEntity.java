package com.moiza.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "local")
public class LocalEntity  {
   
	@Id // 데이터베이스 테이블의 기본 키(PK)와 객체의 필드를 매핑시켜주는 어노테이션입니다.
	@GeneratedValue(strategy = GenerationType.IDENTITY) // 기본 키를 자동 생성해주는 어노테이션입니다.
	@Column(name = "local_index")
	private int local_index;
	private String local_name;
	
	public LocalEntity() {}
	
	@Override
	public String toString() {
		return "LocalEntity [local_index=" + local_index + ", local_name=" + local_name + "]";
	}

	public int getLocal_index() {
		return local_index;
	}

	public void setLocal_index(int local_index) {
		this.local_index = local_index;
	}

	public String getLocal_name() {
		return local_name;
	}

	public void setLocal_name(String local_name) {
		this.local_name = local_name;
	}
	
	
	
	
}