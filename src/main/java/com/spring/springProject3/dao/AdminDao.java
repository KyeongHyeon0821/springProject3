package com.spring.springProject3.dao;

import org.apache.ibatis.annotations.Param;

import com.spring.springProject3.vo.ComplaintVo;

public interface AdminDao {

	int setBoardComplaintInput(@Param("vo") ComplaintVo vo);

	void setBoardTableComplaintOk(@Param("partidx") int partIdx);

}
