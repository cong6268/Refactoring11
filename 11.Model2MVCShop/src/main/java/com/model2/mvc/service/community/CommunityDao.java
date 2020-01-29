package com.model2.mvc.service.community;

import java.util.List;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Comment;
import com.model2.mvc.service.domain.Post;
import com.model2.mvc.service.domain.User;

public interface CommunityDao {
	
	public void addPost(Post post) throws Exception ;
	
	public Post getPost(String postId) throws Exception ;

	public List<Post> getPostList(Search search) throws Exception ;
	
	public List<Comment> getCommentList(Search search, String postId) throws Exception ;
	
	public int getPostTotalCount(Search search) throws Exception ;
	
	public int getCommentTotalCount(Search search, String postId) throws Exception ;

	public void addComment(Comment comment) throws Exception ;
	
	public void update_Like(String postId) throws Exception;
	
	public void update_Unlike(String postId) throws Exception;
	
	public int select_Like(String postId) throws Exception;
	
	public Comment getComment(String cmtId) throws Exception;
	
	public void updateComment(Comment comment) throws Exception;
}
