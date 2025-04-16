package com.spring.springProject3.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.springProject3.dao.MemberDao;
import com.spring.springProject3.vo.MemberVo;

@Service
public class MemberServiceImpl implements MemberService {

	@Autowired
	MemberDao memberDao;

	@Override
	public List<MemberVo> getMemberList() {
		return memberDao.getMemberList();
	}

	@Override
	public MemberVo getMemberIdxSearch(int idx) {
		return memberDao.getMemberIdxSearch(idx);
	}
}
