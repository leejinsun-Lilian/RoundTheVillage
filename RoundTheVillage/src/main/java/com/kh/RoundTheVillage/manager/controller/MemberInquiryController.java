package com.kh.RoundTheVillage.manager.controller;

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
import com.kh.RoundTheVillage.CScenter.model.vo.Notice;
import com.kh.RoundTheVillage.CScenter.model.vo.PageInfo2;
import com.kh.RoundTheVillage.board.model.vo.Search;
import com.kh.RoundTheVillage.manager.model.service.MemberInquiryService;
import com.kh.RoundTheVillage.member.model.vo.Member;
import com.kh.RoundTheVillage.shop.model.vo.Shop;

@Controller // 컨트롤러 + 빈 등록
@SessionAttributes({ "loginMember" })
@RequestMapping("/manager/*")
public class MemberInquiryController {

	// Service 객체 의존성 주입
	@Autowired // 등록된 bean 중에서 같은 타입인 bean을 자동적으로 의존성 주입
	private MemberInquiryService service;


	// 일반회원 목록 조회 컨트롤러 ---------------------------------------------------------------------------------------------
	@RequestMapping("normalList")
	public String selectNormalList(@RequestParam(value = "cp", required = false, defaultValue = "1") int cp, Model model) {

		PageInfo2 pInfo = service.getPageInfo(cp);

		List<Member> nlList = service.selectNormalList(pInfo);

		model.addAttribute("nlList", nlList);
		model.addAttribute("pInfo", pInfo);

		return "manager/normalList";
	}
	
	
	// 공방회원 목록 조회 컨트롤러
	// ---------------------------------------------------------------------------------------------
	@RequestMapping("craftList")
	public String selectCraftList(@RequestParam(value = "cp", required = false, defaultValue = "1") int cp,
			Model model) {

		PageInfo2 pInfo = service.getPageInfo(cp);

		List<Shop> cList = service.selectCraftList(pInfo);

		model.addAttribute("cList", cList);
		model.addAttribute("pInfo", pInfo);

		return "manager/craftList";
	}

	
	
	
	// 일반 회원 검색 Controller -------------------------------------------------------------------------------------------
	@RequestMapping("search")
	public String searchBoard(@ModelAttribute Search search,
			@RequestParam(value = "cp", required = false, defaultValue = "1") int cp, Model model) {

		PageInfo2 pInfo = service.selectSearchListCount(search, cp);
		List<Member> nlList = service.selectSearchList(pInfo, search);

		model.addAttribute("nlList", nlList);
		model.addAttribute("pInfo", pInfo);

		return "manager/normalList";
	}
	
	
	
	// 공방 회원 검색 Controller -------------------------------------------------------------------------------------------
		@RequestMapping("craftSearch")
		public String searchCraft(@ModelAttribute Search search,
				@RequestParam(value = "cp", required = false, defaultValue = "1") int cp, Model model) {

			PageInfo2 pInfo = service.selectSearchCraftCount(search, cp);
			List<Shop> cList = service.selectSearchCraft(pInfo, search);
			System.out.println(search);
			model.addAttribute("cList", cList);
			model.addAttribute("pInfo", pInfo);

			return "manager/craftList";
		}
		
		// 회원 상태 변경 Controller
		@ResponseBody
		@RequestMapping("updateMemberStatus")
		public int updateMemberStatus(int no, String status) {
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("no", no);
			map.put("status", status);
			
			return service.updateMemberStatus(map);
		}
		
		// 공방 상태 변경 Controller
		@ResponseBody
		@RequestMapping("updateCraftStatus")
		public int updateCraftStatus(int no, String status) {
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("no", no);
			map.put("status", status);
			
			return service.updateCraftStatus(map);
		}
		

		
		
		

}
