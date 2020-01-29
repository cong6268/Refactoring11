package com.model2.mvc.service.community.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.community.CommunityDao;
import com.model2.mvc.service.domain.Comment;
import com.model2.mvc.service.domain.Post;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.User;

@Repository("communityDaoImpl")
public class CommunityDaoImpl implements CommunityDao{

	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSession sqlSession;
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	public CommunityDaoImpl() {
		System.out.println(this.getClass());
	}
	
	public void addPost(Post post) throws Exception {
		sqlSession.insert("CommunityMapper.addPost", post);
	}

	public Post getPost(String postId) throws Exception {
		return sqlSession.selectOne("CommunityMapper.getPost", postId);
	}
	
	public List<Post> getPostList(Search search) throws Exception {
		return sqlSession.selectList("CommunityMapper.getPostList", search);
	}
	
	public List<Comment> getCommentList(Search search, String postId) throws Exception {
		
		Map<String, Object> map=new HashMap<String, Object>();
		
		map.put("search", search);
		map.put("postId", postId);
		
		return sqlSession.selectList("CommunityMapper.getCommentList", map);
	}

	public int getPostTotalCount(Search search) throws Exception {
		return sqlSession.selectOne("CommunityMapper.getPostTotalCount", search);
	}
	
	public int getCommentTotalCount(Search search, String postId) throws Exception {
		
		Map<String, Object> map=new HashMap<String, Object>();
		
		map.put("search", search);
		map.put("postId", postId);
		
		return sqlSession.selectOne("CommunityMapper.getCommentTotalCount", map);
	}
	
	public void addComment(Comment comment) throws Exception {
		sqlSession.insert("CommunityMapper.addComment", comment);
	}
	
	public void update_Like(String postId) throws Exception {
		sqlSession.update("CommunityMapper.update_Like", postId);
	}
	
	public void update_Unlike(String postId) throws Exception {
		sqlSession.update("CommunityMapper.update_Unlike", postId);
	}
	
	public int select_Like(String postId) throws Exception {
		return sqlSession.selectOne("CommunityMapper.select_Like", postId);
	}
	
	public Comment getComment(String cmtId) throws Exception {
		return sqlSession.selectOne("CommunityMapper.getComment", cmtId);
	}
	
	public void updateComment(Comment comment) throws Exception {
		sqlSession.update("CommunityMapper.updateComment", comment);
	}
}
