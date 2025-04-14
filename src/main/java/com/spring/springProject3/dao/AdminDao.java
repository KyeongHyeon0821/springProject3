package com.spring.springProject3.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.springProject3.vo.InquiryVo;

public interface AdminDao {

	List<InquiryVo> getInquiryList(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize);

	int getInquiryTotRecCnt(@Param("choice") String choice);

	List<InquiryVo> getInquiryList(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize, @Param("choice") String choice);

}
