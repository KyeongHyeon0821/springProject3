package com.spring.springProject3.service;

import com.spring.springProject3.vo.ComplaintVo;

public interface AdminService {

	int setMemberLevelChange(int level, int idx);

	String setMemberLevelSelectCheck(String idxSelectArray, int levelSelect);

	int setBoardComplaintInput(ComplaintVo vo);

	void setBoardTableComplaintOk(int partIdx);
	
	
}
