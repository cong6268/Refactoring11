package com.model2.mvc.service.community.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.community.CommunityDao;
import com.model2.mvc.service.community.CommunityService;
import com.model2.mvc.service.domain.Comment;
import com.model2.mvc.service.domain.Post;
import com.model2.mvc.service.domain.Product;

@Service("communityServiceImpl")
public class CommunityServiceImpl implements CommunityService{
	
	///Field
	@Autowired
	@Qualifier("communityDaoImpl")
	private CommunityDao communityDao;
	public void setCommunityDao(CommunityDao communityDao) {
		this.communityDao = communityDao;
	}
		
	public CommunityServiceImpl() {
		System.out.println(this.getClass());
	}
	
	public void addPost(Post post) throws Exception {
		communityDao.addPost(post);
	}
	
	public Post getPost(String postId) throws Exception {
		return communityDao.getPost(postId);
	}

	public Map<String , Object > getPostList(Search search) throws Exception {
		
		List<Post> list= communityDao.getPostList(search);
		int totalCount = communityDao.getPostTotalCount(search);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", list );
		map.put("totalCount", new Integer(totalCount));
		
		System.out.println(list);
		
		return map;
	}
	
	public Map<String , Object > getCommentList(Search search, String postId) throws Exception {
		
		List<Comment> list= communityDao.getCommentList(search, postId);
		int totalCount = communityDao.getCommentTotalCount(search, postId);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", list );
		map.put("totalCount", new Integer(totalCount));
		
		System.out.println(list);
		
		return map;
	}
	
	public void addComment(Comment comment) throws Exception {
		communityDao.addComment(comment);
	}
	
	public void update_Like(String postId) throws Exception {
		communityDao.update_Like(postId);
	}
	
	public void update_Unlike(String postId) throws Exception {
		communityDao.update_Unlike(postId);
	}
	
	public int select_Like(String postId) throws Exception {
		return communityDao.select_Like(postId);
	}
	
	public Comment getComment(String cmtId) throws Exception {
		return communityDao.getComment(cmtId);
	}
	
	public void updateComment(Comment comment) throws Exception {
		communityDao.updateComment(comment);
	}

}
