package com.spring.springProject3.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.springProject3.dao.AdminDao;

@Service
public class AdminServiceImpl implements AdminService {
	
	@Autowired
	AdminDao adminDao;

	@Override
	public int setMemberLevelChange(int level, int idx) {
		return adminDao.setMemberLevelChange(level, idx);
	}

	@Override
	public String setMemberLevelSelectCheck(String idxSelectArray, int levelSelect) {
		String[] idxSelectArrays = idxSelectArray.split("/");
		
		String str = "0";
		for(String idx : idxSelectArrays) {
			adminDao.setMemberLevelSelectCheck(Integer.parseInt(idx), levelSelect);
			str="1";
		}
		return "str";
	}
}
