package com.spring.springProject3.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.springProject3.dao.ReviewDao;
import com.spring.springProject3.vo.HotelVo;
import com.spring.springProject3.vo.ReservationListVo;
import com.spring.springProject3.vo.ReviewVo;
import com.spring.springProject3.vo.RoomVo;

@Service
public class ReviewServiceImpl implements ReviewService {

	@Autowired
	ReviewDao reviewDao;

	@Override
	public List<ReservationListVo> getRoomUsedList(String mid) {
		return reviewDao.getRoomUsedList(mid);
	}

	@Override
	public int setReviewInputOk(ReviewVo vo, String mid, String nickName) {
		return reviewDao.setReviewInputOk(vo, mid, nickName);
	}

	@Override
	public ReservationListVo getRoomIdxCheck(int roomIdx, String mid) {
		return reviewDao.getRoomIdxCheck(roomIdx, mid);
	}

	@Override
	public List<ReviewVo> getRoomReviewList(int roomIdx) {
		return reviewDao.getRoomReviewList(roomIdx);
	}
}
