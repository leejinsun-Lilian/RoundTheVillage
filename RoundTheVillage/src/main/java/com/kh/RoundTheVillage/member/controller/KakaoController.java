package com.kh.RoundTheVillage.member.controller;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.HttpClient;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.http.message.BasicNameValuePair;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.kh.RoundTheVillage.member.model.service.MemberService;
import com.kh.RoundTheVillage.member.model.vo.Member;

@Controller
@SessionAttributes("loginMember")
public class KakaoController {

	@Autowired
	private MemberService service;
	
	@RequestMapping(value="kakaoLogin", produces = "application/json")
	public String kakaoLogin(String code, Model model, HttpSession session) {
		JsonNode jsonToken = KakaoController.getKakaoAccessToken(code);
		JsonNode jsonAccessToken = jsonToken.get("access_token");
		
		JsonNode userInfo = KakaoController.getKakaoUserInfo(jsonAccessToken);
		//Member member
		String accessToken = jsonToken.path("access_token").asText();
		
		String id = userInfo.path("id").asText();
		JsonNode properties = userInfo.path("properties");
		JsonNode kakao_account = userInfo.path("kakao_account");

		String nickName = properties.path("nickname").asText();
		String email = kakao_account.path("email").asText();
		
		// JsonNode트리형태로 토큰받아온다
		// 여러 json객체 중 access_token을 가져온다
		
		//accessToken = jsonToken.get("access_token");
		System.out.println("access_token : " + jsonAccessToken);
		System.out.println("accessToken : " + accessToken);
		System.out.println("userInfo : " + userInfo);
		System.out.println("id : k@" + id);
		System.out.println("nickName : " + nickName);
		System.out.println("email : " + email);
		
		// id가 Member 테이블에 있는지 조회하여 있으면 해당 회원 정보를 조회해서오기
		Member member = service.selectKakaoMember("k@" + id);
		
		//session.setAttribute("accessToken", accessToken);
		session.setAttribute("accessToken", jsonAccessToken);
		session.setAttribute("kakaoId2", id);
		String url = null;
		if(member == null) { // 일치하는 id가 없는 경우 == 최초 카카오 로그인
			url = "redirect:/member/signUp";
			session.setAttribute("kakaoId", "k@" + id);
			session.setAttribute("kakaoNickName", nickName);
			session.setAttribute("kakaoEmail", email);
			
		}else {
			model.addAttribute("loginMember", member);
			url = "redirect:/";
		}
		
		return url;
	}
	
	// 카카오 로그아웃
	@RequestMapping(value="kakaoLogout", produces = "application/json")
	public String kakaoLogout() {
		return "redirect:/";
	}
	
	
	
	
	// 카카오 accessToken 얻어오기
	public static JsonNode getKakaoAccessToken(String code) {

		System.out.println("kakao code: " + code);
		
		final String RequestUrl = "https://kauth.kakao.com/oauth/token"; // Host
		final List<NameValuePair> postParams = new ArrayList<NameValuePair>();

		postParams.add(new BasicNameValuePair("grant_type", "authorization_code"));
		postParams.add(new BasicNameValuePair("client_id", "3c56b25609c3861587b904b7f8db4860")); // REST API KEY
		postParams.add(new BasicNameValuePair("redirect_uri", "http://localhost:8082/RoundTheVillage/kakaoLogin")); // 리다이렉트
																													// URI
		postParams.add(new BasicNameValuePair("code", code)); // 로그인 과정중 얻은 code 값

		final HttpClient client = HttpClientBuilder.create().build();
		final HttpPost post = new HttpPost(RequestUrl);

		JsonNode returnNode = null;

		try {
			post.setEntity(new UrlEncodedFormEntity(postParams));

			final HttpResponse response = client.execute(post);
			final int responseCode = response.getStatusLine().getStatusCode();

			System.out.println("\nSending 'POST' request to URL : " + RequestUrl);
			System.out.println("Post parameters : " + postParams);
			System.out.println("Response Code : " + responseCode);

			// JSON 형태 반환값 처리
			ObjectMapper mapper = new ObjectMapper();

			returnNode = mapper.readTree(response.getEntity().getContent());

			System.out.println("returnNode : " + returnNode);
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		} catch (ClientProtocolException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
		}
		
		return returnNode;
	}

	
	public static JsonNode getKakaoUserInfo(JsonNode accessToken) {
		final String REQUEST_URL = "https://kapi.kakao.com/v2/user/me";
		final HttpClient CLIENT = HttpClientBuilder.create().build();
		final HttpPost POST = new HttpPost(REQUEST_URL);
		
		// add header 
		POST.addHeader("Authorization", "Bearer " + accessToken); 
		JsonNode returnNode = null;
		
		try { 
			final HttpResponse response = CLIENT.execute(POST); 
			// JSON 형태 반환값 처리 
			ObjectMapper mapper = new ObjectMapper(); 
			returnNode = mapper.readTree(response.getEntity().getContent()); 
			
		} catch (ClientProtocolException e) { 
			e.printStackTrace(); 
		} catch (IOException e) { 
			e.printStackTrace(); 
		} finally { 
			// clear resources
		} return returnNode;
	}
	
	
}
