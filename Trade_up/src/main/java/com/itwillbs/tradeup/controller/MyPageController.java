package com.itwillbs.tradeup.controller;

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

import org.json.JSONArray;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.itwillbs.tradeup.service.MyPageService;
import com.itwillbs.tradeup.service.bankApiClient;
import com.itwillbs.tradeup.service.bankApiService;
import com.itwillbs.tradeup.vo.BankAccountVO;
import com.itwillbs.tradeup.vo.ResponseAccountListVO;
import com.itwillbs.tradeup.vo.ResponseUserInfoVO;

@Controller
public class MyPageController {
	@Autowired
	MyPageService service;
	
	@Autowired
	private bankApiClient bankApiClient;
	
	@Autowired
	private bankApiService bankApiService;
	
	// 마이페이지
	@GetMapping("MyPageMain")
	public String myPageMain(HttpSession session, Model model) {
		String sId = (String)session.getAttribute("sId");
		List<Map<String, Object>> accountList = service.getMyAccount(sId);
		List<Map<String, Object>> favoriteList = service.getMyfavorite(sId);
		List<Map<String, Object>> productsList = service.getMyPurchase(sId);
		List<Map<String, Object>> salesList = service.getMyProduct(sId);
		
		model.addAttribute("accountList", accountList);
		model.addAttribute("favoriteList", favoriteList);
		model.addAttribute("productsList", productsList);
		model.addAttribute("salesList", salesList);
		return "myPage/myPage_main";
	}
	
	// 관심목록
	@GetMapping("MyFavorite")
	public String myFavorite(HttpSession session, Model model) {
		String sId = (String)session.getAttribute("sId");
		
		if(sId == null) {
			model.addAttribute("msg", "로그인이 필요한 페이지입니다.");
			model.addAttribute("targetURL", "Login");
			return "forward";
		}
		
		List<Map<String, Object>> favoriteList = service.getMyfavorite(sId);
		model.addAttribute("favoriteList", favoriteList);
		System.out.println(favoriteList);
		return "myPage/myPage_favorite";
	}
	// 관심상품 삭제
	@GetMapping("DeleteFavorite")
	public String deleteFavorite(HttpSession session, Model model, @RequestParam Map<String, Object> param) {
		String sId = (String)session.getAttribute("sId");
		
		if(sId == null) {
			model.addAttribute("msg", "로그인이 필요한 페이지입니다.");
			model.addAttribute("targetURL", "Login");
			return "forward";
		}
		param.put("sId", sId);
		
		int deleteCount = service.deleteFavorite(param);
		
		if(deleteCount > 0) {
			return "redirect:/DeleteFavorite";
		}
		
		model.addAttribute("msg", "서버 오류로 관심상품 해제에 실패했습니다. 다시 시도해주세요.");
		return "myPage/fail_back";
	}
	
	// 판매내역
	@GetMapping("MySales")
	public String mySales(HttpSession session, Model model) {
		String sId = (String)session.getAttribute("sId");
		
		if(sId == null) {
			model.addAttribute("msg", "로그인이 필요한 페이지입니다.");
			model.addAttribute("targetURL", "Login");
			return "forward";
		}
		
		List<Map<String, Object>> productsList = service.getMyProduct(sId);
		model.addAttribute("productsList", productsList);
		
		return "myPage/myPage_sales";
	}
	
	// 판매내역 삭제
	@GetMapping("DeleteMySales")
	public String deleteMySales(HttpSession session, Model model, @RequestParam Map<String, Object> param) {
		String sId = (String)session.getAttribute("sId");
		
		if(sId == null) {
			model.addAttribute("msg", "로그인이 필요한 페이지입니다.");
			model.addAttribute("targetURL", "Login");
			return "forward";
		}
		
		param.put("sId", sId);
		int deleteCount = service.deleteProcut(param);
		if(deleteCount > 0) {
			return "redirect:/MySales";
		} else {
			model.addAttribute("msg", "판매글 삭제에 실패했습니다. 다시 시도해 주세요.");
			return "fail_back";
		}
	}
	
	// 구매내역
	@GetMapping("MyPurchase")
	public String myPurchase(HttpSession session, Model model) {
		String sId = (String)session.getAttribute("sId");
		
		if(sId == null) {
			model.addAttribute("msg", "로그인이 필요한 페이지입니다.");
			model.addAttribute("targetURL", "Login");
			return "forward";
		}
		
		List<Map<String, Object>> productList = service.getMyPurchase(sId);
		
		System.out.println(productList);
		
		model.addAttribute("productList", productList);
		return "myPage/myPage_purchase";
	}
	
	// 프로필관리
	@GetMapping("MyInfo")
	public String myInfo(HttpSession session, Map<String, Object> map, Model model) {
		String sId = (String)session.getAttribute("sId");
		
		if(sId == null) {
			model.addAttribute("msg", "로그인이 필요한 페이지입니다.");
			model.addAttribute("targetURL", "Login");
			return "forward";
		}
		
		map = service.getMember(sId);
		List<Map<String, Object>> feedback = service.getFeedback();
		
		
		System.out.println(feedback);
		
		model.addAttribute("member", map);
		model.addAttribute("feedback", feedback);
		return "myPage/myPage_info";
	}
	
	
	// 프로필관리 - 정보 수정 (닉네임, 전화번호, 이메일)
	@PostMapping("MyInfoModify")
	public String myInfoModify(HttpSession session, @RequestParam Map<String, Object> param, Model model) {
		String sId = (String)session.getAttribute("sId");
		
		if(sId == null) {
			model.addAttribute("msg", "로그인이 필요한 페이지입니다.");
			model.addAttribute("targetURL", "Login");
			return "forward";
		}
		
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
	public String myProfileModify(HttpSession session, @RequestParam Map<String, Object> param, @RequestParam(value = "file", required=false) MultipartFile file, Model model) {
		String sId = (String)session.getAttribute("sId");
		
		if(sId == null) {
			model.addAttribute("msg", "로그인이 필요한 페이지입니다.");
			model.addAttribute("targetURL", "Login");
			return "forward";
		}
		
		param.put("sId", sId);
		
		String uploadDir = "/TradeUp_upload/user_profile_image/";
		String saveDir = session.getServletContext().getRealPath(uploadDir).replace("Trade_up/", ""); //.replace("프로젝트명"); 추가하기
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
	
	// 프로필관리 - 회원 탈퇴
	@PostMapping("DeleteMember")
	public String deleteMember(HttpSession session, @RequestParam Map<String, Object> param, Model model) {
		String sId = (String)session.getAttribute("sId");
		
		if(sId == null) {
			model.addAttribute("msg", "로그인이 필요한 페이지입니다.");
			model.addAttribute("targetURL", "Login");
			return "forward";
		}
		param.put("sId", sId);
		
		int count = service.updateDeleteMember(param);
		
		if(count > 0) {
			return "myPage/delete";
		} else {
			model.addAttribute("msg", "앗, 서버오류로 탈퇴 실패했어요. 다시 시도해주세요.");
			model.addAttribute("targetURL", "DeleteMember");
			return "forward";
		}
		
	}
		
	// 계좌관리
	@GetMapping("MyAccount")
	public String myAccount(HttpSession session, Model model, HttpServletRequest request) {
		String sId = (String)session.getAttribute("sId");
		
		if(sId == null) {
			model.addAttribute("msg", "로그인이 필요한 페이지입니다.");
			model.addAttribute("targetURL", "Login");
			return "forward";
		}
		
		String servlet_path = request.getServletPath();
		String order_by = "account_main";
		Map<String, String> token = service.getFintechInfo(sId);
		
		List<Map<String, Object>> list = retrieveDataForServletAndSession(sId, servlet_path, order_by);
		model.addAttribute("my_account", list);
		model.addAttribute("token", token);
		return "myPage/myPage_account";
	}
	
	//계좌관리 - 계좌 등록
	@PostMapping("AddAccount")
	public String addAccount(HttpSession session, @RequestParam Map<String, Object> param, Map<String, String> map, Model model) {
		String sId = (String)session.getAttribute("sId");
		
		if(sId == null) {
			model.addAttribute("msg", "로그인이 필요한 페이지입니다.");
			model.addAttribute("targetURL", "Login");
			return "forward";
		}
		
		param.put("sId", sId);
		map = service.getFintechInfo(sId);
		
		ResponseUserInfoVO userInfo = bankApiClient.requestUserInfo(map);
		System.out.println("param - " + param);			//  account_num=23062003007           account_bank=KDB산업은행, 
		System.out.println("API UserInfo - " + userInfo);	//  account_num_masked=23062003***    bank_name=KDB산업은행
		
		String user_acc = (String)param.get("account_num");
		String user_acc_masked = user_acc.substring(0, user_acc.length() - 3) + "***";
		String user_bank = (String)param.get("account_bank");
		
		int insertCount = 0;
		String fintech_use_num = "";
		for(BankAccountVO account : userInfo.getRes_list()) {
			fintech_use_num = account.getFintech_use_num();
			String apiBank = account.getBank_name();
			String apiAcc = account.getAccount_num_masked();
			
			if(apiBank.equals(user_bank) && apiAcc.equals(user_acc_masked)) {
				param.put("account_holder_name", account.getAccount_holder_name());
				insertCount = service.registMyAccount(param);
				break;
			}
		}
		
		String msg = "계좌등록에 실패했습니다. 계좌번호를 확인해주세요.";
		if(insertCount > 0) {
			msg = "계좌를 등록했습니다.";
			bankApiService.registFintechUseNum(fintech_use_num, sId);
		}
		
		model.addAttribute("msg", msg);
		model.addAttribute("isClose", "false");
		model.addAttribute("targetURL", "MyAccount");
		
		return "forward";
	}
	
	// 배송지관리
	@GetMapping("MyAddress")
	public String myAddress(HttpSession session, Model model, HttpServletRequest request) {
		String sId = (String)session.getAttribute("sId");
		
		if(sId == null) {
			model.addAttribute("msg", "로그인이 필요한 페이지입니다.");
			model.addAttribute("targetURL", "Login");
			return "forward";
		}
		
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
		
		if(sId == null) {
			model.addAttribute("msg", "로그인이 필요한 페이지입니다.");
			model.addAttribute("targetURL", "Login");
			return "forward";
		}
		
		param.put("sId", sId);
		
		int insertCount = service.registMyAddress(param);
		
		if(insertCount > 0) {
			return "redirect:/MyAddress";
		} else {
			model.addAttribute("msg", "오류남");
			model.addAttribute("isClose", "true");
			model.addAttribute("targetURL", "AddAddress");
			return "forward";
		}
	}
	
	// 배송지관리 - 배송지 수정
	@PostMapping("ModifyAddress")
	public String modifyAddress(HttpSession session, Model model, @RequestParam Map<String, Object> param) {
		String sId = (String)session.getAttribute("sId");
		
		if(sId == null) {
			model.addAttribute("msg", "로그인이 필요한 페이지입니다.");
			model.addAttribute("targetURL", "Login");
			return "forward";
		}
		
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
		
		if(sId == null) {
			model.addAttribute("msg", "로그인이 필요한 페이지입니다.");
			model.addAttribute("targetURL", "Login");
			return "forward";
		}
		
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
		
		if(sId == null) {
			model.addAttribute("msg", "로그인이 필요한 페이지입니다.");
			model.addAttribute("targetURL", "Login");
			return "forward";
		}
		
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
	
	@ResponseBody
	@PostMapping("PasswordCheck")
	public String passwordCheck(@RequestParam Map<String, Object> param, HttpSession session) {
		String sId = (String)session.getAttribute("sId");
		System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>비번 판별 param: " + param);
		
		Map<String, Object> map = service.getMember(sId);
		
		BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
		if(!passwordEncoder.matches(param.get("password").toString(), map.get("member_passwd").toString())) {
			System.out.println("비번 오류!");
			return "false";
		} 
		
		System.out.println("비번 맞음!");
		return "true";
	}
	
	public List<Map<String, Object>> retrieveDataForServletAndSession(String sId, String servlet_path, String order_by) {
		String table_name = servlet_path.toUpperCase().replace("MY", "MY_").replace("/", "").toString();
		
		List<Map<String, Object>> list = new ArrayList<Map<String,Object>>(); 
		list = service.getMemeberInfo(sId, table_name, order_by);
		
		System.out.println(list);
		
		return list;
	}

	
}
