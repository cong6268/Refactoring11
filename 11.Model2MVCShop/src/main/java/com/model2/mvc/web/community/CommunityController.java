package com.model2.mvc.web.community;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.community.CommunityService;
import com.model2.mvc.service.domain.Like;
import com.model2.mvc.service.domain.Post;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.likeprod.LikeService;

@Controller
@RequestMapping("/community/*")
public class CommunityController {

	@Autowired
	@Qualifier("communityServiceImpl")
	private CommunityService communityService;
	
	@Autowired
	@Qualifier("likeServiceImpl")
	private LikeService likeService;
	
	public CommunityController() {
		System.out.println(this.getClass());
	}
	
	@Value("#{commonProperties['pageUnit']}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']}")
	int pageSize;

	@RequestMapping( value="addPost", method=RequestMethod.POST )
	public String addPost( @ModelAttribute Post post, Model model, HttpSession session ) throws Exception {
		
		System.out.println("/community/addPost : POST");

		User user = (User)session.getAttribute("user");
		post.setPostWriterId(user);
		
		communityService.addPost(post);
		
		model.addAttribute("post", post);
		
		return "forward:/community/getPost.jsp";
	}
	
	@RequestMapping( value="getPost", method=RequestMethod.GET )
	public String getUser( @RequestParam("postId") String postId , Model model, HttpSession session ) throws Exception {
		
		System.out.println("/community/getPost : GET");
		
		Like like = new Like();
		User user=(User)session.getAttribute("user");
	    like.setLikeUserId(user.getUserId());
	    like.setRefId(postId);
		
		if(likeService.countByLike(like) == 0) {
			likeService.addLike(like);
		}
		like=likeService.getLike(like);
		//Business Logic
		Post post = communityService.getPost(postId);
		// Model 과 View 연결
		model.addAttribute("post", post);
		model.addAttribute("like", like);
		
		return "forward:/community/getPost.jsp";
	}
	
	@RequestMapping( value="getPostList" )
	public String getPostList( @ModelAttribute("search") Search search , Model model , HttpServletRequest request) throws Exception{
		
		System.out.println("/community/getPostList : GET / POST");
		
		if(search.getCurrentPage() ==0 ){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		// Business logic 수행
		Map<String , Object> map=communityService.getPostList(search);
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);
		
		// Model 과 View 연결
		model.addAttribute("list", map.get("list"));
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);
		
		return "forward:/community/getPostList.jsp";
	}
	
}
