package com.spring.springProject3.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.springProject3.vo.HotelVo;
import com.spring.springProject3.vo.ReservationListVo;
import com.spring.springProject3.vo.ReviewVo;

public interface ReviewDao {

	List<ReservationListVo> getRoomUsedList(@Param("mid") String mid);

	int setReviewInputOk(@Param("vo") ReviewVo vo);

	ReservationListVo getRoomIdxCheck(@Param("roomIdx") int roomIdx,@Param("mid") String mid);

	List<ReviewVo> getRoomReviewList(@Param("roomIdx") int roomIdx);

	List<Integer> getReviewTotCount(@Param("hotelIdx") List<Integer> hotelIdx);

	List<ReviewVo> getRoomReviewAllList();

	List<ReservationListVo> getRoomUsedAllList(@Param("mid") String mid);


}
