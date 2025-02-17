package org.zerock.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.domain.GoodsAttachVO;
import org.zerock.domain.GoodsVO;
import org.zerock.service.GoodsService;

import lombok.Data;
import lombok.Setter;
import lombok.extern.log4j.Log4j2;

@Controller
@Log4j2
@RequestMapping("/goods/*")
@Data
public class GoodsController {

	@Setter(onMethod_ = { @Autowired })
	private GoodsService service;

	@GetMapping("/admin")
	public void admin() {
	}
	
	@GetMapping({ "/get", "/modify" }) // GetMapping, PostMapping은 URL을 배열로 처리할 수 있으므로, 하나의 메서드로 여러 URL 처리
	@PreAuthorize("permitAll")
	public void get(@RequestParam("gno") String gno, Model model) {

		log.info("/get or /modify");
		model.addAttribute("goods", service.get(gno)); // 모델에 번호 추가
	}

	//방화벽 코드 인터넷에서 퍼옴
		/*
		@Bean
		public HttpFirewall defaultHttpFirewall() {
			return new DefaultHttpFirewall();
		}
		
		public void configure(WebSecurity web) throws Exception {
			web.httpFirewall(defaultHttpFirewall());
		}
		*/
	
	/* 목록 불러오기 */
	@GetMapping("/list")
	@PreAuthorize("permitAll")
	public void list(Model model) {
		log.info("list");
		model.addAttribute("list", service.getList());
	}

	/* 페이징 처리 후 목록 불러오기 */
	//@GetMapping("/list")
	//@PreAuthorize("permitAll")
	//public void list(Criteria cri, Model model) {
	//	log.info("list" + cri);
	//	model.addAttribute("list", service.getList(cri));
	//	model.addAttribute("pageMaker", new PageDTO(cri, 123));
	//}
	
	//첨부파일 정보
	@GetMapping(value = "/getAttachList", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<List<GoodsAttachVO>> getAttachList(String gno) {
		log.info("getAttachList " + gno);
		
		return new ResponseEntity<>(service.getAttachList(gno), HttpStatus.OK);
	}

	@GetMapping("/register")
	@PreAuthorize("hasRole('ROLE_ADMIN')") //관리자 권한으로 바꿀 예정 @PreAuthorize("hasRole('ROLE_MANAGER')")
	public void register() {
	}

	@PostMapping("/register")
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	//@PreAuthorize("isAuthenticated()") //관리자 권한으로 바꿀 예정 @PreAuthorize("hasRole('ROLE_MANAGER')")
	public String register(GoodsVO goods, RedirectAttributes rttr) {

		log.info("======================");
		log.info("register: " + goods);
		
		if (goods.getAttachList() != null) {
			goods.getAttachList().forEach(attach -> log.info(attach));
		}
		
		log.info("======================");
		//service.register(goods);
		//rttr.addFlashAttribute("result", goods.getGno()); // 게시물 번호를 일회성 저장

		return "redirect:/goods/list"; // 목록 화면 이동
	}

	@PostMapping("/modify")
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	public String modify(GoodsVO goods, RedirectAttributes rttr) {
		log.info("modify: " + goods);

		if (service.modify(goods)) { // 수정한 값 T -> 성공
			rttr.addFlashAttribute("result", "success");
		}
		return "redirect:/goods/list";
	}

	@PostMapping("/remove")
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	public String remove(@RequestParam("gno") String gno, RedirectAttributes rttr) {
		log.info("remove......" + gno);

		if (service.remove(gno)) {
			rttr.addFlashAttribute("result", "success");
		}
		return "redirect:/goods/list";
	}
}
