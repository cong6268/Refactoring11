package com.model2.mvc.service.product.test;

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
import com.model2.mvc.service.product.ProductService;

/*
 *	FileName :  UserServiceTest.java
 * ㅇ JUnit4 (Test Framework) 과 Spring Framework 통합 Test( Unit Test)
 * ㅇ Spring 은 JUnit 4를 위한 지원 클래스를 통해 스프링 기반 통합 테스트 코드를 작성 할 수 있다.
 * ㅇ @RunWith : Meta-data 를 통한 wiring(생성,DI) 할 객체 구현체 지정
 * ㅇ @ContextConfiguration : Meta-data location 지정
 * ㅇ @Test : 테스트 실행 소스 지정
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {	"classpath:config/context-common.xml",
									"classpath:config/context-aspect.xml",
									"classpath:config/context-mybatis.xml",
									"classpath:config/context-transaction.xml" })
public class ProductServiceTest {

	//==>@RunWith,@ContextConfiguration 이용 Wiring, Test 할 instance DI
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;

	//@Test
	public void testAddProduct() throws Exception {
		
		Product product=new Product();
		product.setProdName("아이스라떼하나");
		product.setProdDetail("샷하나추가");
		product.setManuDate("2019-11-01");
		product.setPrice(Integer.parseInt("25000"));
		product.setFileName("image");
		
		productService.addProduct(product);
		
		product = productService.getProduct(Integer.parseInt("10043"));

		//==> console 확인
		System.out.println(product);
		
		//==> API 확인
		Assert.assertEquals(Integer.parseInt("10043"), product.getProdNo());
		Assert.assertEquals("아이스라떼하나", product.getProdName());
		Assert.assertEquals("샷하나추가", product.getProdDetail());
		Assert.assertEquals("2019-11-01", product.getManuDate());
		Assert.assertEquals(Integer.parseInt("25000"), product.getPrice());
		Assert.assertEquals("image", product.getFileName());
	}
	
	//@Test
	public void testGetProduct() throws Exception {
		
		Product product=new Product();
		//==> 필요하다면...
//		product.setProdNo(Integer.parseInt("10097"));
//		product.setProdName("아이스라떼하나");
//		product.setProdDetail("샷하나추가");
//		product.setManuDate("2019-11-01");
//		product.setPrice(Integer.parseInt("25000"));
//		product.setFileName("image");
		
		product = productService.getProduct(Integer.parseInt("10060"));

		//==> console 확인
		//System.out.println(user);
		
		//==> API 확인
		Assert.assertEquals(Integer.parseInt("10060"), product.getProdNo());
		Assert.assertEquals("아이스라떼하나", product.getProdName());
		Assert.assertEquals("샷하나추가", product.getProdDetail());
		Assert.assertEquals("2019-11-01", product.getManuDate());
		Assert.assertEquals(Integer.parseInt("25000"), product.getPrice());
		Assert.assertEquals("image", product.getFileName());

		Assert.assertNotNull(productService.getProduct(Integer.parseInt("10002")));
		Assert.assertNotNull(productService.getProduct(Integer.parseInt("10003")));
	}
	
	//@Test
	 public void testUpdateProduct() throws Exception{
		 
		Product product = productService.getProduct(Integer.parseInt("10060"));
		Assert.assertNotNull(product);
		
		Assert.assertEquals("아이스라떼하나", product.getProdName());
		Assert.assertEquals("샷하나추가", product.getProdDetail());
		Assert.assertEquals("2019-11-01", product.getManuDate());
		Assert.assertEquals(Integer.parseInt("25000"), product.getPrice());
		Assert.assertEquals("image", product.getFileName());

		product.setProdName("따뜻한라떼");
		product.setProdDetail("연하게");
		product.setManuDate("2017-02-04");
		product.setPrice(Integer.parseInt("89000"));
		product.setFileName("filename"); 
		
		productService.updateProduct(product);
		
		product = productService.getProduct(Integer.parseInt("10060"));
		Assert.assertNotNull(product);
		
		//==> console 확인
		//System.out.println(user);
			
		//==> API 확인
		Assert.assertEquals("따뜻한라떼", product.getProdName());
		Assert.assertEquals("연하게", product.getProdDetail());
		Assert.assertEquals("2017-02-04", product.getManuDate());
		Assert.assertEquals(Integer.parseInt("89000"), product.getPrice());
		Assert.assertEquals("filename", product.getFileName());
	 }
	
	 //==>  주석을 풀고 실행하면....
	 //@Test
	 public void testGetProductListAll() throws Exception{
		 
	 	Search search = new Search();
	 	search.setCurrentPage(1);
	 	search.setPageSize(3);
	 	Map<String,Object> map = productService.getProductList(search);
	 	
	 	List<Object> list = (List<Object>)map.get("list");
	 	Assert.assertEquals(3, list.size());
	 	
		//==> console 확인
	 	//System.out.println(list);
	 	
	 	Integer totalCount = (Integer)map.get("totalCount");
	 	System.out.println(totalCount);
	 	
	 	System.out.println("=======================================");
	 	
	 	search.setCurrentPage(1);
	 	search.setPageSize(3);
	 	search.setSearchCondition("0");
	 	search.setSearchKeyword("");
	 	map = productService.getProductList(search);
	 	
	 	list = (List<Object>)map.get("list");
	 	Assert.assertEquals(3, list.size());
	 	
	 	//==> console 확인
	 	//System.out.println(list);
	 	
	 	totalCount = (Integer)map.get("totalCount");
	 	System.out.println(totalCount);
	 }
	 
	 //@Test
	 public void testGetProductListByProdNo() throws Exception{
		 
	 	Search search = new Search();
	 	search.setCurrentPage(1);
	 	search.setPageSize(3);
	 	search.setSearchCondition("0");
	 	search.setSearchKeyword("10060");
	 	Map<String,Object> map = productService.getProductList(search);
	 	
	 	List<Object> list = (List<Object>)map.get("list");
	 	Assert.assertEquals(1, list.size());
	 	
		//==> console 확인
	 	//System.out.println(list);
	 	
	 	Integer totalCount = (Integer)map.get("totalCount");
	 	System.out.println(totalCount);
	 	
	 	System.out.println("=======================================");
	 	
	 	search.setSearchCondition("0");
	 	search.setSearchKeyword(""+System.currentTimeMillis());
	 	map = productService.getProductList(search);
	 	
	 	list = (List<Object>)map.get("list");
	 	Assert.assertEquals(0, list.size());
	 	
		//==> console 확인
	 	//System.out.println(list);
	 	
	 	totalCount = (Integer)map.get("totalCount");
	 	System.out.println(totalCount);
	 }
	 
	 //@Test
	 public void testGetProductListByProdName() throws Exception{
		 
	 	Search search = new Search();
	 	search.setCurrentPage(1);
	 	search.setPageSize(3);
	 	search.setSearchCondition("1");
	 	search.setSearchKeyword("자전거");
	 	Map<String,Object> map = productService.getProductList(search);
	 	
	 	List<Object> list = (List<Object>)map.get("list");
	 	Assert.assertEquals(1, list.size());
	 	
		//==> console 확인
	 	System.out.println(list);
	 	
	 	Integer totalCount = (Integer)map.get("totalCount");
	 	System.out.println(totalCount);
	 	
	 	System.out.println("=======================================");
	 	
	 	search.setSearchCondition("1");
	 	search.setSearchKeyword(""+System.currentTimeMillis());
	 	map = productService.getProductList(search);
	 	
	 	list = (List<Object>)map.get("list");
	 	Assert.assertEquals(0, list.size());
	 	
		//==> console 확인
	 	System.out.println(list);
	 	
	 	totalCount = (Integer)map.get("totalCount");
	 	System.out.println(totalCount);
	 }	 
	 
	@Test
	 public void testGetProductListByPrice() throws Exception{
		 
	 	Search search = new Search();
	 	search.setCurrentPage(1);
	 	search.setPageSize(3);
	 	search.setSearchCondition("2");
	 	search.setSearchKeyword("89000");
	 	Map<String,Object> map = productService.getProductList(search);
	 	
	 	List<Object> list = (List<Object>)map.get("list");
	 	Assert.assertEquals(1, list.size());
	 	
		//==> console 확인
	 	System.out.println(list);
	 	
	 	Integer totalCount = (Integer)map.get("totalCount");
	 	System.out.println(totalCount);
	 	
	 	System.out.println("=======================================");
	 	
	 	search.setSearchCondition("2");
	 	search.setSearchKeyword(""+System.currentTimeMillis());
	 	map = productService.getProductList(search);
	 	
	 	list = (List<Object>)map.get("list");
	 	Assert.assertEquals(0, list.size());
	 	
		//==> console 확인
	 	System.out.println(list);
	 	
	 	totalCount = (Integer)map.get("totalCount");
	 	System.out.println(totalCount);
	 }	 
}