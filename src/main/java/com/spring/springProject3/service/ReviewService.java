package com.spring.springProject3.service;

import java.util.List;

import com.spring.springProject3.vo.HotelVo;
import com.spring.springProject3.vo.ReservationListVo;
import com.spring.springProject3.vo.ReviewVo;
import com.spring.springProject3.vo.RoomVo;

public interface ReviewService {

	List<ReservationListVo> getRoomUsedList(String mid);

	int setReviewInputOk(ReviewVo vo);

	ReservationListVo getRoomIdxCheck(int roomIdx, String mid);

	List<ReviewVo> getRoomReviewList(int roomIdx);

	List<Integer> getReviewTotCount(List<Integer> hotelIdx);

	List<ReviewVo> getRoomReviewAllList();

	List<ReservationListVo> getRoomUsedAllList(int startIndexNo, int pageSize, String choice, String mid);

	List<Integer> getExistReviewedCheck(String mid);

	int setReviewDelete(ReviewVo vo);

	int setReviewUpdateCheckOk(ReviewVo vo);

	void setReviewStatusBack(ReviewVo vo);


}
