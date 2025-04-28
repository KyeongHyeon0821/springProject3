package com.spring.springProject3.service;

import java.util.List;

import com.spring.springProject3.vo.HotelVo;
import com.spring.springProject3.vo.ReservationListVo;
import com.spring.springProject3.vo.ReviewVo;
import com.spring.springProject3.vo.RoomVo;

public interface ReviewService {

	List<ReservationListVo> getRoomUsedList(String mid);

	int setReviewInputOk(ReviewVo vo, String mid, String nickName);

	ReservationListVo getRoomIdxCheck(int roomIdx, String mid);

	List<ReviewVo> getRoomReviewList(int roomIdx);


}
