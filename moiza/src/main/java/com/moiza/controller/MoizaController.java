package com.moiza.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestParam;

import com.moiza.entity.Authorities;
import com.moiza.entity.MgroupEntity;
import com.moiza.entity.PostEntity;
import com.moiza.entity.UserEntity;
import com.moiza.entity.UsergroupEntity;
import com.moiza.service.MoizaService;

@Controller // MVC의 컨트롤러라는 것을 알려줌
public class MoizaController {

	@Autowired
	private MoizaService moizaService;

	@GetMapping("/")
	public String showHome(Authentication authentication, Model theModel) {
		try {
			// 스프링 시큐리티 로그인 아이디를 가져와서,
			String userId = authentication.getName();
			// 사용자가 user그룹에서 로그인한 index를 기준으로
			int userIndex = moizaService.UseridChangeUserindex(userId);
			// 유저인덱스를 기준으로 가입되어 있는 모임의 모든 정보를 가지고옴
			List<MgroupEntity> theSbscribedMgroup = moizaService.getSubscribedMgroup(userIndex);
			theModel.addAttribute("theSbscribedMgroup", theSbscribedMgroup);

		} catch (NullPointerException e) {
			System.out.println(e);
		}

		return "main";
	}

	@GetMapping("/showMyLoginPage")
	public String showMyLoginPage() {
		return "custom_login";
	}

	@GetMapping("/join")
	public String joinUser(Model themodel) {
		UserEntity user = new UserEntity();
		themodel.addAttribute("user", user);
		return "join_user";
	}

	@GetMapping("/saveUser")
	public String saveUser(@ModelAttribute("user") UserEntity user,
			@ModelAttribute("authorities") Authorities authorities) {
		user.setPassword("{noop}" + user.getPassword());
		moizaService.saveUser1(user);
		moizaService.saveAuthority(authorities);
		return "redirect:/";
	}

	@GetMapping("/group_main_post")
	@PreAuthorize("isAuthenticated()")
	public String group_main_post(@RequestParam("mgroupIndex") int groupIndex, Model theModel) {
		List<MgroupEntity> theGroup = moizaService.getConnectedGroupInfo(groupIndex);
		theModel.addAttribute("mgroup", theGroup);
		List<PostEntity> thePosts = moizaService.getConnectedGroupPosts(groupIndex);
		theModel.addAttribute("post", thePosts);
		return "group_main_post";
	}

	@GetMapping("/writing_post")
	@PreAuthorize("isAuthenticated()")
	public String writing_post(@RequestParam("mgroupIndex") int mgroupIndex, Authentication authentication,
			Model theModel) {
		// 스프링 시큐리티 로그인 아이디를 가져오는 다른 방법
		UserDetails userDetails = (UserDetails) authentication.getPrincipal();
		String userId = userDetails.getUsername();
		// 사용자가 user그룹에서 로그인한 index를 기준으로
		int userIndex = moizaService.UseridChangeUserindex(userId);
		// 유저그룹 테이블의 유저그룹인덱스를 가져와야
		List<UsergroupEntity> theUserGroup = moizaService.getUserGroup(userIndex, mgroupIndex);

		// 글을 담을 빈객체를 생성,유저그룹인덱스를 담아서 글쓰기로 넘어감
		PostEntity bowOfPost = new PostEntity();
		int getUsergroup_index = theUserGroup.get(0).getUsergroup_index();
		bowOfPost.setPost_usergroup_index(getUsergroup_index);
		theModel.addAttribute("bowOfPost", bowOfPost);
		return "writing_post";
	}

	@GetMapping("/save_written_post")
	@PreAuthorize("isAuthenticated()")
	public String save_Written_Post(@ModelAttribute("bowOfPost") PostEntity bowOfPost, Model theModel) {
		moizaService.saveWrittenPost(bowOfPost);
		// bowOfPost에 있는 getUsergroup_index를 기준으로 mgroupIndex를 가져옴
		int getUsergroup_index = bowOfPost.getPost_usergroup_index();
		int mgroupIndex = moizaService.findMgroupIndexBase(getUsergroup_index);
		theModel.addAttribute("mgroupIndex", mgroupIndex);
		return "redirect:/group_main_post";
	}

	@GetMapping("/test")
	public String test(Model themodel) {
		MgroupEntity mgroup = new MgroupEntity();
		themodel.addAttribute("mgroup", mgroup);
		return "groupRegistry";
	}

	@GetMapping("/groupCreation")
	public String groupCreation(Authentication authentication, @ModelAttribute("mgroup") MgroupEntity mgroup) {
		
		if (mgroup.getMgroup_title() == null || mgroup.getMgroup_title().length() == 0	
				|| mgroup.getMgroup_img() == 0
				|| mgroup.getMgroup_maincategory().equals("0")
				|| mgroup.getMgroup_middlecategory().equals("0")
				|| mgroup.getMgroup_local() == 0) {
			return "test";
		}
		
		moizaService.saveGroup(mgroup);
		
		String userId = authentication.getName();
		int userIndex = moizaService.UseridChangeUserindex(userId);
		
		UsergroupEntity usergroupEntity = new UsergroupEntity();
		usergroupEntity.setUsergroup_user_index(userIndex);
		usergroupEntity.setUsergroup_group_index(mgroup.getMgroup_index());
		usergroupEntity.setUsergroup_user_role("admin");
		moizaService.makeTheLeader(usergroupEntity);
		

		return "redirect:/";
	}

}