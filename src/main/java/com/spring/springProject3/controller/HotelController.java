package com.spring.springProject3.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;

import com.spring.springProject3.service.HotelService;
import com.spring.springProject3.vo.HotelVo;

@RequestMapping("/hotel")
@Controller
public class HotelController {

	@Autowired
	HotelService hotelService;
	
	// 호텔 리스트
	@RequestMapping("/hotelList")
	public String hotelListGet(Model model) {
		List<HotelVo> vos = hotelService.getHotelList();
		model.addAttribute("vos", vos);
		return "hotel/hotelList";
	}
	
	// 호텔 등록폼 보기
	@RequestMapping(value =  "/hotelInput", method = RequestMethod.GET)
	public String hotelInputGet() {
		return "hotel/hotelInput";
	}
	
	// 호텔 등록 처리하기
	@RequestMapping(value =  "/hotelInput", method = RequestMethod.POST)
	public String hotelInputPost(@Validated HotelVo vo, BindingResult bindingResult, MultipartFile thumbnailFile) {
		// 백엔드 체크 에러 발생 시 처리
		if(bindingResult.hasErrors()) {
			System.out.println("에러 내용 : " + bindingResult);
			return "redirect:/message/hotelInputError";
		}
	  // 썸네일 파일 null 또는 비었을 때 처리
	  if(thumbnailFile == null || thumbnailFile.isEmpty()) {
	    System.out.println("썸네일 파일이 비어있습니다.");
	    return "redirect:/message/hotelInputError";
	  }
	  int res = hotelService.setHotelInput(vo, thumbnailFile);
		if(res !=0 ) return "redirect:/message/hotelInputOk";
		
		return "redirect:/message/hotelInputNo";
	}
	
	// 호텔 등록 - ckeditor에서의 그림 파일 업로드시 수행처리되는 메소드 
	@RequestMapping(value =  "/hotelImageUpload")
	public void imageUploadGet(MultipartFile upload, HttpServletRequest request, HttpServletResponse response, String mid) throws IOException {
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/imagesTemp/");
		String oFileName = upload.getOriginalFilename(); // 원본 파일 이름 가져오기
		
		// 파일 확장자 제한 처리
		String ext = oFileName.substring(oFileName.lastIndexOf(".") + 1).toLowerCase();
		if (!(ext.equals("jpg") || ext.equals("gif") || ext.equals("png") || ext.equals("jpeg") || ext.equals("webp"))) {
		    PrintWriter out = response.getWriter();
		    out.println("{\"uploaded\":0,\"error\":{\"message\":\"업로드 가능한 파일은 jpg, jpeg, png, gif, webp 형식만 가능합니다.\"}}");
		    out.flush();
		    return; 
		}
		
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyMMddHHmmss");
		
		String sFileName = mid + "_" + sdf.format(date) + "_" + oFileName; // 호텔 등록자 아이디 + "_" + 날짜 + "_" + oFileName;
		
		byte[] bytes = upload.getBytes();
		FileOutputStream fos = new FileOutputStream(new File(realPath + sFileName)); // 실제 경로에 파일 저장
		fos.write(bytes);
		
		PrintWriter out = response.getWriter();
		String fileUrl = request.getContextPath() + "/data/imagesTemp/" + sFileName;  // 매핑 경로
		out.println("{\"originalFilename\":\""+oFileName+"\",\"uploaded\":1,\"url\":\""+fileUrl+"\"}");
		out.flush();
		
		fos.close();
	}
	
	
	// 호텔 상세페이지 보기
	@RequestMapping(value =  "/hotelDetail", method = RequestMethod.GET)
	public String hotelDetailGet(Model model, int idx) {
		HotelVo vo = hotelService.getHotel(idx);
		model.addAttribute("vo", vo);
		return "hotel/hotelDetail";
	}
	
	// 호텔 수정 페이지 보기
	@RequestMapping(value =  "/hotelUpdate", method = RequestMethod.GET)
	public String hotelUpdateGet(Model model, int idx) {
		HotelVo vo = hotelService.getHotel(idx);
		model.addAttribute("vo", vo);
		return "hotel/hotelUpdate";
	}
	
	
}
