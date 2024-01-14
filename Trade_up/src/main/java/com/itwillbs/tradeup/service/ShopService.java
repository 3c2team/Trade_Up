package com.itwillbs.tradeup.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.tradeup.mapper.ShopMapper;


@Service
public class ShopService {
	@Autowired
	private ShopMapper mapper;

	// 상품 등록
	public int registProduct(Map<String, Object> map) {
		return mapper.registProduct(map);
	}
	
	// 상품 사진 등록
	public int registProductImg(Map<String, Object> map) {
		return mapper.registProductImg(map);
	}
	
	// 상품 상세정보 조회
	public Map<String, Object> getProduct(int product_num) {
		Map<String, Object> productDetail = mapper.getProduct(product_num);
		
		return productDetail; 
	}

	// 상품 이미지 조회 
	public List<Map<String, Object>> getProductImg(int product_num) {
		return mapper.getProductImg(product_num);
	}
	
	// 상품 수정 
	public int updateProduct(Map<String, Object> map) {
		return mapper.updateProduct(map);
	}
	
	// 상품 이미지 수정 요청
	public int updateProductImg(Map<String, Object> map) {
		return mapper.updateProductImg(map);
	}
	
	// 상품 리스트 조회
	public List<Map<String, Object>> selectProductList() {
		return mapper.selectProductList();
	}
	
	// 상품별 카테고리 조회
	public Map<String, Object> getCategory(int product_num) {
		return mapper.getCategory(product_num);
	}
	
	// 판매자 상품 조회
	public List<Map<String, Object>> getSellerProduct(String member_id) {
		return mapper.getSellerProduct(member_id);
	}
	
	// 판매자 상품 갯수 조회
	public int getSellerCount(int product_num) {
		return mapper.getSellerCount(product_num);
	}
	
	// 카테고리 별 상품 조회
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
	
	public List<Map<String, Object>> relastProductList() {
		return mapper.relastProductList();
	}
	
	public List<Map<String, Object>> rejjimProductList() {
		return mapper.rejjimProductList();
	}
	
	public List<Map<String, Object>> rehighProductList() {
		return mapper.rehighProductList();
	}
	
	public List<Map<String, Object>> relowProductList() {
		return mapper.relowProductList();
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
	
	// 대표계좌 여부
//	public int selectAccount(String sId) {
//		return mapper.selectAccount(sId);
//	}
	
	// 상품 이미지 삭제
	public int delectProductImg(String product_num) {
		return mapper.delectProductImg(product_num);
	}


}






