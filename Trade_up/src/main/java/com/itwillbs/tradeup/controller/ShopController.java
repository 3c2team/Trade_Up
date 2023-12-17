package com.itwillbs.tradeup.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
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
import com.itwillbs.tradeup.service.ShopService;

import retrofit2.http.GET;

@Controller
public class ShopController {
	
	@Autowired
	MainService service;
	
	@Autowired
	ShopService shopService;
	
	
	@GetMapping("Shop")
	public String shop(Model model,@RequestParam(required = false) Map<String,String> map
						, HttpSession session) {
		
		List<Map<String, String>> selectCategory = service.selectCategory();
		
//		Map<String, String> dateTime = shopService.dateTime(product_num);

		if(map.get("price") != null) {
			String[] price = map.get("price")
							.replace("만원", "0000")
							.replace("이상", "")
							.replace("이하", "")
							.trim()
							.split("-");
			for(int i = 0; i < price.length; i++) {
				if(i == 1) {
					map.put("minPrice", price[i]);
				}
				map.put("maxPrice", price[i]);
			}
		}
		
		List<Map<String, Object>> productList = shopService.selectProductList();
		
		String allCount = shopService.selectAllCount();
		
		model.addAttribute("productList", productList);
		model.addAttribute("selectCategory", selectCategory);
		model.addAttribute("allCount", allCount);
//		model.addAttribute("dateTime", dateTime);
		
		return "shop/shop";
	}
	
	@ResponseBody
	@PostMapping("FillterProduct")
	public List<Map<String, Object>> fillterProduct(@RequestParam(required = false) String category_name) {
//		System.out.println("category_idx: " + category_name);
		return shopService.fillterProductList(category_name);
	}	
	@ResponseBody
	@PostMapping("SearchProduct")
	public List<Map<String, Object>> searchProduct(@RequestParam(required = false)String search) {
//		System.out.println("category_idx: " + category_name);
		return shopService.searchProductList(search);
	}	
	
	@ResponseBody
	@PostMapping("LastProduct")
	public List<Map<String, Object>> lastProduct(@RequestParam(required = false) String category_name) {
//		System.out.println("category_idx: " + category_name);
		return shopService.lastProductList(category_name);
	}	
	@ResponseBody
	@PostMapping("JjimProduct")
	public List<Map<String, Object>> jjimProduct(@RequestParam(required = false) String category_name) {
//		System.out.println("category_idx: " + category_name);
		return shopService.jjimProductList(category_name);
	}	
	
	@ResponseBody
	@PostMapping("HighProduct")
	public List<Map<String, Object>> highProduct(@RequestParam(required = false) String category_name) {
//		System.out.println("category_idx: " + category_name);
		return shopService.highProductList(category_name);
	}	
	
	@ResponseBody
	@PostMapping("LowProduct")
	public List<Map<String, Object>> lowProduct(@RequestParam(required = false) String category_name) {
//		System.out.println("category_idx: " + category_name);
		return shopService.lowProductList(category_name);
	}	
	
	
	@GetMapping("ShopForm")
	public String shopForm(@RequestParam(required = false) Map<String,String> map
							, HttpSession session, Model model) {
		String sId = (String)session.getAttribute("sId");
		// 로그인X 처리
		if(sId == null) {
			model.addAttribute("msg", "로그인 후 이용부탁드립니다.");
			model.addAttribute("targetURL", "redirect:/");
			return "fail_back";
		}
//		int count = shopService.selectAccount(sId);
//		if(count != 1) {
//			model.addAttribute("msg", "대표계좌를 설정해주세요.");
//			model.addAttribute("targetURL", "redirect:/");
//			return "fail_back";
//		}
		
		List<Map<String, String>> selectCategory = service.selectCategory();
//		System.out.println(selectCategory);
		model.addAttribute("selectCategory",selectCategory);
		return "shop/shop_form";
	}
	
	// 등록 완료
	@PostMapping("ShopSuccess")
	public String shopSuccess(@RequestParam Map<String, Object> map
							  ,@RequestParam(value = "file", required=false) MultipartFile[] file
							  , HttpSession session, Model model) {
		System.out.println("오긴옴?" + map);
		
//		거래 방식 지정
		if(map.containsKey("trading_method1") && map.containsKey("trading_method2")) {
			map.put("trading_method", "total");
		}
		if (!map.containsKey("trading_method1")) {
			map.put("trading_method", map.get("trading_method2"));
		}
		if (!map.containsKey("trading_method2")) {
			map.put("trading_method", map.get("trading_method1"));
		} 
		
		map.put("product_price", map.get("product_price")+"원");
		
//		if(!map.containsKey("trading_location")) {
//			map.put("trading_location", "");
//		}
		
		//--------------------- < 이미지 경로 : 가상, 실제 경로> ---------------------
		String sId = (String)session.getAttribute("sId");
		String uploadDir = "/TradeUp_upload/product_image/";
		String saveDir = session.getServletContext().getRealPath(uploadDir).replace("Trade_up/", ""); //.replace("프로젝트명"); 추가하기
		
		map.put("member_id", sId);
		
		//===================== < 이미지 처리 : yyyy/MM/dd 형식 > ===================== 
		String subDir = "";
		try {
			LocalDate now = LocalDate.now();
			DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd");
			subDir = now.format(dtf);
			saveDir += subDir;
			
			Path path = Paths.get(saveDir);
			Files.createDirectories(path);
		} catch (IOException e) {
			e.printStackTrace();
		}
			
		//-------------------- < 이미지명 처리 : 3자리 랜덤 > --------------------
		String uuid = UUID.randomUUID().toString();
		System.out.println("s234123515163456 : " + file);
		int insertImgCount = 0;
		int insertCount = 0;
		int index = 0;
		try {
			for(MultipartFile file2 : file) {
//				System.out.println("여기 안와? : " + file2.getOriginalFilename());
					
				String fileName =  uuid.substring(0, 3) + "_" + file2.getOriginalFilename();
				
				if(file == null || fileName.equals("")) {
					map.put("file_name", "");
				} 
				map.put("file_name", uploadDir + subDir + "/" + fileName);
				
				map.put("product_image", uploadDir + subDir + "/" + fileName);
				file2.transferTo(new File(saveDir, fileName));
//				System.out.println("프로덕트에 넣을 수 있어? : "+map.get("file_name"));
				
				if(index < 1) {
					insertCount = shopService.registProduct(map);
				}
				insertImgCount = shopService.registProductImg(map);
//				System.out.println(" 이미지 몇개씩 들어있어? :"+map.get("product_image"));
				
				index++;
			}
			if(insertCount > 0 && insertImgCount > 0) { //성공
				model.addAttribute("msg", "판매할 상품을 등록했습니다.");
				model.addAttribute("targetURL", "Shop");
				return "forward";
			}
			//------------------ < 게시물 등록 처리 > -------------------
		} catch (Exception e) {
			e.printStackTrace();
		} 
		
		model.addAttribute("msg", "상품등록을 실패했습니다.");
		model.addAttribute("targetURL", "redirect:/ShopForm");
		return "fail_back";
	}
	
	// 상세페이지
	@GetMapping("ShopDetail")
	public String productDetail(@RequestParam Map<String, Object> map
			  , int product_num
			  , HttpSession session, Model model) {
		
		map.put("sId", session.getAttribute("sId"));

		// 상품 정보 조회
		Map<String, Object> product = shopService.getProduct(product_num);

		// 이미지 조회
		List<Map<String, Object>> productImg = shopService.getProductImg(product_num);
		
		// 판매자 
		List<Map<String, Object>> sellerProduct = shopService.getSellerProduct((String)product.get("member_id"));
		
		String date = sellerProduct.get(0).get("product_release").toString();
		System.out.println("변환하기 전!!!!! :" + date);

		int sellerCount = shopService.getSellerCount(product_num);
		
		// 카테고리 조회
		Map<String, Object> category = shopService.getCategory(product_num);
		
		List<Map<String, Object>> productList = shopService.selectProductList();
		
		String jjim = shopService.selectJJim(product_num);
		
		String sellCount = shopService.selectSellCount((String)product.get("member_id"));
		
		model.addAttribute("product", product);
		model.addAttribute("productImg", productImg);
		model.addAttribute("category", category);
		model.addAttribute("sellerProduct", sellerProduct);
		model.addAttribute("sellerCount", sellerCount);
		model.addAttribute("productList", productList);
		model.addAttribute("jjim", jjim);
		model.addAttribute("sellCount", sellCount);

		return "shop/shop_details";
	}
	
	// 상품 상세 페이지에서 결제 페이지 이동
	@GetMapping("ShopPay")
	public String shopPay(@RequestParam int product_num, Model model) {
		model.addAttribute("product_num", product_num);
		return "shop/shop_pay";
	}
	
	// 마이페이지에서 상품 수정 페이지 이동
	@GetMapping("ShopUpdatePro")
	public String shopUpdatePro(@RequestParam  int product_num, Model model) {
		List<Map<String, String>> selectCategory = service.selectCategory();

		Map<String, Object> product = shopService.getProduct(product_num);
		product.put("product_price", product.get("product_price").toString().replace("원", ""));
		
		List<Map<String, Object>> productImg = shopService.getProductImg(product_num);

		model.addAttribute("selectCategory", selectCategory);
		model.addAttribute("product", product);
		model.addAttribute("productImg", productImg);
		
		return "shop/shop_update";
	}
	
	// 상품 수정
	@PostMapping("ShopUpdate")
	public String shopUpdate(@RequestParam Map<String, Object> map
							  ,@RequestParam(value = "file", required=false) MultipartFile[] file
							  , HttpSession session, Model model) {
		System.out.println("오긴옴?" + map);
		
		//거래 방식 지정
		if(map.containsKey("trading_method1") && map.containsKey("trading_method2")) {
			map.put("trading_method", "total");
		}
		if (!map.containsKey("trading_method1")) {
			map.put("trading_method", map.get("trading_method2"));
		}
		if (!map.containsKey("trading_method2")) {
			map.put("trading_method", map.get("trading_method1"));
		} 
		
		map.put("product_price", map.get("product_price")+"원");
		
		//if(!map.containsKey("trading_location")) {
		//map.put("trading_location", "");
		//}
		
		//--------------------- < 이미지 경로 : 가상, 실제 경로> ---------------------
		String sId = (String)session.getAttribute("sId");
		String uploadDir = "/TradeUp_upload/product_image/";
		String saveDir = session.getServletContext().getRealPath(uploadDir).replace("Trade_up/", ""); //.replace("프로젝트명"); 추가하기
		
		map.put("member_id", sId);
		
		//===================== < 이미지 처리 : yyyy/MM/dd 형식 > ===================== 
		String subDir = "";
		try {
			LocalDate now = LocalDate.now();
			DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd");
			subDir = now.format(dtf);
			saveDir += subDir;
			
			Path path = Paths.get(saveDir);
			Files.createDirectories(path);
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		//-------------------- < 이미지명 처리 : 3자리 랜덤 > --------------------
		String uuid = UUID.randomUUID().toString();
		System.out.println("s234123515163456 : " + file);
		int insertImgCount = 0;
		int insertCount = 0;
		int index = 0;
		try {
			for(MultipartFile file2 : file) {
			//System.out.println("여기 안와? : " + file2.getOriginalFilename());
			
				String fileName =  uuid.substring(0, 3) + "_" + file2.getOriginalFilename();
				
				if(file == null || fileName.equals("")) {
					map.put("file_name", "");
				} 
				map.put("file_name", uploadDir + subDir + "/" + fileName);
				
				map.put("product_image", uploadDir + subDir + "/" + fileName);
				file2.transferTo(new File(saveDir, fileName));
				//System.out.println("프로덕트에 넣을 수 있어? : "+map.get("file_name"));
				
				if(index < 1) {
					insertCount = shopService.registProduct(map);
				}
				
				insertImgCount = shopService.registProductImg(map);
				//System.out.println(" 이미지 몇개씩 들어있어? :"+map.get("product_image"));
				
				index++;
			}
				if(insertCount > 0 && insertImgCount > 0) { //성공
					model.addAttribute("msg", "판매할 상품을 등록했습니다.");
					model.addAttribute("targetURL", "Shop");
					return "forward";
				}
		//------------------ < 게시물 등록 처리 > -------------------
		} catch (Exception e) {
			e.printStackTrace();
		} 
		
			model.addAttribute("msg", "상품등록을 실패했습니다.");
			model.addAttribute("targetURL", "redirect:/ShopForm");
			return "fail_back";
		}
	
	
}
