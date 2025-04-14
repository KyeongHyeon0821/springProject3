package com.spring.springProject3.service;

import java.util.List;

import com.spring.springProject3.vo.MemberVo;

public interface MemberService {

	List<MemberVo> getMemberList();

	MemberVo getMemberIdxSearch(int idx);

}
