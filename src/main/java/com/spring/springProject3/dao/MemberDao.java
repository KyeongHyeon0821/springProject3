package com.spring.springProject3.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.springProject3.vo.MemberVo;

public interface MemberDao {

	List<MemberVo> getMemberList();

	MemberVo getMemberIdxSearch(@Param("idx") int idx);

}
