package com.spring.springProject3.controller;

import java.util.List;
import java.util.Random;
import java.util.UUID;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.spring.springProject3.service.MemberService;
import com.spring.springProject3.service.PetService;
import com.spring.springProject3.vo.MemberVo;
import com.spring.springProject3.vo.PetVo;

@Controller
@RequestMapping("/member")
public class MemberController {
    
    @Autowired
    MemberService memberService;
    
    @Autowired
    PetService petService;
    
    @Autowired
    JavaMailSender mailSender;
    
    @Autowired
    BCryptPasswordEncoder passwordEncoder;
    
    // 로그인 폼 보기
    @RequestMapping(value = "/memberLogin", method = RequestMethod.GET)
    public String memberLoginGet(HttpServletRequest request) {
        // 쿠키에 저장된 아이디를 가져와 view에 전달
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (cookie.getName().equals("cMid")) {
                    request.setAttribute("mid", cookie.getValue());
                    break;
                }
            }
        }
        return "member/memberLogin";
    }
    
    // 일반 로그인 처리
    @RequestMapping(value = "/memberLogin", method = RequestMethod.POST)
    public String memberLoginPost(HttpSession session, HttpServletRequest request, HttpServletResponse response, String mid, String pwd, String idSave) {
    	final long LOCK_DURATION = 60 * 1000; // 1분

        // 실패 횟수 및 제한 시간 확인
        Integer failCount = (Integer) session.getAttribute("loginFailCount");
        Long lockTime = (Long) session.getAttribute("lockTime");
        
        if (failCount == null) failCount = 0;
        
        // 1분 내에 5회 실패 시 로그인 차단
        if (failCount >= 5 && lockTime != null) {
            long elapsed = System.currentTimeMillis() - lockTime;
            if (elapsed < LOCK_DURATION) {
                long remaining = (LOCK_DURATION - elapsed) / 1000;
                session.setAttribute("remainingTime", remaining);
                return "redirect:/message/loginLockTimer";
            } else {
                // 제한 시간 지난 경우 초기화
                session.removeAttribute("lockTime");
                session.setAttribute("loginFailCount", 0);
                failCount = 0;
            }
        }
    	
    	MemberVo vo = memberService.getMemberIdCheck(mid);
        if (vo != null && vo.getUserDel().equals("NO") && passwordEncoder.matches(pwd, vo.getPwd())) {
            // 1. 세션 설정
            String strLevel = "";
            if (vo.getLevel() == 0) strLevel = "관리자";
            else if (vo.getLevel() == 1) strLevel = "사업자";
            else if (vo.getLevel() == 2) strLevel = "일반회원";
            
            session.setAttribute("sMid", mid);
            session.setAttribute("sNickName", vo.getNickName());
            session.setAttribute("sLevel", vo.getLevel());
            session.setAttribute("strLevel", strLevel);
            session.setAttribute("sLogin", "로그인");
            
            // 2. 쿠키 처리
            if (idSave != null && idSave.equals("on")) {
                Cookie cookieMid = new Cookie("cMid", vo.getMid());
                cookieMid.setPath("/");
                cookieMid.setMaxAge(60 * 60 * 24 * 7); // 7일
                response.addCookie(cookieMid);
            } else {
                Cookie[] cookies = request.getCookies();
                if (cookies != null) {
                    for (Cookie cookie : cookies) {
                        if (cookie.getName().equals("cMid")) {
                            cookie.setPath("/");
                            cookie.setMaxAge(0);
                            response.addCookie(cookie);
                            break;
                        }
                    }
                }
            }
            return "redirect:/message/memberLoginOk";
        } else {
        	failCount++;
            session.setAttribute("loginFailCount", failCount);

            if (failCount >= 5) {
                session.setAttribute("lockTime", System.currentTimeMillis());
                session.setAttribute("remainingTime", 60L); // 60초 제한
                return "redirect:/message/loginLockTimer";
            }
            return "redirect:/message/memberLoginNo";
        }
    }
    // 카카오 로그인 처리
    @RequestMapping(value = "/kakaoLogin", method = RequestMethod.GET)
    public String kakaoLoginGet(HttpSession session, HttpServletRequest request, HttpServletResponse response,
                                String nickName, String email, String accessToken) throws MessagingException {
        session.setAttribute("sAccessToken", accessToken);
        session.setAttribute("sLogin", "kakao");
        
        // 카카오 회원이 기존 회원인지 확인
        MemberVo vo = memberService.getMemberNickNameEmailCheck(nickName, email);
        if (vo == null) {
            // 신규 회원인 경우: 이메일을 통해 아이디 생성 후 임시 비밀번호 발급 및 자동 가입
            String mid = email.substring(0, email.indexOf("@"));
            MemberVo vo2 = memberService.getMemberIdCheck(mid);
            if (vo2 != null) {
                // 이미 가입된 회원이면 바로 로그인 처리
                session.setAttribute("sMid", mid);
                session.setAttribute("sNickName", nickName);
                session.setAttribute("sLevel", 2);
                session.setAttribute("strLevel", "일반회원");
                return "redirect:/message/memberLoginOk";
            }
            // 신규 가입 처리
            String pwd = UUID.randomUUID().toString().substring(0,8);
            session.setAttribute("sImsiPwd", pwd);
            memberService.setKakaoMemberInput(mid, nickName, email, passwordEncoder.encode(pwd));
            vo = memberService.getMemberIdCheck(mid);
            // 임시 비밀번호를 이메일로 전송
            mailSend(email, "[withPET] 임시 비밀번호", pwd);
            session.setAttribute("sLoginNew", "OK");
        }
        
        // 세션 정보 저장
        String strLevel = "";
        if (vo.getLevel() == 0) strLevel = "관리자";
        else if (vo.getLevel() == 1) strLevel = "사업자";
        else if (vo.getLevel() == 2) strLevel = "일반회원";
        
        session.setAttribute("sMid", vo.getMid());
        session.setAttribute("sNickName", vo.getNickName());
        session.setAttribute("sLevel", vo.getLevel());
        session.setAttribute("strLevel", strLevel);
        
        return "redirect:/message/memberLoginOk?mid=" + vo.getMid();
    }
    
    // 회원가입 폼 보기
    @RequestMapping(value = "/memberJoin", method = RequestMethod.GET)
    public String memberJoinGet() {
        return "member/memberJoin";
    }
    
    // 회원가입 처리 (DB에 회원 저장)
    @RequestMapping(value = "/memberJoin", method = RequestMethod.POST)
    public String memberJoinPost(MemberVo vo) {
        // 아이디 중복 체크
        if (memberService.getMemberIdCheck(vo.getMid()) != null) {
            return "redirect:/message/idCheckNo";
        }
        // 비밀번호 암호화
        vo.setPwd(passwordEncoder.encode(vo.getPwd()));
        
        int res = memberService.setMemberJoinOk(vo);
        return (res != 0) ? "redirect:/message/memberJoinOk" : "redirect:/message/memberJoinNo";
    }
    
    // 아이디 중복 체크
    @ResponseBody
    @RequestMapping(value = "/memberIdCheck", method = RequestMethod.GET)
    public String memberIdCheckGet(String mid) {
        MemberVo vo = memberService.getMemberIdCheck(mid);
        return (vo != null) ? "1" : "0";
    }
    
    // 닉네임 중복 체크
    @ResponseBody
    @RequestMapping(value = "/memberNickCheck", method = RequestMethod.GET)
    public String memberNickCheckGet(String nickName) {
        MemberVo vo = memberService.getMemberNickCheck(nickName);
        return (vo != null) ? "1" : "0";
    }
    
    // 사업자등록번호 중복 체크
    @ResponseBody
    @RequestMapping(value = "/memberBizNoCheck", method = RequestMethod.GET)
    public String memberBizNoCheckGet(String businessNo) {
        MemberVo vo = memberService.getMemberBizNoCheck(businessNo);
        return (vo != null) ? "1" : "0";
    }
    
    // 이메일 인증 처리 (인증키 전송)
    @ResponseBody
    @RequestMapping(value = "/memberEmailCheck", method = RequestMethod.POST)
    public String memberEmailCheckPost(String email, HttpSession session) throws MessagingException {
        UUID uid = UUID.randomUUID();
        String emailKey = uid.toString().substring(0,8);
        session.setAttribute("sEmailKey", emailKey);
        mailSend(email, "[withPET] 이메일 인증키", emailKey);
        return "1";
    }
    
    // 이메일 인증 확인
    @ResponseBody
    @RequestMapping(value = "/memberEmailCheckOk", method = RequestMethod.POST)
    public String memberEmailCheckOkPost(String checkKey, HttpSession session) {
        String sCheckKey = (String) session.getAttribute("sEmailKey");
        session.removeAttribute("sEmailKey");
        return (checkKey.equals(sCheckKey)) ? "1" : "0";
    }
    
 // 메일 전송하기 (인증번호, 임시 비밀번호)
    public void mailSend(String toMail, String title, String mailFlag) throws MessagingException {
        HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();

        MimeMessage message = mailSender.createMimeMessage();
        MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");

        messageHelper.setTo(toMail);

        // 메일 제목/내용 분기
        String mainTitle = "";
        String description = "";
        String subMessage = "";
        String subject = title;
        String prefix = "";

        if (title.contains("임시 비밀번호")) {
            subject = "[withPET] 임시 비밀번호";
            mainTitle = "🐾 withPET 임시 비밀번호 안내";
            description = "회원님의 요청으로 아래와 같이 임시 비밀번호를 발급해드렸습니다.";
            subMessage = "보안을 위해 <strong>로그인 후 반드시 비밀번호를 변경</strong>해 주세요.";
            prefix = "임시 비밀번호 : ";
        } else if (title.contains("인증키")) {
            subject = "[withPET] 이메일 인증키";
            mainTitle = "🐾 withPET 이메일 인증 안내";
            description = "회원가입을 위해 이메일 인증이 필요합니다.";
            subMessage = "아래 인증키를 입력해 주세요.";
            prefix = "인증키 : ";
        }

        messageHelper.setSubject(subject);

        // HTML 메일 본문 구성
        String content = "";
        content += "<div style='font-family:Arial,sans-serif; font-size:16px; color:#333; max-width:600px; margin:0 auto; padding:20px; border:1px solid #eee; border-radius:8px;'>";
        content += "<div style='text-align:center; margin-bottom:10px;'>";
        content += "<img src='cid:logo' alt='withPet 로고' style='max-width:180px;'/>";
        content += "</div>";

        content += "<h2 style='color:#2e7d32; text-align:center; margin-top:0;'>" + mainTitle + "</h2>";
        content += "<p>안녕하세요, <strong>withPET</strong>입니다.</p>";
        content += "<p>" + description + "<br/>" + subMessage + "</p>";

        content += "<div style='padding:15px; background:#f9f9f9; border:1px solid #ccc; border-radius:5px; margin:20px 0; text-align:center;'>";
        content += "<span style='font-size:18px; color:#000; font-weight:bold;'>임시 비밀번호 : </span>";
        content += "<span style='font-size:18px; color:#2e7d32; font-weight:bold;'>" + mailFlag + "</span>";
        content += "</div>";

        content += "<p style='text-align:center;'><a href='http://localhost:9090/springProject3/' style='background-color:#2e7d32; color:#fff; padding:10px 20px; text-decoration:none; border-radius:4px;'>withPET 바로가기</a></p>";

        content += "<hr style='margin:40px 0;'>";
        content += "<p style='font-size:12px; color:#999;'>본 메일은 발신전용입니다. 문의사항은 홈페이지를 통해 남겨주세요.</p>";
        content += "</div>";

        // 본문 적용
        messageHelper.setText(content, true);

        // 로고 이미지 연결
        FileSystemResource file = new FileSystemResource(
            request.getSession().getServletContext().getRealPath("/resources/images/logo.png"));
        messageHelper.addInline("logo", file);

        // 메일 전송
        mailSender.send(message);
    }


    // 마이페이지(일반회원, 사업자회원)
    @RequestMapping(value = "/memberMyPage", method = RequestMethod.GET)
    public String memberMyPageGet(HttpSession session, Model model) {
        String mid = (String) session.getAttribute("sMid");
        
        if (mid == null) {
            return "redirect:/message/loginRequired";
        }
        
        MemberVo mVo = memberService.getMemberIdCheck(mid);
        
        if (mVo == null) {
            session.invalidate();
            return "redirect:/message/loginRequired";
        }
        
        model.addAttribute("mVo", mVo);
        
        // 반려견 리스트 조회 추가
        List<PetVo> dogList = petService.getPetList(mid);
        model.addAttribute("dogList", dogList);

        // level 값에 따라 다른 JSP로 보내기
        if (mVo.getLevel() == 1) {
            return "member/memberMyPageBiz"; // 사업자회원
        } else {
            return "member/memberMyPage"; // 일반회원
        }
    }
    
    // 로그아웃 처리
    @RequestMapping(value = "/memberLogout", method = RequestMethod.GET)
    public String memberLogoutGet(HttpSession session) {
        session.invalidate();
        return "redirect:/message/memberLogoutOk";
    }
    
    // 회원 탈퇴(또는 정보수정) 전 비밀번호 확인 폼
    @RequestMapping(value = "/pwdCheck/{pwdFlag}", method = RequestMethod.GET)
    public String pwdCheckGet(Model model, @PathVariable String pwdFlag) {
        model.addAttribute("pwdFlag", pwdFlag);
        return "member/pwdCheckForm";
    }
    
    // 비밀번호 확인 후 처리 (탈퇴, 비밀번호 변경, 회원 정보 수정)
    @RequestMapping(value = "/pwdCheck/{pwdFlag}", method = RequestMethod.POST)
    public String pwdCheckPost(HttpSession session, @PathVariable String pwdFlag, String pwd) {
        String mid = (String) session.getAttribute("sMid");
        if (!passwordEncoder.matches(pwd, memberService.getMemberIdCheck(mid).getPwd())) {
            if (pwdFlag.equals("d"))
                return "redirect:/message/pwdCheckNo";
            else if (pwdFlag.equals("p"))
                return "redirect:/message/pwdCheckNoP";
            else if (pwdFlag.equals("u"))
                return "redirect:/message/pwdCheckNoU";
        }
        if (pwdFlag.equals("d")) {
            memberService.setMemberDeleteCheck(mid);
            return "redirect:/message/memberDeleteCheck";
        } else if (pwdFlag.equals("p")) {
            return "member/pwdChange";
        } else if (pwdFlag.equals("u")) {
            return "redirect:/member/memberUpdate";
        }
        return "redirect:/";
    }

    // 비밀번호 변경 처리
    @PostMapping("/pwdChange")
    public String pwdChangePost(HttpSession session, String pwd) {
        String mid = (String) session.getAttribute("sMid");
        pwd = passwordEncoder.encode(pwd);
        int res = memberService.setMemberPwdChange(mid, pwd);
        return (res != 0) ? "redirect:/message/pwdChangeOk" : "redirect:/message/pwdChangeNo";
    }
    
    // 회원 정보 수정 폼 보기
    @RequestMapping(value = "/memberUpdate", method = RequestMethod.GET)
    public String memberUpdateGet(Model model, HttpSession session) {
        String mid = (String) session.getAttribute("sMid");
        MemberVo vo = memberService.getMemberIdCheck(mid);
        model.addAttribute("vo", vo);
        return "member/memberUpdate";
    }
    
    // 회원 정보 수정 처리
    @RequestMapping(value = "/memberUpdate", method = RequestMethod.POST)
    public String memberUpdatePost(HttpSession session, MemberVo vo) {
        // 닉네임 중복 체크: 수정 시 기존 닉네임이 아닌 경우에만 확인
        String currentNickName = (String) session.getAttribute("sNickName");
        if (memberService.getMemberNickCheck(vo.getNickName()) != null && !currentNickName.equals(vo.getNickName())) {
            return "redirect:/message/nickCheckNo";
        }
        
        int res = memberService.setMemberUpdateOk(vo);
        if (res != 0) {
            session.setAttribute("sNickName", vo.getNickName());
            return "redirect:/message/memberUpdateOk";
        } else {
            return "redirect:/message/memberUpdateNo";
        }
    }
    
    // 아이디 찾기 폼
    @RequestMapping(value = "/memberFindId", method = RequestMethod.GET)
    public String findIdGet() {
        return "member/memberFindId";
    }

    // 아이디 찾기 처리
    @RequestMapping(value = "/memberFindId", method = RequestMethod.POST)
    public String findIdPost(String name, String email1, String email2, Model model) {
        String email = email1.trim() + "@" + email2.trim();
        MemberVo vo = memberService.getMemberIdByNameEmail(name.trim(), email);
        if (vo != null) model.addAttribute("foundId", vo.getMid());
        else model.addAttribute("notFound", true);
        return "member/memberFindId";
    }
    
    // 비밀번호 찾기 폼
    @GetMapping("/memberFindPwd")
    public String memberFindPwdGet() {
        return "member/memberFindPwd";
    }

    // 비밀번호 찾기 처리
    @PostMapping("/memberFindPwd")
    public String memberFindPwdPost(String name, String mid, String email1, String email2, Model model) {
        String email = email1.trim() + "@" + email2.trim();

        // 1. 회원 정보 조회
        MemberVo vo = memberService.getMemberByNameMidEmail(name.trim(), mid.trim(), email);
        if (vo == null) {
            return "redirect:/message/memberFindPwdNo"; // 실패 메시지
        }

        // 2. 임시 비밀번호 생성
        String tempPwd = makeTempPassword();

        // 3. 비밀번호 암호화 후 DB 업데이트
        String encodedPwd = passwordEncoder.encode(tempPwd);
        memberService.updatePassword(mid, encodedPwd);

        // 4. 이메일로 임시 비밀번호 전송
        try {
            mailSend(email, "[withPET] 임시 비밀번호", tempPwd);
        } catch (MessagingException e) {
            e.printStackTrace();
            model.addAttribute("msg", "이메일 전송에 실패했습니다.");
            model.addAttribute("url", "/member/memberFindPwd");
            return "include/message"; // 이 부분만 예외적 처리
        }

        // 5. 성공 메시지
        return "redirect:/message/memberFindPwdOk";
    }

    // 임시 비밀번호 생성 메서드
    public String makeTempPassword() {
        String chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
        StringBuilder sb = new StringBuilder();
        Random rnd = new Random();
        for (int i = 0; i < 10; i++) {
            sb.append(chars.charAt(rnd.nextInt(chars.length())));
        }
        return sb.toString();
    }

}