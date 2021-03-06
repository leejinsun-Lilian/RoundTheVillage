package com.kh.RoundTheVillage.board.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

//import javax.security.auth.message.callback.PrivateKeyCallback.Request;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.gson.Gson;
import com.kh.RoundTheVillage.board.model.service.BoardService;
import com.kh.RoundTheVillage.board.model.vo.Board;
import com.kh.RoundTheVillage.board.model.vo.PageInfo;
import com.kh.RoundTheVillage.board.model.vo.Search;
import com.kh.RoundTheVillage.member.model.vo.Member;

import sun.nio.ch.SelChImpl;

import com.kh.RoundTheVillage.board.model.vo.Attachment;

@Controller // 컨트롤러임을 알려줌 + bean 등록
@SessionAttributes({ "loginMember" })
@RequestMapping("/board/*") // 최상위 요청
public class BoardController {

	@Autowired // 등록된 bean 중에서 같은 타입인 bean을 자동적으로 의존성 주입
	private BoardService service;

	private String swalIcon = null;
	private String swalTitle = null;
	private String swalText = null;

	// 게시글 목록 조회 Controller
	@RequestMapping("list")
	public String boardList(@RequestParam(value = "cp", required = false, defaultValue = "1") int cp,
			@RequestParam(value = "ct", required = false) String ct, Model model) {
		PageInfo pInfo = service.getPageInfo(cp, ct);

		List<Board> bList = service.selectList(pInfo, ct);

		if (bList != null && !bList.isEmpty()) { // 게시글 목록 조회 성공 시 List<Attachment>
			List<Attachment> thumbnailList = service.selectThumbnailList(bList);

			if (thumbnailList != null) {
				model.addAttribute("thList", thumbnailList);

			}

		}

		model.addAttribute("bList", bList);
		model.addAttribute("pInfo", pInfo);

		return "board/boardList";
	}

	// 게시글 상세 조회
	@RequestMapping("{boardNo}")
	public String boardView(@PathVariable("boardNo") int boardNo, Model model,
			@ModelAttribute("loginMember") Member loginMember,
			@RequestHeader(value = "referer", required = false) String referer, RedirectAttributes ra) {

		Board board = service.selectBoard(boardNo);

		// System.out.println("보드 : " + board);
		String url = null;

		if (board != null) {

			List<Attachment> attachmentList = service.selectAttachmentList(boardNo);

			if (attachmentList != null && !attachmentList.isEmpty()) {
				model.addAttribute("attachmentList", attachmentList);
			}

			model.addAttribute("board", board);

			Map<String, Integer> map = new HashMap<String, Integer>();
			map.put("boardNo", boardNo);
			map.put("memberNo", loginMember.getMemberNo());
			int likeFl = service.selectLikeFl(map); // 0: 좋아요 X, 1:좋아요 누른적 있음
			model.addAttribute("likeFl", likeFl);

			url = "board/boardView";
			System.out.println(board);

		} else {
			// 이전 요청 주소가 없는 경우
			if (referer == null) {
				url = "redirect:../list";

			} else { // 이전 요청 주소가 있는 경우

				url = "redirect:" + referer;
			}

			ra.addFlashAttribute("swalIcon", "error");
			ra.addFlashAttribute("swalTitle", "존재하지 않는 게시글입니다.");
		}

		return url;

	}

	// 게시글 등록 화면 전환
	@RequestMapping("insert")
	public String insertView(@ModelAttribute("loginMember") Member loginMember, Model model, RedirectAttributes ra) {

		int memberNo = loginMember.getMemberNo();
		List<Board> selectClass = service.selectClass(memberNo);

		// 후기를 쓸 수업이 없을 경우
		if(selectClass.isEmpty()) {
			ra.addFlashAttribute("swalIcon", "info");
			ra.addFlashAttribute("swalTitle", "후기를 작성할 수 있는 수업 목록이 없습니다.");
			
			return "redirect:list";
		}else {
			model.addAttribute("selectClass", selectClass);
			return "board/boardInsert";
		}
		

	}

	// 게시글 등록 Controller
	@RequestMapping("insertAction")
	public String insertAction(@ModelAttribute Board board, // 작성한 글제목, 내용, 카테고리코드를 얻기위한 어노테이션
			@ModelAttribute("loginMember") Member loginMember,
			@RequestParam(value = "images", required = false) List<MultipartFile> images, HttpServletRequest request,
			RedirectAttributes ra) {

		Map<String, Object> map = new HashMap<String, Object>(); // 맵을 이용해 받아온 정보들을 한곳에 담기

		map.put("boardNo", board.getBoardNo()); // 세션에 올려져있는 멤버넘버
		map.put("memberNo", loginMember.getMemberNo()); // 세션에 올려져있는 멤버넘버
		// map.put("memberNo", 46); // 세션에 올려져있는 멤버넘버
		map.put("boardTitle", board.getBoardTitle()); // 내가 작성한 글제목
		map.put("boardContent", board.getBoardContent()); // 내가 작성한 글 내용
		map.put("classNo", board.getClassNo()); // 공방 번호
		// map.put("classCategoryNo", board.getClassCategoryNo()); // 카테고리 코드

		String savePath = null;

		savePath = request.getSession().getServletContext().getRealPath("resources/boardImages");

		int result = service.insertBoard(map, images, savePath);

		String url = null;

		if (result > 0) {
			swalIcon = "success";
			swalTitle = "게시글 등록 성공";
			url = "redirect:" + result;

			request.getSession().setAttribute("returnListURL", "list");

		} else {
			swalIcon = "error";
			swalTitle = "게시글 삽입 실패";
			url = "redirect:insert";
		}

		ra.addFlashAttribute("swalIcon", swalIcon);
		ra.addFlashAttribute("swalTitle", swalTitle);

		return url;

	}

	// summernote에 업로드 된 이미지 저장 Controller
	@ResponseBody // 응답 시 값 자체를 돌려보냄
	@RequestMapping(value={"insertImage", "{boardNo}/insertImage"})
	public String insertImage(HttpServletRequest request, @RequestParam("uploadFile") MultipartFile uploadFile) {

		// 서버에 파일(이미지)을 저장할 폴더 경로 얻어오기
		String savePath = request.getSession().getServletContext().getRealPath("resources/boardImages");

		Attachment at = service.insertImage(uploadFile, savePath);

		// java -> js로 객체 전달 : JSON

		return new Gson().toJson(at);
	}

	// 게시글 수정 화면 전환용 Controller
	@RequestMapping("{boardNo}/update")
	public String update(@PathVariable("boardNo") int boardNo, Model model) {

		// 1) 게시글 상세 조회
		Board board = service.selectBoard(boardNo);

		// 2) 해당 게시글에 포함된 이미지 목록 조회
		if (board != null) {

			List<Attachment> attachmentList = service.selectAttachmentList(boardNo);

			model.addAttribute("attachmentList", attachmentList);
			// null 값이 전달되어도 EL이 빈 문자열로 처리해줌

		}

		model.addAttribute("board", board);
		
		String url = "board.boardUpdate";

		return "board/boardUpdate";
	}
	
	   // 게시글 수정 Controller
	   @RequestMapping("{boardNo}/updateAction")
	   public String updateAction(@PathVariable("boardNo") int boardNo,
			   					  @ModelAttribute Board updateBoard,
			   					  Model model, RedirectAttributes ra,
			   					  HttpServletRequest request,
			   @RequestParam(value="images", required=false) List<MultipartFile> images) {
		   
		   // boardNo를 updateBoard에 세팅
		   updateBoard.setBoardNo(boardNo);
		   
		   
		   // 파일 저장 경로 얻어오기
		   String savePath = request.getSession().getServletContext().getRealPath("resources/boardImages");
		   
		   
		   // 파일 수정 Service 호출
		   int result = service.updateBoard(updateBoard, images, savePath);
		   
		   String url = null;
		   
		   if(result > 0) {
				swalIcon = "success";
				swalTitle = "게시글 수정 성공";
				url = "redirect:../"+boardNo;
			}else {
				swalIcon = "error";
				swalTitle = "게시글 수정 실패";
				url = "redirect:" + request.getHeader("referer");
			}
			
			ra.addFlashAttribute("swalIcon", swalIcon);
			ra.addFlashAttribute("swalTitle", swalTitle);

		   
		   return url;
	   }
	   
	
	
	
	
	
	
	
	
	
	
	

	// 좋아요 추가 Contoller
	@ResponseBody
	@RequestMapping("insertLike")
	public int insertLike(@RequestParam("boardNo") int boardNo, @ModelAttribute("loginMember") Member loginMember) {

		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("boardNo", boardNo);
		map.put("memberNo", loginMember.getMemberNo());

		int result = service.insertLike(map);

		return result;
	}

	// 좋아요 삭제 Contoller
	@ResponseBody
	@RequestMapping("deleteLike")
	public int deleteLike(@RequestParam("boardNo") int boardNo, @ModelAttribute("loginMember") Member loginMember) {

		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("boardNo", boardNo);
		map.put("memberNo", loginMember.getMemberNo());

		int result = service.deleteLike(map);

		return result;
	}

	// 좋아요 카운트 Contoller
	@ResponseBody
	@RequestMapping("selectLikeCount")
	public int selectLikeCount(@RequestParam("boardNo") int boardNo) {

		return service.selectLikeCount(boardNo);
	}

	// 게시글 검색 Controller

	@RequestMapping("search")
	public String searchBoard(@ModelAttribute Search search,
			@RequestParam(value = "cp", required = false, defaultValue = "1") int cp,
							Model model) {
System.out.println(search);
		PageInfo pInfo = service.selectSearchListCount(search, cp);
		
		List<Board> bList = service.selectSearchList(pInfo, search);

		if (bList != null && !bList.isEmpty()) { // 게시글 목록 조회 성공 시 List<Attachment>
			List<Attachment> thumbnailList = service.selectThumbnailList(bList);

			if (thumbnailList != null) {
				model.addAttribute("thList", thumbnailList);

			}

		}

		model.addAttribute("bList", bList);
		model.addAttribute("pInfo", pInfo);

		return "board/boardList";
	}
	
	
	

	@RequestMapping("report")
	public String reportBoard(@ModelAttribute("loginMember") Member loginMember, @RequestParam("boardNo") int boardNo,
								@RequestHeader(value = "referer", required = false) String referer,
								@RequestParam(value = "reportRadio") int reportCategory,
								@RequestParam(value = "reportContent") String reportContent, RedirectAttributes ra) {

		Map<String, Object> map = new HashMap<String, Object>();

		map.put("memberNo", loginMember.getMemberNo());
		map.put("boardNo", boardNo);
		map.put("reportCategory", reportCategory);
		map.put("reportContent", reportContent);

		System.out.println(map);

		int findReport = service.findReport(map);

		String url = "redirect:" + boardNo;
		
		if (findReport > 0) {

			swalIcon = "error";
			swalTitle = "게시글 신고는 한번만 가능합니다.";

		} else {

			int result = service.reportBoard(map);

			if (result > 0) {

				swalIcon = "success";
				swalTitle = "게시글이 신고되었습니다.";

			} else if(result == -1) { // 신고가 10개 되서 삭제된 경우
				swalIcon = "success";
				swalTitle = "게시글이 신고되었습니다.";
				url = "redirect:list";
				
			}else {

				swalIcon = "error";
				swalTitle = "게시글 신고에 실패하였습니다.";
			}

		}

		ra.addFlashAttribute("swalIcon", swalIcon);
		ra.addFlashAttribute("swalTitle", swalTitle);

		return url;

	}
	
	@RequestMapping("delete")
	public String deleteBoard(@RequestParam("boardNo") int boardNo, RedirectAttributes ra,
					HttpServletRequest request, @RequestParam(value = "referer", required = false) String referer) {
		
		int result = service.deleteBoard(boardNo);
		
		String url = null;
	
		 if(result > 0) {
    		 swalIcon = "success";
     		 swalTitle = "게시글이 삭제되었습니다.";
     		 url = "redirect:list";
     		
    	 }else {

    		 swalIcon = "error";
      		 swalTitle = "게시글 삭제 실패하였습니다.";
      		 url = "redirect:" + request.getHeader("referer");
      		
     	}
		 
		 ra.addFlashAttribute("swalIcon", swalIcon);
		 ra.addFlashAttribute("swalTitle", swalTitle);
		

			return url;
	}
	
	@RequestMapping("myBoardList")
	public String myBoardList(@RequestParam(value = "cp", required = false, defaultValue = "1") int cp, Model model,
							@ModelAttribute("loginMember") Member loginMember) {
		
		PageInfo mpInfo = service.getMyPageInfo(cp, loginMember);
		
		List<Board> mList = service.selectmyList(mpInfo, loginMember);
		
		System.out.println(mList);
		
		model.addAttribute("mList", mList);
		model.addAttribute("mPInfo", mpInfo);
		
		
		  return "board/myBoardList";
		  
		  
		 
	}
					
					
					
					
	
	
	

}
