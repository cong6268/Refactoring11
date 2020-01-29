package com.model2.mvc.service.likeprod;

import com.model2.mvc.service.domain.Like;

public interface LikeService {
	
	public void like_check(Like like) throws Exception ;
		
	public void like_check_cancel(Like like) throws Exception ;

	public int countByLike(Like like) throws Exception ;
		
	public Like getLike(Like like) throws Exception ;
	
	public void addLike(Like like) throws Exception ;
}