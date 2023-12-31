package com.itwillbs.tradeup.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface MainMapper {

	List<Map<String, String>> selectCategory();

	List<Map<String, Object>> selectProduct(Map<String, String> map);

	List<Map<String, String>>  selectQnaCategory();

	List<Map<String, String>> selectQnaCategoryDetail(String qnaCategoryName);

	List<Map<String, String>> selectQnaCategoryDetail(int qnaCategoryName);

	int insertQuestion(Map<String, String> map);

	int insertQuestionImg(Map<String, String> map);

	List<Map<String, String>> selectOftenQna(Map<String, String> map);

	List<Map<String, String>> selectUserQna(String sId);

	Map<String, String> selectQnaDetail(int qna_num);

	List<Map<String, String>> selectProductPrice(String product_name);

	List<Map<String, String>> selectMarketProduct(String product_name);

	int insertReport(Map<String, String> map);

	int insertReportImg(Map<String, String> map);

	List<Map<String, String>> selectUserReport(String sId);

	List<Map<String, String>> selectSellerProduct(String member_id);

	int registFavorite(Map<String, Object> param);

	int deleteFavorite(Map<String, Object> param);

	Map<String, String> selectFavorite(Map<String, Object> param);

	List<Map<String, Object>> mainProductList(String sId);

	Map<String, String> sellerCount(String member_id);

	void deleteProductCategory(int product_category_num);

	void insertProductCategory(String product_category_name);

	void deleteQnaCategoryDetail(int qnaCategoryDetailNum);

	void insertQnaCategoryDetail(Map<String, String> map);

	void insertQnaCategory(String qnaCategoryName);

	void deleteQnaCategory(String qnaCategoryNum);


}
