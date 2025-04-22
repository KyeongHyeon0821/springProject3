package com.spring.springProject3.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.springProject3.vo.FaqVo;

public interface FaqDao {

	List<FaqVo> getFaqList(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize, @Param("choice") String choice);
	

	int setAdFaqInputOk(@Param("vo") FaqVo vo);

}
