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
		
//		// 2. 조회 결과가 있을 경우
//		if(productList != null) {
//			// Mapper - updateReadcount() 메서드 호출하여 조회수 증가 요청
//			// 조회 수 증가 후 수동으로 List<Map<String, Object>> 객체의 조회수 값을 수정하지 않고
//			// 마이바티스의 <selectKey> 태그 활용하여 자동 증가시킨 값을 저장
//			// => 별도로 결과를 리턴받지 않아도 List<Map<String, Object>> 객체를 공유하므로 자동으로 증가된 값 저장됨
//			// => 따라서, 파라미터로 List<Map<String, Object>> 객체 전달(board_num 포함되어 있음)
//			// ------------
//			// 단, 조회수 증가 수행 여부 판단을 위해 
//			// isUpdateReadcount 변수값이 true 일 경우에만 조회수 증가를 수행
//			// ex) 글 수정 or 답글 작성을 위한 상세조회 시에는 false 값을 전달하여 조회수 증가 X
//			if(isUpdateReadcount) {
//				mapper.updateReadcount(productList);
//			}
//		}
		return productDetail; 
	}

	// 글목록 조회 요청
	public List<Map<String, Object>> getProductImg(int product_num) {
		return mapper.getProductImg(product_num);
	}
//
//	// 전체 게시물 수 조회 요청
//	public int getBoardListCount(String searchType, String searchKeyword) {
//		return mapper.selectBoardListCount(searchType, searchKeyword);
//	}
//	
//	public Map<String, Object> getProductDetail(Map<String, Object> param) {
//		return null;
//	}
//
//
//	// 파일명 조회 요청
//	public List<Map<String, Object>> getBoardFileNames(List<Map<String, Object>> board) {
//		return mapper.selectBoardFileNames(board);
//	}
//
//	// 글 삭제 요청
//	public int removeBoard(List<Map<String, Object>> board) {
//		return mapper.deleteBoard(board);
//	}
//
//	// 파일명 삭제 요청
//	public int removeBoardFile(List<Map<String, Object>> board) {
//		return mapper.deleteBoardFile(board);
//	}
//
//	// 글 수정 요청
//	public int modifyBoard(List<Map<String, Object>> board) {
//		return mapper.updateBoard(board);
//	}
//
//	// 답글 등록 요청
//	@Transactional
//	public int registReplyBoard(List<Map<String, Object>> board) {
//		// 기존 답글 순서번호 조정을 위해 updateBoardReSeq() 메서드 호출
//		// => 파라미터 : List<Map<String, Object>> 객체   리턴타입 : void
//		mapper.updateBoardReSeq(board);
//		
//		// 답글 등록 작업을 위해 insertReplyBoard() 메서드 호출
//		// => 파라미터 : List<Map<String, Object>>   리턴타입 : int
//		return mapper.insertReplyBoard(board);
//	}
//
//	// 댓글 등록 작업 요청
//	// => 트랜잭션 적용을 위해 메서드 정의 시 @Transactional 어노테이션 적용
//	@Transactional
//	public int registTinyReplyBoard(Map<String, String> map) {
////		return mapper.insertTinyReplyBoard(map);
//		
//		mapper.insertTinyReplyBoard(map);
//		
//		// ---- 트랜잭션 확인을 위한 더미 데이터(이름을 null 값으로 설정 - DB INSERT 불가) ----
//		map.remove("reply_name");
//		map.put("reply_name", null);
//		mapper.insertTinyReplyBoard(map);
//		
//		return 0;
//	}
//
//	// 댓글 목록 조회 요청
//	public  getTinyReplyBoardList(int board_num) {
//		return mapper.selectTinyReplyBoardList(board_num);
//	}
//
//	// 댓글 삭제 요청
//	public int removeTinyReplyBoard(Map<String, String> map) {
//		return mapper.deleteTinyReplyBoard(map);
//	}
//	
//	// 대댓글 등록 요청
//	@Transactionals
//	public int registTinyReReplyBoard(Map<String, String> map) {
//		// 기존 댓글들의 순서 조정(댓글이 최신 순으로 정렬됨)
//		mapper.updateTinyReplyBoardSeq(map);
//		// 대댓글 등록 요청
//		return mapper.insertTinyReReplyBoard(map);
//	}

	public List<Map<String, Object>> selectProductList() {
		return mapper.selectProductList();
	}

	public Map<String, Object> getCategory(int product_num) {
		return mapper.getCategory(product_num);
	}


}






