package com.model2.mvc.service.domain;

import java.sql.Timestamp;

public class Comment {
	
	private String postId; //post_id
	private String cmtId; //parent_cmt_id
	private User cmtWriterId; //writer_id
	private String cmtContent; //cmt_content
	private Timestamp cmtDate; //cmt_date
	private String blocked; //blocked
	private String cmtLikeFlag;
	private int cmtLikeCount; 
	private String secret; //secret
	private String cmtImg;  
	private String deleted; //deleted
	
	public Comment() {
		
	}

	public String getPostId() {
		return postId;
	}

	public void setPostId(String postId) {
		this.postId = postId;
	}

	public String getCmtId() {
		return cmtId;
	}

	public void setCmtId(String cmtId) {
		this.cmtId = cmtId;
	}

	public User getCmtWriterId() {
		return cmtWriterId;
	}

	public void setCmtWriterId(User cmtWriterId) {
		this.cmtWriterId = cmtWriterId;
	}

	public String getCmtContent() {
		return cmtContent;
	}

	public void setCmtContent(String cmtContent) {
		this.cmtContent = cmtContent;
	}

	public Timestamp getCmtDate() {
		return cmtDate;
	}

	public void setCmtDate(Timestamp cmtDate) {
		this.cmtDate = cmtDate;
	}

	public String getBlocked() {
		return blocked;
	}

	public void setBlocked(String blocked) {
		this.blocked = blocked;
	}

	public String getCmtLikeFlag() {
		return cmtLikeFlag;
	}

	public void setCmtLikeFlag(String cmtLikeFlag) {
		this.cmtLikeFlag = cmtLikeFlag;
	}

	public int getCmtLikeCount() {
		return cmtLikeCount;
	}

	public void setCmtLikeCount(int cmtLikeCount) {
		this.cmtLikeCount = cmtLikeCount;
	}

	public String getSecret() {
		return secret;
	}

	public void setSecret(String secret) {
		this.secret = secret;
	}

	public String getCmtImg() {
		return cmtImg;
	}

	public void setCmtImg(String cmtImg) {
		this.cmtImg = cmtImg;
	}

	public String getDeleted() {
		return deleted;
	}

	public void setDeleted(String deleted) {
		this.deleted = deleted;
	}

	@Override
	public String toString() {
		return "Comment [postId=" + postId + ", cmtId=" + cmtId + ", cmtWriterId=" + cmtWriterId + ", cmtContent="
				+ cmtContent + ", cmtDate=" + cmtDate + ", blocked=" + blocked + ", cmtLikeFlag=" + cmtLikeFlag
				+ ", cmtLikeCount=" + cmtLikeCount + ", secret=" + secret + ", cmtImg=" + cmtImg + ", deleted="
				+ deleted + "]";
	}

}
