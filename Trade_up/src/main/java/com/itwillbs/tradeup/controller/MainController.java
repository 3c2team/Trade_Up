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
import com.itwillbs.tradeup.service.MemberService;

@Controller
public class MainController {
	
	@Autowired
	MainService service;
	@Autowired
	MemberService memberService;
	
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
	@GetMapping("Category")
	public String category(HttpSession session,Model model) {
		
		List<Map<String, String>> category = service.selectCategory();
		
		model.addAttribute("category",category);
		return "admin/category";
	}
	
	@GetMapping("CategoryQna")
	public String categoryQna(HttpSession session,Model model) {
		
		List<Map<String, String>> selectQnaCategory = service.selectQnaCategory();
		selectQnaCategory.remove(1);
		model.addAttribute("selectQnaCategory",selectQnaCategory);
		return "admin/category_qna";
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
	public String fraudInquiryPro(@RequestParam String member_id,Model model) {
		System.out.println("member_id : " + member_id);
		Map<String, String> dbMember = memberService.getMemberLogin(member_id);
		model.addAttribute("targetURL", "FraudInquiry");
		
		if(dbMember == null) {
			model.addAttribute("msg","정보가 없는 아이디입니다.");
			return "forward";
		}
		if(dbMember.get("member_state").equals("정지")) {
			model.addAttribute("msg","회원님의 계정은 정지된 계정입니다"
					+ "자세한 문의 사항은 XXXXX@XXXX.com으로 문의 주시길 바랍니다.");
		}else {
			model.addAttribute("msg","회원님의 계정은 이용가능한 계정입니다.");
		}
		return "forward";
	}
	
	//시세조회 페이지 이동
	@GetMapping("MarketPriceInquiry")
	public String marketPriceInquiry() {
		
		return "market_price_inquiry";
	}
	//고객센터 페이지 이동
	@GetMapping("Customer")
	public String customer(HttpSession session) {
		String sId = (String)session.getAttribute("sId");
		if(sId == null || sId.equals("")) return "not_login";
		
		
		return "customer";
	}
	@GetMapping("UserCustomer")
	public String userCustomer(HttpSession session,Model model) {
		String sId = (String)session.getAttribute("sId");
		
		if(sId == null || sId.equals("")) return "not_login";
		
		
		List<Map<String, String>> selectUserQna = service.selectUserQna(sId);
		List<Map<String, String>> selectUserReport = service.selectUserReport(sId);
		model.addAttribute("selectUserQna",selectUserQna);
		model.addAttribute("selectUserReport",selectUserReport);
		return "user_customer";
	}
	//1대1 문의 페이지 이동
	@GetMapping("RegistQuewstion")
	public String registQuewstion(Model model,@RequestParam Map<String,String> map,HttpSession session) {
		
		String sId = (String)session.getAttribute("sId");
		if(sId == null || sId.equals("")) return "not_login";
		
		List<Map<String, String>> selectQnaCategory = service.selectQnaCategory();
		if(map.get("product_num") == null) {
			System.out.println(selectQnaCategory.remove(1));
//			selectQnaCategory.get(1).remove("");
		}
		System.out.println(selectQnaCategory);
		model.addAttribute("selectQnaCategory", selectQnaCategory);
		return "regist_question";
	}
	@GetMapping("UserCustomerDetail")
	public String userCustomerDetail(Model model,int qna_num, HttpSession session) {
		
		String sId = (String)session.getAttribute("sId");
		if(sId == null || sId.equals("")) return "not_login";
		
		Map<String,String> QnaDetail = service.selectQnaDetail(qna_num);
		model.addAttribute("QnaDetail",QnaDetail);
		return "user_customer_detail";
	}
	@GetMapping("UserMarket")
	public String userMarket(@RequestParam String member_id,Model model) {
		Map<String, String> Seller = memberService.getMemberLogin(member_id);
		List<Map<String, String>> sellerProduct = service.selectSellerProduct(member_id);
		Map<String, String> sellerCount = service.sellerCount(member_id);
		Seller.put("Count", ""+sellerProduct.size());
		model.addAttribute("sellerCount", sellerCount);
		model.addAttribute("Seller", Seller);
		model.addAttribute("sellerProduct", sellerProduct);
		return "user_market";
	}
	@PostMapping("QuestionRegistPro")
	public String quewstionRegistPro(HttpSession session,@RequestParam(value =  "file" , required = false) MultipartFile[] imageList
			,@RequestParam Map<String, String> map) {
			String sId = (String)session.getAttribute("sId");
			if(sId == null || sId.equals("")) return "not_login";
			
			String uploadDir = "/qna_img/";//가상 업로드 경로
			String saveDir = session.getServletContext().getRealPath(uploadDir);//실제 업로드 경로
			// 맵에 이름과 경로 전달
			//실제 파일 이름과 uuid랜덤합쳐서 겹치는걸 방지
			System.out.println("머가 넘어올까 ? " + map);
			
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
	@PostMapping("ReportRegistPro")
	public String reportRegistPro(HttpSession session,@RequestParam(value =  "file" , required = false) MultipartFile[] imageList
			,@RequestParam Map<String, String> map) {
//		System.out.println("신고 : " + map);
		
		String sId = (String)session.getAttribute("sId");
		if(sId == null || sId.equals("")) return "not_login";
		
		String uploadDir = "/report_img/";//가상 업로드 경로
		String saveDir = session.getServletContext().getRealPath(uploadDir);//실제 업로드 경로
		// 맵에 이름과 경로 전달
		//실제 파일 이름과 uuid랜덤합쳐서 겹치는걸 방지
		System.out.println(map);
	
		map.put("sId", sId);
		int insertCount = service.insertReport(map);
		
		if(insertCount == 0) return "fail_back";
		for(MultipartFile file : imageList) {
			String fileName = uuid(file.getOriginalFilename());
			map.put("real_file", uploadDir + fileName);
			map.put("file_name", fileName);
			int insertReportImgCount = service.insertReportImg(map);
			
			
			if(insertReportImgCount == 0) return "fail_back";
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
		return service.selectProduct(product_name);
//		return null;
	}	
	
	//시세검색 ajax
	@ResponseBody
	@PostMapping("SelectProductPrice")
	public List<Map<String, String>> selectProductPrice(@RequestParam(required = false) String product_name) {
		System.out.println("시세조회 검색어 3333333333: " + product_name);
		System.out.println("fdfsfsfs 3333333333333333: " +  service.selectProductPrice(product_name));
		return service.selectProductPrice(product_name);
//		return null;
	}	
	
	@ResponseBody
	@PostMapping("SelectOftenQna")
	public List<Map<String, String>> selectOftenQna(@RequestParam(required = false) Map<String, String> map) {
		System.out.println("카테고리 : " + map);
//		System.out.println(service.selectOftenQna(map));
	return service.selectOftenQna(map);

	}	
	@ResponseBody
	@PostMapping("DeleteQnaCategoryDetail")
	public void deleteQnaCategoryDetail(@RequestParam(required = false)int qnaCategoryDetailNum) {
		service.deleteQnaCategoryDetail(qnaCategoryDetailNum);
	}	
	@ResponseBody
	@PostMapping("InsertQnaCategoryDetail")
	public void insertQnaCategoryDetail(@RequestParam(required = false)Map<String, String> map) {
		System.out.println("나와라~~~~~" + map);
		service.insertQnaCategoryDetail(map);
	}	
	@ResponseBody
	@PostMapping("DeleteProductCategory")
	public void deleteProductCategory(@RequestParam int product_category_num) {
		System.out.println("fdfdfdfdf : " + product_category_num);
		service.deleteProductCategory(product_category_num);
	}	
	@ResponseBody
	@PostMapping("InsertProductCategory")
	public void insertProductCategory(@RequestParam String product_category_name) {
		System.out.println("fdfdfdfdf : " + product_category_name);
		service.insertProductCategory(product_category_name);
	}	
	@ResponseBody
	@PostMapping("InsertQnaCategory")
	public void insertQnaCategory(@RequestParam String qnaCategoryName) {
		System.out.println("fdfdfdfdf : " + qnaCategoryName);
		service.insertQnaCategory(qnaCategoryName);
	}	
	@ResponseBody
	@PostMapping("DeleteQnaCategory")
	public void deleteQnaCategory(@RequestParam String qnaCategoryNum) {
		System.out.println("fdfdfdfdf : " + qnaCategoryNum);
		service.deleteQnaCategory(qnaCategoryNum);
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
	@ResponseBody
	@PostMapping("AddFavorite")
	public String addFavorite(@RequestParam Map<String, Object> param, HttpSession session) {
		System.out.println("insert insertinsertinsertinsertinsert" + param);
	   int insertCount = service.registFavorite(param);
	   if(insertCount == 0 ) {
		   System.out.println("인설트 안됌!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
	   }
	   return "on";
	}

	// 관심상품 삭제
	@ResponseBody
	@PostMapping("RemoveFavorite")
	public String removeFavorite(@RequestParam Map<String, Object> param, HttpSession session) {
		System.out.println("fdfdfdfdfdfd" + param);
	   int deleteCount = service.deleteFavorite(param);
	   return "off";
	}
	@ResponseBody
	@PostMapping("selectFavorite")
	public String selectFavorite(@RequestParam Map<String, Object> param, HttpSession session) {
		System.out.println("fdfdfdfdfdfd" + param);
		Map<String, String> selectFavorite = service.selectFavorite(param);
		System.out.println(selectFavorite);
		if(selectFavorite == null) {
			return "off";
		}
		return "on";
	}

}
