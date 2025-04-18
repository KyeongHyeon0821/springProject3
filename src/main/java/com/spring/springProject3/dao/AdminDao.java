package com.spring.springProject3.dao;

import org.apache.ibatis.annotations.Param;

import com.spring.springProject3.vo.ComplaintVo;

public interface AdminDao {

	int setMemberLevelChange(@Param("level") int level,@Param("idx") int idx);

	void setMemberLevelSelectCheck(@Param("idx") int idx,@Param("level") int levelSelect);

	int setBoardComplaintInput(@Param("vo") ComplaintVo vo);

	void setBoardTableComplaintOk(@Param("partidx") int partIdx);

}
