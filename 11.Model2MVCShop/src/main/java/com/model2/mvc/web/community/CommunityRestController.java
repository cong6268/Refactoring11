package com.model2.mvc.web.community;

import java.io.File;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.community.CommunityService;
import com.model2.mvc.service.domain.Comment;
import com.model2.mvc.service.domain.Like;
import com.model2.mvc.service.domain.Post;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.likeprod.LikeService;

@RestController
@RequestMapping("/community/*")
public class CommunityRestController {

	@Autowired
	@Qualifier("communityServiceImpl")
	private CommunityService communityService;
	
	@Autowired
	@Qualifier("likeServiceImpl")
	private LikeService likeService; 
	
	public CommunityRestController() {
		System.out.println(this.getClass());
	}
	
	@Value("#{commonProperties['pageUnit']}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']}")
	int pageSize;

	@RequestMapping(value="/json/getComment/{cmtId}", method=RequestMethod.GET )
	public Comment getComment(@PathVariable String cmtId) throws Exception {
		
		System.out.println("/community/json/getComment : GET");
		
		Comment comment = communityService.getComment(cmtId);
		
		return comment;
	}
	
	@RequestMapping(value="/json/updateComment", method=RequestMethod.POST )
	public Comment updateComment(Comment comment) throws Exception {
		
		System.out.println("/community/json/updateComment : POST");
		
		communityService.updateComment(comment);
		System.out.println(comment.getCmtContent());
		comment=communityService.getComment(comment.getCmtId());
		System.out.println(comment);
		
		return comment;
		
	}
	
	@RequestMapping(value="/json/like", method=RequestMethod.POST )
	public void like(String postId, HttpSession session, HttpServletResponse response ) throws Exception {
	  
		System.out.println("/community/json/like : POST");
		
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();
		 
		Like like = new Like();
		User user=(User)session.getAttribute("user");
	    like.setLikeUserId(user.getUserId());
	    like.setRefId(postId);
	    
	    if(likeService.countByLike(like)==0){
	    	likeService.addLike(like);
	    }
	    like=likeService.getLike(like);
	   
		Post post = communityService.getPost(postId);
		
		int postLikeCount = post.getPostLikeCount(); //게시판의 좋아요 카운트
		String likeCheck = like.getLikeCheck(); //좋아요 체크 값
		System.out.println("sdfdfsfsf"+likeCheck);
		List<String> msgs = new ArrayList<String>();
		  
		if(likeCheck.equals("F")) {
		  msgs.add("좋아요!");
		  likeService.like_check(like);
		  likeCheck="T";
		  postLikeCount++;
		  communityService.update_Like(postId);   //좋아요 갯수 증가
		}else{
		  msgs.add("좋아요 취소");
		  likeService.like_check_cancel(like);
		  likeCheck="F";
		  postLikeCount--;
		  communityService.update_Unlike(postId);   //좋아요 갯수 감소
		}
		JSONObject obj = new JSONObject();
		obj.put("postId", like.getRefId());
		obj.put("likeCheck", likeCheck);
		obj.put("postLikeCount", postLikeCount);
		obj.put("msg", msgs);
		
		out.println(obj);
	}
	
	@RequestMapping( value="json/likeUpdate", method=RequestMethod.POST )
	public void likeUpdate( String postId, HttpServletResponse response ) throws Exception {
	
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();
	
		communityService.update_Like(postId);
		System.out.println("??????");
		int like=communityService.select_Like(postId);
		System.out.println("?????? : "+like);
		JSONObject obj = new JSONObject();
		System.out.println(like);
		obj.put("like",like);
		out.println(obj);
	}
	
	@RequestMapping( value="json/addFile", method=RequestMethod.POST )
	public void profileUpload(MultipartFile file, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();
		// 업로드할 폴더 경로
		String realFolder = "C:\\Users\\User\\git\\repository2\\11.Model2MVCShop\\WebContent\\images\\uploadFiles\\";
		UUID uuid = UUID.randomUUID();

		// 업로드할 파일 이름
		String org_filename = file.getOriginalFilename();
		String str_filename = uuid.toString() + org_filename;

		System.out.println("원본 파일명 : " + org_filename);
		System.out.println("저장할 파일명 : " + str_filename);

		String filepath = realFolder + str_filename;
		System.out.println("파일경로 : " + filepath);

		File f = new File(filepath);
		if (!f.exists()) {
			f.mkdirs();
		}
		file.transferTo(f);
		Thread.sleep(5000);
		out.println("../images/uploadFiles/" + str_filename);
		out.close();
	}
	
	@RequestMapping( value="json/addComment", method=RequestMethod.POST )
	public void addComment( Comment comment, HttpSession session, HttpServletResponse response ) throws Exception {
		
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter(); 
		
		System.out.println("/community/addComment : POST");
		
		User user = (User)session.getAttribute("user");
		comment.setCmtWriterId(user);
		
		communityService.addComment(comment);
		
		JSONObject obj = new JSONObject();
		obj.put("OK", comment.getCmtId());
		out.println(obj);
	}
	
	@RequestMapping( value="json/getCommentList/{postId}/{currentPage}", method=RequestMethod.GET )
	public Map<String, Object> getCommentList( @PathVariable String postId, @PathVariable int currentPage ) throws Exception{
		
		System.out.println("/community/json/getCommentList : GET");
		
		Search search = new Search();
		
		if(search.getCurrentPage()==0) {
			search.setCurrentPage(1);
		}
		search.setCurrentPage(currentPage);
		search.setPageSize(pageSize);
		System.out.println("currentPage : "+currentPage+" pageSize : "+pageSize);
		
		Map<String, Object> map = communityService.getCommentList(search, postId);
		System.out.println(map.get("list"));
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println("resultPage : "+resultPage);
		map.put("resultPage", resultPage);
		map.put("search", search);
		map.put("postId", postId);
		
		return map;
	}
	
	@RequestMapping( value="json/getCommentList", method=RequestMethod.POST )
	public Map<String, Object> getCommentList( Search search, String postId ) throws Exception{
		
		System.out.println("/community/json/getCommentList : POST");
		
		if(search.getCurrentPage()==0) {
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		Map<String, Object> map=communityService.getCommentList(search, postId);
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);
		
		map.put("resultPage", resultPage);
		map.put("search", search);
		map.put("postId", postId);
		
		return map;
	}
}
