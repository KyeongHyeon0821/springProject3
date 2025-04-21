package com.spring.springProject3.service;

import com.spring.springProject3.vo.ComplaintVo;

public interface AdminService {


	int setBoardComplaintInput(ComplaintVo vo);

	void setBoardTableComplaintOk(int partIdx);
	
	
}
