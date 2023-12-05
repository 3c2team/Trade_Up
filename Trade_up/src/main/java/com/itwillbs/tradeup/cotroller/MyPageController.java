package com.itwillbs.tradeup.cotroller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.itwillbs.tradeup.service.MyPageService;

@Controller
public class MyPageController {
	//TEST
	@Autowired
	MyPageService service;
	
	@GetMapping("MyPageMain")
	public String myPageMain() {
		
		return "myPage/myPage_main";
	}
	
	@GetMapping("MyFavorite")
	public String myFavorite() {
		
		return "myPage/myPage_favorite";
	}
	
	@GetMapping("MyProfile")
	public String myProfile() {
		
		return "myPage/myPage_profile";
	}
	
	@GetMapping("MySales")
	public String mySales() {
		
		return "myPage/myPage_sales";
	}
	
	@GetMapping("MyPurchase")
	public String myPurchase() {
		
		return "myPage/myPage_purchase";
	}
	
	// 프로필관리
	@GetMapping("MyInfo")
	public String myInfo(HttpSession session, Map<String, Object> map, Model model) {
		String sId = (String)session.getAttribute("sId");
		map = service.getMember(sId);
		model.addAttribute("member", map);
		return "myPage/myPage_info";
	}
	
	// 프로필관리 - 회원 탈퇴
	@PostMapping("DeleteMember")
	public String deleteMember(HttpSession session, @RequestParam Map<String, Object> param) {
		return "Main";
	}
	
	// 프로필관리 - 정보 수정 (닉네임, 전화번호, 이메일)
	@PostMapping("MyInfoModify")
	public String myInfoModify(HttpSession session, @RequestParam Map<String, Object> param) {
		param.put("sId", session.getAttribute("sId"));
		
		int updateCount = service.myInfoModify(param);
		if (updateCount > 0) {
			return "redirect:/MyInfo";
	    } else {
	    	return "fail_back";
	    }
	}
	
	// 프로필관리 - 프로필 이미지 수정 
	@PostMapping("MyProfileModify")
	public String myProfileModify(HttpSession session, @RequestParam Map<String, Object> param, @RequestParam(value = "file", required=false) MultipartFile file) {
		String sId = (String)session.getAttribute("sId");
		param.put("sId", sId);
		
		String uploadDir = "resources/TradeUp_upload/user_profile_image";
		String saveDir = session.getServletContext().getRealPath(uploadDir); //.replace("프로젝트명"); 추가하기
		String fileName = "";
			//================= < 이미지 처리 > =================
		try {
			
			//하위폴더 고민중
//				subDir = (String)session.getAttribute("sMember_num");
//				saveDir += subDir;
			
			Path path = Paths.get(saveDir);
			Files.createDirectories(path);
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		// 중복방지 uuid 추가하기 고민중
		fileName = file.getOriginalFilename();// 파일이름 추가 작업 해주기
		if(file != null || !(file.getOriginalFilename().equals(""))) {
//				param.put("modify_value", "");
			param.put("modify_value", uploadDir + "/" + fileName);
		}
			
		int updateCount = service.myInfoModify(param);
		
		Map<String, Object> response = new HashMap<String, Object>();
		if (updateCount > 0) {
			try {
				if(file != null && !(file.getOriginalFilename().equals(""))) {
					file.transferTo(new File(saveDir, fileName));
				}
			} catch (IllegalStateException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
			return "redirect:/MyInfo";
	    } else {
	    	return "fail_back";
	    }
		
	}
	

	// 계좌관리
	@GetMapping("MyAccount")
	public String myAccount(HttpSession session, Model model, HttpServletRequest request) {
		String sId = (String)session.getAttribute("sId");
		String servlet_path = request.getServletPath();
		String order_by = "account_main";
		List<Map<String, Object>> list = retrieveDataForServletAndSession(sId, servlet_path, order_by);
		model.addAttribute("my_account", list);
		
		return "myPage/myPage_account";
	}
	
	// 배송지관리
	@GetMapping("MyAddress")
	public String myAddress(HttpSession session, Model model, HttpServletRequest request) {
		String sId = (String)session.getAttribute("sId");
		String servlet_path = request.getServletPath();
		String order_by = "address_main";
		List<Map<String, Object>> list = retrieveDataForServletAndSession(sId, servlet_path, order_by);
		model.addAttribute("my_address", list);
		
		return "myPage/myPage_address";
	}
	
	// 배송지관리 - 배송지 추가 폼
	@GetMapping("AddAddressFrom")
	public String addMyAddressFrom(HttpSession session) {
		return "myPage/window/regist_my_address";
	}
	
	// 배송지관리 - 배송지 추가
	@PostMapping("AddAddress")
	public String addMyAddress(HttpSession session, Model model, @RequestParam Map<String, Object> param) {
		String sId = (String)session.getAttribute("sId");
		param.put("sId", sId);
		
		int insertCount = service.registMyAddress(param);
		
		if(insertCount > 0) {
			return "close";
		} else {
			model.addAttribute("msg", "오류남");
			return "close";
		}
	}
	
	// 배송지관리 - 배송지 수정
	@PostMapping("ModifyAddress")
	public String modifyAddress(HttpSession session, Model model, @RequestParam Map<String, Object> param) {
		String sId = (String)session.getAttribute("sId");
		param.put("sId", sId);
		
		int updateCount = service.updateAddress(param);
		
		if(updateCount > 0) {
			return "redirect:/MyAddress";
		} else {
			model.addAttribute("msg", "배송지 정보 수정에 실패했습니다. 다시 시도해주세요.");
			model.addAttribute("isClose", "false");
			model.addAttribute("targetURL", "MyAddress");
			return "forward";
		}
	}
	
	// 계좌관리&배송지관리 - 메인 변경
	@GetMapping("ChangeMainInfo")
	public String changeMainInfo(HttpSession session, Model model, @RequestParam Map<String, Object> param) {
		String sId = (String)session.getAttribute("sId");
		param.put("sId", sId);
		
		int insertCount = service.changeMainInfo(param);
		
		
		String url = "redirect:/";
		if(insertCount > 0) {
			if(param.get("tb").equals("MY_ADDRESS")) { url += "MyAddress"; }
			if(param.get("tb").equals("MY_ACCOUNT")) { url += "MyAccount"; }
			
			return url;
		} else {
			model.addAttribute("msg", "대표 주소등록 실패 - 다시 시도해주세요.");
			return "fail_back";
		}
	}
	
	// 계좌관리&배송지관리 - 정보 삭제
	@GetMapping("DeleteInfo")
	public String deleteInfo(HttpSession session, Model model, @RequestParam Map<String, Object> param) {
		
		String sId = (String)session.getAttribute("sId");
		param.put("sId", sId);
		
		int deleteCount = service.deleteInfo(param);
		
		String url = "redirect:/";
		if(deleteCount > 0) {
			if(param.get("tb").equals("MY_ADDRESS")) { url += "MyAddress"; }
			if(param.get("tb").equals("MY_ACCOUNT")) { url += "MyAccount"; }
			
			return url;
		} else {
			model.addAttribute("msg", "주소 등록 실패 - 다시 시도해주세요.");
			return "fail_back";
		}
	}
	
	@GetMapping("FAQ")
	public String fAQ() {
		
		return "myPage/tables-basic";
	}
	
	@GetMapping("Announcement")
	public String announcement() {
		
		return "myPage/myPage_favorite";
	}
	
	@GetMapping("TermsAndPolicies")
	public String termsAndPolicies() {
		
		return "myPage/myPage_favorite";
	}
	
	public List<Map<String, Object>> retrieveDataForServletAndSession(String sId, String servlet_path, String order_by) {
		String table_name = servlet_path.toUpperCase().replace("MY", "MY_").replace("/", "").toString();
		
		List<Map<String, Object>> list = new ArrayList<Map<String,Object>>(); 
		list = service.getMemeberInfo(sId, table_name, order_by);
		
		System.out.println(list);
		
		return list;
	}

	
}
