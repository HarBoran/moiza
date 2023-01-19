package com.moiza.controller;

import java.util.Collections;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestParam;

import com.moiza.entity.UsergroupEntity;
import com.moiza.dto.UsergroupUserDto;
import com.moiza.entity.Authorities;
import com.moiza.entity.ImgEntity;
import com.moiza.entity.LocalEntity;
import com.moiza.entity.MgroupEntity;
import com.moiza.entity.PostEntity;
import com.moiza.entity.UserEntity;
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

			// 유저인덱스를 기준으로 그룹장으로 되어있는 모든 정보를 가지고옴(admin, normal)
			List<MgroupEntity> theMyMgroup = moizaService.getSubscribedMgroup(userIndex);
			theModel.addAttribute("theMyMgroup", theMyMgroup);

		} catch (NullPointerException e) {
			System.out.println(e);
		}

		List<MgroupEntity> bestGroup = moizaService.bestGroup();
		theModel.addAttribute("bestGroup", bestGroup);

		List<MgroupEntity> randomGroup = moizaService.randomGroup();
		theModel.addAttribute("randomGroup", randomGroup);
	
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
		moizaService.saveUser(user);
		moizaService.saveAuthority(authorities);
		return "redirect:/";
	}
	
	@GetMapping(value = "/logout")
	public String logout(HttpServletRequest request, HttpServletResponse response) {
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		if (auth != null && auth.isAuthenticated()) {
			new SecurityContextLogoutHandler().logout(request, response, auth);
		}
		return "redirect:/";
	}

	//@GetMapping("/group_main_post/{mgroupIndex}")
	@GetMapping("/group_main_post")
	@PreAuthorize("isAuthenticated()")
	public String group_main_post(Authentication authentication, @RequestParam("mgroupIndex") int groupIndex, Model theModel) {
		MgroupEntity theGroup = moizaService.getConnectedGroupInfo(groupIndex);
		theModel.addAttribute("mgroup", theGroup);
			
		List<PostEntity> thePosts = moizaService.getConnectedGroupPosts(groupIndex);
		theModel.addAttribute("post", thePosts);
		try {
			//모임 회원등급을 기준으로
			String userId = authentication.getName();
			int userIndex = moizaService.UseridChangeUserindex(userId);
			List<UsergroupEntity> theUsergroups = moizaService.getUserRole(userIndex, groupIndex);
		
			//모임에 가입되어 있지 않다면 guest로
			if(theUsergroups.isEmpty()) {
				theModel.addAttribute("theUsergroupRole", "guest");	
			}else{
				//admin/normal/employee으로 분류함
				String theUsergroupRole = theUsergroups.get(0).getUsergroup_user_role();
				theModel.addAttribute("theUsergroupRole", theUsergroupRole);
			}
		} catch (NullPointerException e) {
			//비회원일떄는 로그인,회원가입 유도
			System.out.println(e);
			return "redirect:/showMyLoginPage";
		}
		
		return "group_main_post";
	}

	@GetMapping("/writing_post")
	@PreAuthorize("isAuthenticated()")
	public String writing_post(@RequestParam("mgroupIndex") int mgroupIndex, Authentication authentication, Model theModel) {
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
	
	@GetMapping("/ViewGroupMemberSetting")
	@PreAuthorize("isAuthenticated()")
	public String ViewGroupMembers(@RequestParam("mgroupIndex") int mgroupIndex, Authentication authentication, Model theModel) {
		String userId = authentication.getName();
		int userIndex = moizaService.UseridChangeUserindex(userId);
		List<UsergroupEntity> theUsergroups = moizaService.getUserRole(userIndex, mgroupIndex);
		//admin/normal으로 분류함
		String theUsergroupRole = theUsergroups.get(0).getUsergroup_user_role();
		theModel.addAttribute("theUsergroupRole", theUsergroupRole);

		if(theUsergroupRole.equals("admin")) {
			List<UsergroupUserDto> GroupUserInfo = moizaService.GroupUserInfo(mgroupIndex, 0);
			theModel.addAttribute("GroupUserInfo", GroupUserInfo);
		}else if(theUsergroupRole.equals("normal")) {
			List<UsergroupUserDto> GroupMyInfo = moizaService.GroupUserInfo(mgroupIndex, userIndex);
			theModel.addAttribute("GroupMyInfo", GroupMyInfo.get(0));
		}
		return "viewGroupMemberSetting";
	}

	@GetMapping("/beforeGroupCreation")
	public String test(Model theModel, @RequestParam(value = "img_index", defaultValue="0")int img_index) {
		MgroupEntity mgroup = new MgroupEntity();
		mgroup.setMgroup_img(img_index);
		theModel.addAttribute("mgroup", mgroup);
		
		List<ImgEntity> theImg = moizaService.getImg();
		if(img_index > 0) {
			theModel.addAttribute("theImg", theImg.get(img_index-1));
		}
		
		List<LocalEntity> theLocal = moizaService.getLocal();
		theModel.addAttribute("theLocal", theLocal);

	
		return "groupRegistry";
	}

	@GetMapping("/groupCreation")
	public String groupCreation(Authentication authentication, @ModelAttribute("mgroup") MgroupEntity mgroup) {
		
		if (mgroup.getMgroup_title() == null || mgroup.getMgroup_title().length() == 0	
				|| mgroup.getMgroup_img() == 0
				|| mgroup.getMgroup_maincategory().equals("0")
				|| mgroup.getMgroup_middlecategory().equals("0")
				|| mgroup.getMgroup_local() == 0) {
			return "beforeGroupCreation";
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
	

	@GetMapping("/select_img")
	public String select_img(Model theModel, @ModelAttribute("mgroup") MgroupEntity mgroup) {
		List<ImgEntity> theImg = moizaService.getImg();
		theModel.addAttribute("theImg", theImg);
		theModel.addAttribute("mgroup", mgroup);

		return "select_img";
	}
	
	@GetMapping("/joingroup")
	@PreAuthorize("isAuthenticated()")
	public String joingroup(@RequestParam("mgroupIndex") int mgroupIndex, Authentication authentication,
			Model theModel) {
		// 스프링 시큐리티 로그인 아이디를 가져오는 다른 방법
		UserDetails userDetails = (UserDetails) authentication.getPrincipal();
		String userId = userDetails.getUsername();
		// 사용자가 user그룹에서 로그인한 index를 기준으로
		int userIndex = moizaService.UseridChangeUserindex(userId);
		// 유저그룹 테이블의 유저그룹인덱스를 가져와야
		//List<UsergroupEntity> theUserGroup = moizaService.getUserGroup(userIndex, mgroupIndex);
		moizaService.savejoingroup(userIndex, mgroupIndex);
		//UsergroupEntity usergroup = new UsergroupEntity();
		//int getUsergroup_index = theUserGroup.get(0).getUsergroup_index();
		//usergroup.setUsergroup_index(getUsergroup_index);
		//theModel.addAttribute("usergroup", usergroup);
		theModel.addAttribute("mgroupIndex", mgroupIndex);
		return "redirect:/group_main_post";
	}
	
	   @GetMapping("/Mypage")
	   public String mypage(Authentication authentication , Model themodel) {
	      String userId = authentication.getName();
	      themodel.addAttribute("userId",userId);
	      return "mypage";
	   }
	   
	   
	   
	   @GetMapping("/modification")
	   public String modification(@RequestParam("userId") String userId,Model themodel) {
	      
	      List<UserEntity> theUsers = moizaService.theUserInformation(userId);
	      themodel.addAttribute("users", theUsers); 
	      return "modification";
	   }
	   
	   @GetMapping("/userModification")
	   public String userModification(@RequestParam("user_index") int user_index,@RequestParam("user_phone") String user_phone ,
	         @RequestParam("password") String password) {
	      moizaService.updateUserInfo(user_index,user_phone,password);
	      return "main";
	   }
	   
	   @GetMapping("/withdraw")
	      public String withdraw(@RequestParam("user_index") int user_index, Model themodel) {
	         themodel.addAttribute("user_index", user_index);
	         moizaService.DeleteUser(user_index);
	         return "withdraw";
	      }
	   
	   @GetMapping("/search")
	   public String search(@RequestParam("searchGroup") String searchGroup, Model themodel) {
	      List<MgroupEntity> searchGroups = moizaService.searchGroup(searchGroup);
	      themodel.addAttribute("searchGroups", searchGroups);
	      return "searchPage";
	   }
	   
	@GetMapping("/controlmygroup")
	public String controlmygroup(Authentication authentication, Model theModel) {
		try {
			// 스프링 시큐리티 로그인 아이디를 가져와서,
			String userId = authentication.getName();
			// 사용자가 user그룹에서 로그인한 index를 기준으로
			int userIndex = moizaService.UseridChangeUserindex(userId);
			// 유저인덱스를 기준으로 그룹장으로 되어있는 모든 정보를 가지고옴(admin)
			List<MgroupEntity> theleaderMgroup = moizaService.getmygroup(userIndex, "admin");
			theModel.addAttribute("theleaderMgroup", theleaderMgroup);
			
			// 유저인덱스를 기준으로 가입중인 모임의 모든 정보를 가지고옴(normal)
			List<MgroupEntity> thejoinMgroup = moizaService.getmygroup(userIndex, "normal");
			theModel.addAttribute("thejoinMgroup", thejoinMgroup);

			// 유저인덱스를 기준으로 가입대기중인 모임의 모든 정보를 가지고옴(employee)
			List<MgroupEntity> theWaitingMgroup = moizaService.getmygroup(userIndex, "employee");
			theModel.addAttribute("theWaitingMgroup", theWaitingMgroup);


		} catch (NullPointerException e) {
			System.out.println(e);
		}
		return "controlmygroup";
	}
	
	@GetMapping("/ApprovNonMembers")
	@PreAuthorize("isAuthenticated()")
	public String ApprovNonMembers(@RequestParam("usergroup_index")int usergroup_index, Model theModel) {
		UsergroupEntity UsergroupInfo = moizaService.getUsergroupInfo(usergroup_index);
		UsergroupInfo.setUsergroup_user_role("normal");
		moizaService.nonMemberRegistration(UsergroupInfo);
		theModel.addAttribute("mgroupIndex", UsergroupInfo.getUsergroup_group_index());
		return "redirect:/ViewGroupMemberSetting";
	}
	
	@GetMapping("/RejectNonMembers")
	@PreAuthorize("isAuthenticated()")
	public String RejectNonMembers(@RequestParam("usergroup_index")int usergroup_index, Model theModel) {
		//모임 가입 거절하기
		UsergroupEntity UsergroupInfo = moizaService.getUsergroupInfo(usergroup_index);
		//usergroup_user_role을 수정함.
		//UsergroupInfo.setUsergroup_user_role("denial");
		//moizaService.nonMemberRegistration(UsergroupInfo);
		//usergroup_user_role을 삭제함.
		moizaService.exportGroup(UsergroupInfo);
		theModel.addAttribute("mgroupIndex", UsergroupInfo.getUsergroup_group_index());
		return "redirect:/ViewGroupMemberSetting";
	}
	
	@GetMapping("/kickout")
	@PreAuthorize("isAuthenticated()")
	public String kickout(@RequestParam("usergroup_index")int usergroup_index, Model theModel) {
		UsergroupEntity UsergroupInfo = moizaService.getUsergroupInfo(usergroup_index);
		moizaService.exportGroup(UsergroupInfo);
		//내그룹에 가입된 유저의 정보를 정보 가져올수 있음 
		theModel.addAttribute("mgroupIndex", UsergroupInfo.getUsergroup_group_index());
		return "redirect:/ViewGroupMemberSetting";
	}
	
	@GetMapping("/goout")
	@PreAuthorize("isAuthenticated()")
	public String goout(@RequestParam("usergroup_index")int usergroup_index, Model theModel) {
		UsergroupEntity UsergroupInfo = moizaService.getUsergroupInfo(usergroup_index);
		moizaService.exportGroup(UsergroupInfo);
		return "redirect:/";
	}

}