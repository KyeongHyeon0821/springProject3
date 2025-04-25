package com.spring.springProject3.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.springProject3.dao.ReviewDao;
import com.spring.springProject3.vo.ReservationListVo;
import com.spring.springProject3.vo.RoomVo;

@Service
public class ReviewServiceImpl implements ReviewService {

	@Autowired
	ReviewDao reviewDao;

	@Override
	public List<ReservationListVo> getRoomUsedList(String mid) {
		return reviewDao.getRoomUsedList(mid);
	}
}
