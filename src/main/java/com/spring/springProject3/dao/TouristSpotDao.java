package com.spring.springProject3.dao;

import org.apache.ibatis.annotations.Param;
import com.spring.springProject3.vo.TouristSpotVo;

public interface TouristSpotDao {

	TouristSpotVo getSpotsNearHotel(@Param("lat") String lat, @Param("lng") String lng);
}
