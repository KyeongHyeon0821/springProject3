package com.spring.springProject3.common;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.RandomStringUtils;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;

import com.google.zxing.BarcodeFormat;
import com.google.zxing.WriterException;
import com.google.zxing.client.j2se.MatrixToImageConfig;
import com.google.zxing.client.j2se.MatrixToImageWriter;
import com.google.zxing.common.BitMatrix;
import com.google.zxing.qrcode.QRCodeWriter;

@Service
public class ProjectProvide {

	// 파일 저장하는 메소드 (업로드파일명, 저장파일명, 저장경로)
	public void writeFile(MultipartFile fName, String sFileName, String urlPath) throws IOException {
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/"+urlPath+"/");
		
		FileOutputStream fos = new FileOutputStream(realPath + sFileName);
		
		if(fName.getBytes().length != -1) {
			fos.write(fName.getBytes());
		}
		fos.flush();
		fos.close();
	}

	// 파일 삭제처리
	public void deleteFile(String photo, String urlPath) {
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/"+urlPath+"/");
		
		File file = new File(realPath + photo);
		if(file.exists()) file.delete();
	}

	// 파일명 중복방지를 위한 처리1
	public String saveFileName(String oFileName) {
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyMMddHHmmss");
		return sdf.format(date) + "_" + oFileName;
	}
	
	// 파일명 중복방지를 위한 처리2
	public String newNameCreate(int len) {
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyMMddHHmm");
		String newName = sdf.format(date);
		newName += RandomStringUtils.randomAlphanumeric(len) + "_";
		return newName;
	}

	// QR Code 생성하기
	public void qrCodeCreate(String qrCodeName, String qrCodeImage, String urlPath) {
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/"+urlPath+"/");
		
		try {
			qrCodeImage = new String(qrCodeImage.getBytes("UTF-8"), "ISO-8859-1");
			
			QRCodeWriter qrCodeWriter = new QRCodeWriter();
			BitMatrix bitMatrix = qrCodeWriter.encode(qrCodeImage, BarcodeFormat.QR_CODE, 200, 200);
			
			int qrCodeColor = 0xFF000000;
			int qrCodeBackColor = 0xFFFFFFFF;
			
			MatrixToImageConfig matrixToImageConfig = new MatrixToImageConfig(qrCodeColor, qrCodeBackColor);
			BufferedImage bufferedImage = MatrixToImageWriter.toBufferedImage(bitMatrix, matrixToImageConfig);
			
			ImageIO.write(bufferedImage, "png", new File(realPath + qrCodeName + ".png"));
		} catch (IOException e) {
			e.printStackTrace();
		} catch (WriterException e) {
			e.printStackTrace();
		}
	}

	public static void imagesDelete(String content, String string) {
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/"+string+"/");
		
		File file = new File(realPath + content);
		if(file.exists()) file.delete();
		
	}

  // 1.공통으로 사용하는 ckeditor폴더(aFlag)에 임시그림파일 저장후 실제 저장할폴더(qna)로 복사하기(사용될 실제 파일이 저장될 경로를 bFlag에 받아온다.)
 // 2.실제로 저장된 폴더(qna(aFlag))에서, 공통으로 사용하는 ckeditor폴더(bFlag)에 그림파일을 복사하기
  public void imgCheck(String content, String aFlag, String bFlag) {
     //      0         1         2         3    3    4         5         6
     //      01234567890123456789012345678901234567890123456789012345678901234567890
     // <img src="/springProject3/data/ckeditor/240111121324_green2209J_06.jpg" style="height:967px; width:1337px" /></p>
     // <img src="/springProject3/data/qna/240111121324_green2209J_06.jpg" style="height:967px; width:1337px" /></p>
   // content안에 그림파일이 존재할때만 작업을 수행 할수 있도록 한다.(src="/_____~~)
     if(content.indexOf("src=\"/") == -1) return;
     
     HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
     //String realPath = request.getSession().getServletContext().getRealPath("/resources/data/ckeditor/");
     String realPath = request.getSession().getServletContext().getRealPath("/resources/data/");
     
     int position = 0;
     if(aFlag.equals("ckeditor")) position = 35;
     else if(aFlag.equals("qna")) position = 30;
     String nextImg = content.substring(content.indexOf("src=\"/") + position);
     boolean sw = true;
     
     while(sw) {
        String imgFile = nextImg.substring(0, nextImg.indexOf("\""));
        
        String origFilePath = realPath + aFlag + "/" + imgFile;
        String copyFilePath = realPath + bFlag + "/" + imgFile;
        
        fileCopyCheck(origFilePath, copyFilePath);  // __폴더에 파일을 복사하고자 한다.
        
        if(nextImg.indexOf("src=\"/") == -1) {
           sw = false;
        }
        else {
           nextImg = nextImg.substring(nextImg.indexOf("src=\"/") + position);
        }
     }
  }

	private static void fileCopyCheck(String origFilePath, String copyFilePath) {
		try {
			FileInputStream fis = new FileInputStream(new File(origFilePath));
			FileOutputStream fos = new FileOutputStream(new File(copyFilePath));
			
			byte[] b = new byte[2048];
			int cnt = 0;
			while((cnt = fis.read(b)) != -1) {
				fos.write(b, 0, cnt);
			}
			fos.flush();
			fos.close();
			fis.close();
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
	}

	public void imgBackup(String content) {
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/");
		
		int position = 35;
		String nextImg = content.substring(content.indexOf("src=\"/") + position);
		boolean sw = true;
		
		while(sw) {
			String imgFile = nextImg.substring(0, nextImg.indexOf("\""));
			
			String origFilePath = realPath + "faq/" + imgFile;
			String copyFilePath = realPath + "ckeditor/" + imgFile;
			
			fileCopyCheck(origFilePath, copyFilePath);
			
			if(nextImg.indexOf("src=\"/") == -1) sw = false;
			else nextImg = nextImg.substring(nextImg.indexOf("src=\"/") + position);
		}
	}

	public void imgDelete(String content, String filePath) {
		//      0         1         2         3         4         4
		//      01234567890123456789012345678901234567890123456789012345678
		// <img src="/JspringProject/data/faq/250321140356_2503.jpg" style="height:854px; width:1280px" />
		// <img src="/JspringProject/data/ckeditor/250321140356_2503.jpg" style="height:854px; width:1280px" />
		
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/");
		
		int position = 0;
		if(filePath.equals("faq")) position = 30;
		String nextImg = content.substring(content.indexOf("src=\"/") + position);
		boolean sw = true;
		
		while(sw) {
			String imgFile = nextImg.substring(0, nextImg.indexOf("\""));
			
			String origFilePath = realPath + "faq/" + imgFile;
			
			fileDelete(origFilePath);
			
			if(nextImg.indexOf("src=\"/") == -1) sw = false;
			else nextImg = nextImg.substring(nextImg.indexOf("src=\"/") + position);
		}
	}

	// 파일 삭제처리
	private void fileDelete(String origFilePath) {
		File delFile = new File(origFilePath);
		if(delFile.exists()) delFile.delete();
	}

	
}
