package com.model2.mvc.service.domain;

import java.sql.Timestamp;

public class Recomment {
	
	private String postId; //post_id
	private String cmtId; //parent_cmt_id
	private String rcmtId; //cmt_id
	private String rcmtWriterId; //writer_id
	private String rcmtContent; //cmt_content
	private Timestamp rcmtDate; //cmt_date
	private String blocked; //blocked
	private String rcmtLikeFlag; 
	private int rcmtLikeCount; 
	private String secret; //secret
	private String rcmtImg; 
	private String deleted; //deleted
	
	public Recomment() {
		
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

	public String getRcmtId() {
		return rcmtId;
	}

	public void setRcmtId(String rcmtId) {
		this.rcmtId = rcmtId;
	}

	public String getRcmtWriterId() {
		return rcmtWriterId;
	}

	public void setRcmtWriterId(String rcmtWriterId) {
		this.rcmtWriterId = rcmtWriterId;
	}

	public String getRcmtContent() {
		return rcmtContent;
	}

	public void setRcmtContent(String rcmtContent) {
		this.rcmtContent = rcmtContent;
	}

	public Timestamp getRcmtDate() {
		return rcmtDate;
	}

	public void setRcmtDate(Timestamp rcmtDate) {
		this.rcmtDate = rcmtDate;
	}

	public String getBlocked() {
		return blocked;
	}

	public void setBlocked(String blocked) {
		this.blocked = blocked;
	}
	
	public String getRcmtLikeFlag() {
		return rcmtLikeFlag;
	}

	public void setRcmtLikeFlag(String rcmtLikeFlag) {
		this.rcmtLikeFlag = rcmtLikeFlag;
	}

	public int getRcmtLikeCount() {
		return rcmtLikeCount;
	}

	public void setRcmtLikeCount(int rcmtLikeCount) {
		this.rcmtLikeCount = rcmtLikeCount;
	}

	public String getSecret() {
		return secret;
	}

	public void setSecret(String secret) {
		this.secret = secret;
	}

	public String getRcmtImg() {
		return rcmtImg;
	}

	public void setRcmtImg(String rcmtImg) {
		this.rcmtImg = rcmtImg;
	}

	public String getDeleted() {
		return deleted;
	}

	public void setDeleted(String deleted) {
		this.deleted = deleted;
	}

	@Override
	public String toString() {
		return "Recomment [postId=" + postId + ", cmtId=" + cmtId + ", rcmtId=" + rcmtId + ", rcmtWriterId="
				+ rcmtWriterId + ", rcmtContent=" + rcmtContent + ", rcmtDate=" + rcmtDate + ", blocked=" + blocked
				+ ", rcmtLikeFlag=" + rcmtLikeFlag + ", rcmtLikeCount=" + rcmtLikeCount + ", secret=" + secret
				+ ", rcmtImg=" + rcmtImg + ", deleted=" + deleted + "]";
	}
	
}
