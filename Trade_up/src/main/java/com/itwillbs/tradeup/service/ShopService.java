package com.itwillbs.tradeup.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.tradeup.mapper.ShopMapper;


@Service
public class ShopService {
	// ShopMapper 객체 자동 주입
	@Autowired
	private ShopMapper mapper;

	// 글쓰기 작업 요청
	public int registProduct(Map<String, Object> map) {
		return mapper.registProduct(map);
	}
	
	// 글쓰기 사진 등록
	public int registProductImg(Map<String, Object> map) {
		return mapper.registProductImg(map);
	}
	
	// 글 상세정보 조회 요청(조회 성공 시 조회수 증가)
	public Map<String, Object> getProduct(int product_num) {
		// 1. Mapper - selectBoard() 메서드 호출하여 상세정보 조회 요청 후 결과를 List<Map<String, Object>> 객체에 저장
		Map<String, Object> productDetail = mapper.getProduct(product_num);
		
		return productDetail; 
	}

	// 글목록 조회 요청
	public List<Map<String, Object>> getProductImg(int product_num) {
		return mapper.getProductImg(product_num);
	}
	
	// 상품 수정 요청
	public int updateProduct(Map<String, Object> map) {
		return mapper.updateProduct(map);
	}
	
	// 상품이미지 수정 요청
	public int updateProductImg(Map<String, Object> map) {
		return mapper.updateProductImg(map);
	}

	public List<Map<String, Object>> selectProductList() {
		return mapper.selectProductList();
	}

	public Map<String, Object> getCategory(int product_num) {
		return mapper.getCategory(product_num);
	}

	public List<Map<String, Object>> getSellerProduct(String member_id) {
		return mapper.getSellerProduct(member_id);
	}

	public int delectProductImg(int product_num) {
		return mapper.delectProductImg(product_num);
	}

	public int getSellerCount(int product_num) {
		return mapper.getSellerCount(product_num);
	}

	public List<Map<String, Object>> fillterProductList(String category_name) {
		return mapper.fillterProductList(category_name);
	}
	public List<Map<String, Object>> searchProductList(String search) {
		return mapper.searchProductList(search);
	}

	public List<Map<String, Object>> lastProductList(String category_name) {
		return mapper.lastProductList(category_name);
	}
	
	public List<Map<String, Object>> jjimProductList(String category_name) {
		return mapper.jjimProductList(category_name);
	}
	
	public List<Map<String, Object>> highProductList(String category_name) {
		return mapper.highProductList(category_name);
	}

	public List<Map<String, Object>> lowProductList(String category_name) {
		return mapper.lowProductList(category_name);
	}

	public String selectJJim(int product_num) {
		return mapper.selectJJim(product_num);
	}

	public String selectSellCount(String member_id) {
		return mapper.selectSellCount(member_id);
	}
	
	public String selectAllCount() {
		return mapper.selectAllCount();
	}
	
	public Map<String, Object> dateTime(int product_num) {
		return mapper.dateTime(product_num);
	}

	public int selectAccount(String sId) {
		return mapper.selectAccount(sId);
	}


}






