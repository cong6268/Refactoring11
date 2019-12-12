package com.model2.mvc.service.purchase.test;

import java.util.List;
import java.util.Map;

import org.junit.Assert;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.purchase.PurchaseService;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {	"classpath:config/context-common.xml",
									"classpath:config/context-aspect.xml",
									"classpath:config/context-mybatis.xml",
									"classpath:config/context-transaction.xml" })
public class PurchaseServiceTest {

	//==>@RunWith,@ContextConfiguration ¿ÃøÎ Wiring, Test «“ instance DI
	@Autowired
	@Qualifier("purchaseServiceImpl")
	private PurchaseService purchaseService;

	//@Test
	public void testAddPurchase() throws Exception {
		
		Purchase purchase=new Purchase();
		Product product=new Product();
		User user=new User();
		
		product.setProdNo(Integer.parseInt("10002"));
		purchase.setPurchaseProd(product);
		user.setUserId("jwa");
		purchase.setBuyer(user);
		purchase.setPaymentOption("2");
		purchase.setReceiverName("¿Ã¡Í");
		purchase.setReceiverPhone("010-1234-5678");
		purchase.setDivyAddr("∞Ê±‚");
		purchase.setDivyRequest("ª°∏Æø≠ø≠");
		purchase.setTranCode("0");
		purchase.setDivyDate("2019-11-16");
		
		purchaseService.addPurchase(purchase);
		
		purchase = purchaseService.getPurchase(Integer.parseInt("10056"));

		//==> console »Æ¿Œ
		System.out.println(purchase);
		
		//==> API »Æ¿Œ
		Assert.assertEquals(Integer.parseInt("10056"), purchase.getTranNo());
		Assert.assertEquals(Integer.parseInt("10002"), purchase.getPurchaseProd().getProdNo());
		Assert.assertEquals("jwa", purchase.getBuyer().getUserId());
		Assert.assertEquals("2", purchase.getPaymentOption().trim());
		Assert.assertEquals("¿Ã¡Í", purchase.getReceiverName());
		Assert.assertEquals("010-1234-5678", purchase.getReceiverPhone());
		Assert.assertEquals("∞Ê±‚", purchase.getDivyAddr());
		Assert.assertEquals("ª°∏Æø≠ø≠", purchase.getDivyRequest());
		Assert.assertEquals("0", purchase.getTranCode().trim());
		Assert.assertEquals("2019-11-16 00:00:00.0", purchase.getDivyDate());
	}
	
	//@Test
	public void testGetPurchase() throws Exception {
		
		Purchase purchase=new Purchase();
		
		purchase=purchaseService.getPurchase(Integer.parseInt("10061"));
		
		Assert.assertEquals(Integer.parseInt("10061"), purchase.getTranNo());
		Assert.assertEquals(Integer.parseInt("10002"), purchase.getPurchaseProd().getProdNo());
		Assert.assertEquals("jwa", purchase.getBuyer().getUserId());
		Assert.assertEquals("2", purchase.getPaymentOption().trim());
		Assert.assertEquals("¿Ã¡Í", purchase.getReceiverName());
		Assert.assertEquals("010-1234-5678", purchase.getReceiverPhone());
		Assert.assertEquals("∞Ê±‚", purchase.getDivyAddr());
		Assert.assertEquals("ª°∏Æø≠ø≠", purchase.getDivyRequest());
		Assert.assertEquals("0", purchase.getTranCode().trim());
		Assert.assertEquals("2019-11-16 00:00:00.0", purchase.getDivyDate());
		
		Assert.assertNotNull(purchaseService.getPurchase(Integer.parseInt("10097")));
	}
	
	//@Test
	public void testGetPurchase2() throws Exception {
		
		Purchase purchase=new Purchase();
		
		purchase=purchaseService.getPurchase2(Integer.parseInt("10002"));
		
		System.out.println(purchase);
		
		Assert.assertEquals(Integer.parseInt("10061"), purchase.getTranNo());
		Assert.assertEquals(Integer.parseInt("10002"), purchase.getPurchaseProd().getProdNo());
		Assert.assertEquals("jwa", purchase.getBuyer().getUserId());
		Assert.assertEquals("2", purchase.getPaymentOption().trim());
		Assert.assertEquals("¿Ã¡Í", purchase.getReceiverName());
		Assert.assertEquals("010-1234-5678", purchase.getReceiverPhone());
		Assert.assertEquals("∞Ê±‚", purchase.getDivyAddr());
		Assert.assertEquals("ª°∏Æø≠ø≠", purchase.getDivyRequest());
		Assert.assertEquals("0", purchase.getTranCode().trim());
		Assert.assertEquals("2019-11-16 00:00:00.0", purchase.getDivyDate());
		
		//Assert.assertNotNull(purchaseService.getPurchase2(Integer.parseInt("10000")));
	}
	
	//@Test
	public void testUpdatePurchase() throws Exception {
		
		Purchase purchase=purchaseService.getPurchase(Integer.parseInt("10061"));
		Assert.assertNotNull(purchase);
		
		Assert.assertEquals(Integer.parseInt("10061"), purchase.getTranNo());
		Assert.assertEquals(Integer.parseInt("10002"), purchase.getPurchaseProd().getProdNo());
		Assert.assertEquals("jwa", purchase.getBuyer().getUserId());
		Assert.assertEquals("2", purchase.getPaymentOption().trim());
		Assert.assertEquals("¿Ã¡Í", purchase.getReceiverName());
		Assert.assertEquals("010-1234-5678", purchase.getReceiverPhone());
		Assert.assertEquals("∞Ê±‚", purchase.getDivyAddr());
		Assert.assertEquals("ª°∏Æø≠ø≠", purchase.getDivyRequest());
		Assert.assertEquals("0", purchase.getTranCode().trim());
		Assert.assertEquals("2019-11-16 00:00:00.0", purchase.getDivyDate());
		
		purchase.setPaymentOption("1");
		purchase.setReceiverName("¬Ø±∏∑ŒπŸ≤ﬁ");
		purchase.setReceiverPhone("011-1212-3434");
		purchase.setDivyAddr("∫Ò∆Æƒ∑«¡");
		purchase.setDivyRequest("∏Æ∆—≈‰∏µ≥°≥Ø±Ó");
		purchase.setDivyDate("2011-06-24");
		
		purchaseService.updatePurchase(purchase);
		
		purchaseService.getPurchase(Integer.parseInt("10061"));
		Assert.assertNotNull(purchase);
		
		Assert.assertEquals(Integer.parseInt("10061"), purchase.getTranNo());
		Assert.assertEquals(Integer.parseInt("10002"), purchase.getPurchaseProd().getProdNo());
		Assert.assertEquals("jwa", purchase.getBuyer().getUserId());
		Assert.assertEquals("1", purchase.getPaymentOption().trim());
		Assert.assertEquals("¬Ø±∏∑ŒπŸ≤ﬁ", purchase.getReceiverName());
		Assert.assertEquals("011-1212-3434", purchase.getReceiverPhone());
		Assert.assertEquals("∫Ò∆Æƒ∑«¡", purchase.getDivyAddr());
		Assert.assertEquals("∏Æ∆—≈‰∏µ≥°≥Ø±Ó", purchase.getDivyRequest());
		Assert.assertEquals("0", purchase.getTranCode().trim());
		Assert.assertEquals("2011-06-24", purchase.getDivyDate());
	}
	
	//@Test
	public void testUpdateTranCode() throws Exception {
		
		Purchase purchase=purchaseService.getPurchase(Integer.parseInt("10061"));
		Assert.assertNotNull(purchase);
		
		Assert.assertEquals(Integer.parseInt("10061"), purchase.getTranNo());
		
		purchaseService.updateTranCode(purchase);
		
		purchaseService.getPurchase(Integer.parseInt("10061"));
		Assert.assertNotNull(purchase);
		
		Assert.assertEquals(Integer.parseInt("10061"), purchase.getTranNo());
		Assert.assertEquals(Integer.parseInt("10002"), purchase.getPurchaseProd().getProdNo());
		Assert.assertEquals("jwa", purchase.getBuyer().getUserId());
		Assert.assertEquals("1", purchase.getPaymentOption().trim());
		Assert.assertEquals("¬Ø±∏∑ŒπŸ≤ﬁ", purchase.getReceiverName());
		Assert.assertEquals("011-1212-3434", purchase.getReceiverPhone());
		Assert.assertEquals("∫Ò∆Æƒ∑«¡", purchase.getDivyAddr());
		Assert.assertEquals("∏Æ∆—≈‰∏µ≥°≥Ø±Ó", purchase.getDivyRequest());
		Assert.assertEquals("0", purchase.getTranCode().trim());
		Assert.assertEquals("2011-06-24 00:00:00.0", purchase.getDivyDate());
		
	}
	
	//@Test
	public void testGetSaleList() throws Exception {
		
		Search search=new Search();
		search.setCurrentPage(1);
		search.setPageSize(3);
		Map<String, Object> map = purchaseService.getSaleList(search);
		
		List<Object> list=(List<Object>)map.get("list");
		Assert.assertEquals(1, list.size());
		
		Integer totalCount = (Integer)map.get("totalCount");
		System.out.println(totalCount);
		System.out.println("===================================");
		
		search.setCurrentPage(1);
		search.setPageSize(3);
		map=purchaseService.getSaleList(search);
		
		list=(List<Object>)map.get("list");
		Assert.assertEquals(1, list.size());
		
		totalCount=(Integer)map.get("totalCount");
		System.out.println(totalCount);
	}
	
	@Test
	public void testGetPurchaseList() throws Exception {
		
		Search search=new Search();
		String buyerId="jwa";
		
		search.setCurrentPage(1);
		search.setPageSize(3);
		Map<String, Object> map = purchaseService.getPurchaseList(search, buyerId);
		
		List<Object> list=(List<Object>)map.get("list");
		Assert.assertEquals(1, list.size());
		
		Integer totalCount = (Integer)map.get("totalCount");
		System.out.println(totalCount);
		System.out.println("===================================");
		
		search.setCurrentPage(1);
		search.setPageSize(3);
		map=purchaseService.getPurchaseList(search, buyerId);
		
		list=(List<Object>)map.get("list");
		Assert.assertEquals(1, list.size());
		
		totalCount=(Integer)map.get("totalCount");
		System.out.println(totalCount);
	}
	
}