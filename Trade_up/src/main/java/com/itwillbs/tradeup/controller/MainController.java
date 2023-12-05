package com.itwillbs.tradeup.controller;

import java.io.File;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.itwillbs.tradeup.service.MainService;

@Controller
public class MainController {
	
	@Autowired
	MainService service;
	
	@GetMapping("About")
	public String about() {
		
		return "about";
	}
	@GetMapping("Blog")
	public String blog() {
		
		return "blog";
	}
	@GetMapping("BlogDetails")
	public String blogDetails() {
		
		return "blog_details";
	}
	
	@GetMapping("Contact")
	public String contact() {
		
		
		return "contact";
	}
	
	// 안써도 될거같음
	@GetMapping("Main")
	public String main(HttpSession session) {
		
//		session.setAttribute("sId", "hyeri123");
		
		return "main";
	}
	
	@GetMapping("ShoppingCart")
	public String shoppingCart() {
		
		return "shopping_cart";
	}
	//사기조회 페이지 이동
	@GetMapping("FraudInquiry")
	public String fraudInquiry() {
		
		return "fraud_inquiry";
	}
	//사기조회 결과 처리
	@PostMapping("FraudInquiryPro")
	public String fraudInquiryPro() {
		
		return "redirect:/FraudInquiryDetail";
	}
	//사기조회 결과 페이지 이동
	@GetMapping("FraudInquiryDetail")
	public String fraudInquiryDtail() {
		
		return "fraud_inquiry_detail";
	}
	
	//시세조회 페이지 이동
	@GetMapping("MarketPriceInquiry")
	public String marketPriceInquiry() {
		
		return "market_price_inquiry";
	}
	//고객센터 페이지 이동
	@GetMapping("Customer")
	public String customer() {
		
		return "customer";
	}
	@GetMapping("UserCustomer")
	public String userCustomer(HttpSession session,Model model) {
		String sId = (String)session.getAttribute("sId");
		List<Map<String, String>> selectUserQna = service.selectUserQna(sId);
		model.addAttribute("selectUserQna",selectUserQna);
		return "user_customer";
	}
	//1대1 문의 페이지 이동
	@GetMapping("RegistQuewstion")
	public String registQuewstion(Model model) {
		
		List<Map<String, String>> selectQnaCategory = service.selectQnaCategory();
		System.out.println(selectQnaCategory.size());
		System.out.println(selectQnaCategory);
		model.addAttribute("selectQnaCategory", selectQnaCategory);
		return "regist_question";
	}
	@GetMapping("UserCustomerDetail")
	public String userCustomerDetail(Model model,int qna_num) {
		
		Map<String,String> QnaDetail = service.selectQnaDetail(qna_num);
		model.addAttribute("QnaDetail",QnaDetail);
		return "user_customer_detail";
	}
	@PostMapping("QuestionRegistPro")
	public String quewstionRegistPro(HttpSession session,@RequestParam(value =  "file" , required = false) MultipartFile[] imageList
			,@RequestParam Map<String, String> map) {
			String uploadDir = "/qna_img/";//가상 업로드 경로
			String saveDir = session.getServletContext().getRealPath(uploadDir);//실제 업로드 경로
			// 맵에 이름과 경로 전달
			//실제 파일 이름과 uuid랜덤합쳐서 겹치는걸 방지
			System.out.println(map);
			String sId = (String)session.getAttribute("sId");
			map.put("sId", sId);
			int insertQuestionCount = service.insertQuestion(map);
			
			if(insertQuestionCount == 0) return "fail_back";
			for(MultipartFile file : imageList) {
			String fileName = uuid(file.getOriginalFilename());
			map.put("real_file", uploadDir + fileName);
			map.put("file_name", fileName);
			int insertQuestionImgCount = service.insertQuestionImg(map);
			
			if(insertQuestionImgCount == 0) return "fail_back";
			newFile(saveDir,fileName,file);
			}

	return "redirect:/UserCustomer";
	}	
	@ResponseBody
	@PostMapping("SelectQnaCategorys")
	public List<Map<String, String>> selectQnaCategorys(@RequestParam(required = false) int qnaCategoryName) {

		
		//		System.out.println(service.selectCategoryDetail("왜 갑자기 안돼! : " + qnaCategoryName));
		return service.selectCategoryDetail(qnaCategoryName);
	}	
	@ResponseBody
	@PostMapping("SelectProduct")
	public List<Map<String, String>> selectProduct(@RequestParam(required = false) String product_name) {
		System.out.println("시세조회 검색어 : " + product_name);
		System.out.println("fdfsfsfs : " +  service.selectProduct(product_name));
		return service.selectProduct(product_name);
//		return null;
	}	
	
	@ResponseBody
	@PostMapping("SelectOftenQna")
	public List<Map<String, String>> selectOftenQna(@RequestParam(required = false) Map<String, String> map) {
		System.out.println("카테고리 : " + map);
//		System.out.println(service.selectOftenQna(map));
	return service.selectOftenQna(map);

	}	
	
	
	
	
	

	public String uuid(String name) {
		String uuid = UUID.randomUUID().toString();
		
		return uuid.substring(0, 3) + "_" + name;
	}

	public void newFile(String saveDir, String fileName,MultipartFile file) {
		
		try {
			Path path = Paths.get(saveDir);//경로 저장
			Files.createDirectories(path);//중간 경로 생성
			file.transferTo(new File(saveDir, fileName));
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
