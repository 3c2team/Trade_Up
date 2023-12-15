package com.itwillbs.tradeup.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.tradeup.mapper.MainMapper;


@Service
public class MainService {
	
	@Autowired
	MainMapper mapper;
	
	public List<Map<String, String>> selectCategory() {
		// TODO Auto-generated method stub
		return mapper.selectCategory();
	}

	public List<Map<String, Object>> selectProduct(Map<String, String> map) {
		// TODO Auto-generated method stub
		return mapper.selectProduct(map);	
	}

	public List<Map<String, String>>  selectQnaCategory() {
		// TODO Auto-generated method stub
		return mapper.selectQnaCategory();		
	}


	public List<Map<String, String>> selectQnaCategoryDetail(String qnaCategoryName) {
		// TODO Auto-generated method stub
		return mapper.selectQnaCategoryDetail(qnaCategoryName);
	}

	public List<Map<String, String>> selectCategoryDetail(int qnaCategoryName) {
		// TODO Auto-generated method stub
		return mapper.selectQnaCategoryDetail(qnaCategoryName);
	}

	public int insertQuestion(Map<String, String> map) {
		// TODO Auto-generated method stub
		return mapper.insertQuestion(map);
	}

	public int insertQuestionImg(Map<String, String> map) {
		// TODO Auto-generated method stub
		return mapper.insertQuestionImg(map);
	}

	public List<Map<String, String>> selectOftenQna(Map<String, String> map) {
		// TODO Auto-generated method stub
		return  mapper.selectOftenQna(map);
	}

	public List<Map<String, String>> selectUserQna(String sId) {
		// TODO Auto-generated method stub
		return mapper.selectUserQna(sId);
	}

	public Map<String, String> selectQnaDetail(int qna_num) {
		// TODO Auto-generated method stub
		return mapper.selectQnaDetail(qna_num);
	}

	public List<Map<String, String>> selectProductPrice(String product_name) {
		// TODO Auto-generated method stub
		return mapper.selectProductPrice(product_name);
	}

	public List<Map<String, String>> selectProduct(String product_name) {
		// TODO Auto-generated method stub
		return mapper.selectMarketProduct(product_name);
	}

	public int insertReport(Map<String, String> map) {
		// TODO Auto-generated method stub
		return mapper.insertReport(map);
	}

	public int insertReportImg(Map<String, String> map) {
		// TODO Auto-generated method stub
		return mapper.insertReportImg(map);
	}

	public List<Map<String, String>> selectUserReport(String sId) {
		// TODO Auto-generated method stub
		return mapper.selectUserReport(sId);	
	}

	public List<Map<String, String>> selectSellerProduct(String member_id) {
		// TODO Auto-generated method stub
		return mapper.selectSellerProduct(member_id);	
	}

	public int registFavorite(Map<String, Object> param) {
		// TODO Auto-generated method stub
		return mapper.registFavorite(param);	
	}

	public int deleteFavorite(Map<String, Object> param) {
		// TODO Auto-generated method stub
		return mapper.deleteFavorite(param);	
	}

	public Map<String, String> selectFavorite(Map<String, Object> param) {
		// TODO Auto-generated method stub
		return mapper.selectFavorite(param);	
	}
	public List<Map<String, Object>> mainProductList(String sId) {
		// TODO Auto-generated method stub
		return mapper.mainProductList(sId);
	}

	public Map<String, String> sellerCount(String member_id) {
		// TODO Auto-generated method stub
		return mapper.sellerCount(member_id);
	}

	public void deleteProductCategory(int product_category_num) {
		// TODO Auto-generated method stub
		mapper.deleteProductCategory(product_category_num);
	}

	public void insertProductCategory(String product_category_name) {
		// TODO Auto-generated method stub
		mapper.insertProductCategory(product_category_name);
	}

	public void deleteQnaCategoryDetail(int qnaCategoryDetailNum) {
		// TODO Auto-generated method stub
		mapper.deleteQnaCategoryDetail(qnaCategoryDetailNum);
	}

	public void insertQnaCategoryDetail(Map<String, String> map) {
		// TODO Auto-generated method stub
		mapper.insertQnaCategoryDetail(map);
	}

	public void insertQnaCategory(String qnaCategoryName) {
		// TODO Auto-generated method stub
		mapper.insertQnaCategory(qnaCategoryName);
	}

	public void deleteQnaCategory(String qnaCategoryNum) {
		// TODO Auto-generated method stub
		mapper.deleteQnaCategory(qnaCategoryNum);
	}
}
