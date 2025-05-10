package com.spring.springProject3.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.springProject3.vo.CouponVO;

public interface CouponDAO {

	int getTotRecCnt(@Param("couponType") String couponType, @Param("couponActive") int couponActive);
	
	List<CouponVO> getCouponList(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize, @Param("couponType") String couponType, @Param("couponActive") int couponActive);

	int setCouponInput(@Param("vo") CouponVO vo);

	CouponVO getCouponContent(@Param("idx") int idx);

	int setCouponUpdate(@Param("vo") CouponVO vo);

	int setCouponDeleteCheck(@Param("idx") int idx);

	List<CouponVO> getUseCouponList();

	int setCouponUserInformation(@Param("vo") CouponVO vo);

	List<CouponVO> getCouponCodeList(@Param("couponCode") String couponCode);

	List<CouponVO> getCouponMidList(@Param("mid") String mid);

	int setUserCouponCodeUsed(@Param("userCouponCode") String userCouponCode);

}
