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
}
