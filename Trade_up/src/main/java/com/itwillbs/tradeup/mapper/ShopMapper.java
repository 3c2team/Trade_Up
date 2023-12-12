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
	List<Map<String, Object>> getSellerProduct(int product_num);
	
	// 상품 수정
	int updateProduct(Map<String, Object> map);
	
	// 상품 이미지 수정
	int updateProductImg(Map<String, Object> map);
	
	// 상품 이미지 삭제
	int delectProductImg(int product_num);
	
	// 판매자 상품 개수
	int getSellerCount(int product_num);
	
	// 찜 목록
	List<Map<String, Object>> jjimProductList(String category_idx);

}














