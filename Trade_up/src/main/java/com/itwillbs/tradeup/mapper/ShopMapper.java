package com.itwillbs.tradeup.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface ShopMapper {

	// 상품 등록
	int registProduct(Map<String, Object> map);

	// 상품 이미지 등록
	int registProductImg(Map<String, Object> map);

	// 상품목록 조회
	List<Map<String, Object>> selectProductList();

	// 상품 상세조회
	Map<String, Object> getProduct(int product_num);
	
	// 상품 상세조회 이미지
	List<Map<String, Object>> getProductImg(int product_num);

	// 상품 카테고리 조회
	Map<String, Object> getCategory(int product_num);
	
	// 판매자 상품 조회
	List<Map<String, Object>> getSellerProduct(String member_id);
	
	// 상품 수정
	int updateProduct(Map<String, Object> map);
	
	// 상품 이미지 수정
	int updateProductImg(Map<String, Object> map);
	
	// 판매자 상품 개수
	int getSellerCount(int product_num);

	// 카테고리 순
	List<Map<String, Object>> fillterProductList(String category_name);
	
	// 카테고리 순
	List<Map<String, Object>> searchProductList(String search);

	// 최신 목록
	List<Map<String, Object>> lastProductList(String category_name);
	
	// 찜 목록
	List<Map<String, Object>> jjimProductList(String category_name);
	
	// 낮은 가격순
	List<Map<String, Object>> lowProductList(String category_name);
	
	// 높은 가격순
	List<Map<String, Object>> highProductList(String category_name);
	
	// 최신 목록
	List<Map<String, Object>> relastProductList();
	
	// 찜 목록
	List<Map<String, Object>> rejjimProductList();
	
	// 낮은 가격순
	List<Map<String, Object>> relowProductList();
	
	// 높은 가격순
	List<Map<String, Object>> rehighProductList();

	String selectJJim(int product_num);

	String selectSellCount(String member_id);
	
	String selectAllCount();

//	int selectAccount(String sId);
	
	// 상품 이미지 삭제
	int delectProductImg(String product_num);
	
	

}














