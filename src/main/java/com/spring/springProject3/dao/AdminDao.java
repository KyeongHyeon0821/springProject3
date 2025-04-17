package com.spring.springProject3.dao;

import org.apache.ibatis.annotations.Param;

public interface AdminDao {

	int setMemberLevelChange(@Param("level") int level,@Param("idx") int idx);

	void setMemberLevelSelectCheck(@Param("idx") int idx,@Param("level") int levelSelect);

}
