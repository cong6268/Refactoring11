package com.model2.mvc.service.community;

import java.util.List;
import java.util.Map;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Comment;
import com.model2.mvc.service.domain.Post;

public interface CommunityService {
	
	public void addPost(Post post) throws Exception ;
	
	public Post getPost(String postId) throws Exception ;

	public Map<String,Object> getPostList(Search search) throws Exception;
	
	public Map<String,Object> getCommentList(Search search, String postId) throws Exception ;
	
	public void addComment(Comment comment) throws Exception ;
	
	public void update_Like(String postId) throws Exception;
	
	public void update_Unlike(String postId) throws Exception;
	
	public int select_Like(String postId) throws Exception;

	public Comment getComment(String cmtId) throws Exception;
	
	public void updateComment(Comment comment) throws Exception;
}
