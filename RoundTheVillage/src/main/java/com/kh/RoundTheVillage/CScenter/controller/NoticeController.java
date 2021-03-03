package com.kh.RoundTheVillage.CScenter.controller;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
import com.kh.RoundTheVillage.CScenter.model.service.NoticeService;
import com.kh.RoundTheVillage.CScenter.model.vo.Attachment;
import com.kh.RoundTheVillage.CScenter.model.vo.Notice;
import com.kh.RoundTheVillage.CScenter.model.vo.PageInfo2;
import com.kh.RoundTheVillage.member.model.vo.Member;

@Controller // 컨트롤러 + 빈 등록
@SessionAttributes({ "loginMember" })
@RequestMapping("/CScenter/*")
public class NoticeController {

	// Service 객체 의존성 주입
	@Autowired // 등록된 bean 중에서 같은 타입인 bean을 자동적으로 의존성 주입
	private NoticeService service;

	private String swalIcon = null;
	private String swalTitle = null;
	private String swalText = null;

	// 게시글 목록 조회 컨트롤러
	// ---------------------------------------------------------------------------------------------
	@RequestMapping("noticeList")
	public String boardList(@RequestParam(value = "cp", required = false, defaultValue = "1") int cp, Model model) {

		PageInfo2 pInfo = service.getPageInfo(cp);

		List<Notice> nList = service.selectList(pInfo);

		model.addAttribute("nList", nList);
		model.addAttribute("pInfo", pInfo);
		
		return "CScenter/noticeList";
	}

	// 게시글 상세 조회 Controller ------------------------------------------------------------------------------------
	@RequestMapping("{noticeNo}")
	public String noticeView(@PathVariable("noticeNo") int noticeNo, Model model,
			@RequestHeader(value = "referer", required = false) String referer, RedirectAttributes ra) {

		String url = null;

		Notice notice = service.selectNotice(noticeNo);
		
		
		if (notice != null) { // 상세조회성공
			
			System.out.println("notice:" + notice);
			
			List<Attachment> attachmentList = service.selectAttachmentList(noticeNo);
			System.out.println("noticeNo:" + noticeNo);

			if (attachmentList != null && !attachmentList.isEmpty()) { // 조회된 이미지 목록이 있을 경우
				model.addAttribute("attachmentList", attachmentList);
			}

			model.addAttribute("notice", notice);
			url = "CScenter/noticeView";
			
			
		} else { // 이전 요청 주소가 없는 경우
			if (referer == null) {
				url = "redirect:../noticeList/";

			} else {
				url = "redirect:" + referer;
			}
			ra.addFlashAttribute("swalIcon", "error");
			ra.addFlashAttribute("swalTitle", "존재하지 않는 게시글입니다.");
		}
		return "CScenter/noticeView";
	}

	
	// 게시글 등록 화면 전환용 Controller ---------------------------------------------------------------------------------------------------
	@RequestMapping("noticeInsert")
	public String insertView() {
		return "CScenter/noticeInsert";
	}

	
	// 게시글 등록 Controller --------------------------------------------------------------------------------------------------------------
	@RequestMapping("insertAction")
	public String insertAction(@ModelAttribute Notice notice, 
			@RequestParam(value = "images", required = false) List<MultipartFile> images, 
			HttpServletRequest request, RedirectAttributes ra) {
		
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("noticeNo", notice.getNoticeNo());
		map.put("noticeTitle", notice.getNoticeTitle());
		map.put("noticeContent", notice.getNoticeContent());

		
		String savePath = null;
		
		// summernote 추가시 수정 부분 -------------------------------------------------------------------
		savePath = request.getSession().getServletContext().getRealPath("resources/infoImages");
		
		// 게시글 삽입 Service 호출
		int result = service.insertNotice(map, images, savePath);

		String url = null;

		if (result > 0) {
			swalIcon = "success";
			swalTitle = "게시글 등록 성공";
			url = "redirect:" + result;

			request.getSession().setAttribute("returnListURL", "../list");

		} else {
			swalIcon = "error";
			swalTitle = "게시글 삽입 실패";
			url = "redirect:insert";
		}

		ra.addFlashAttribute("swalIcon", swalIcon);
		ra.addFlashAttribute("swalTitle", swalTitle);
		
		return url;
	}

}
