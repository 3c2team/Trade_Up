package com.itwillbs.tradeup.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface ShopMapper {

	// 글쓰기
	int registProduct(Map<String, Object> map);

	// 글쓰기 사진 등
	int registProductImg(Map<String, Object> map);

	// 상품목록 조회
	List<Map<String, Object>> selectProductList();

	// 상품 상세조회
	Map<String, Object> getProduct(int product_num);
	
	// 상품 상세조회 이미지
	List<Map<String, Object>> getProductImg(int product_num);

	// 상품 카테고리 조회
	Map<String, Object> getCategory(int product_num);

}














