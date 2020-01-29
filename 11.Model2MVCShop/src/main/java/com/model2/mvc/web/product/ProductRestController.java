package com.model2.mvc.web.product;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.StringTokenizer;
import java.util.UUID;
import java.io.InputStream;
import java.io.PrintWriter;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.DiskFileUpload;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUpload;
import org.apache.commons.io.FileUtils;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Like;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.likeprod.LikeService;
import com.model2.mvc.service.product.ProductService;
import com.model2.mvc.service.product.impl.ProductServiceImpl;

@RestController
@RequestMapping("/product/*")
public class ProductRestController {
	
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService; 
	
	@Autowired
	@Qualifier("likeServiceImpl")
	private LikeService likeService; 
	
	public ProductRestController() {
		System.out.println(this.getClass());
	}
	
	@Value("#{commonProperties['pageUnit']}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']}")
	int pageSize;

	@RequestMapping(value="/json/like", method=RequestMethod.POST )
	public void like(int prodNo, HttpSession session, HttpServletResponse response ) throws Exception {
	  
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();
		 
		Like like = new Like();
		User user=(User)session.getAttribute("user");
	    like.setLikeUserId(user.getUserId());
	    like.setRefId(Integer.toString(prodNo));
	   
	    like=likeService.getLike(like);
	   
		Product product = productService.getProduct(prodNo);
		
		int like_cnt = product.getLikeIt();     //게시판의 좋아요 카운트
		int like_check = 0;
		like_check = Integer.parseInt(like.getLikeCheck());    //좋아요 체크 값
	
		if(likeService.countByLike(like)==0){
		  likeService.addLike(like);
		}
		List<String> msgs = new ArrayList<String>();
		  
		if(like_check == 0) {
		  msgs.add("좋아요!");
		  likeService.like_check(like);
		  like_check++;
		  like_cnt++;
		  productService.update_Like(prodNo);   //좋아요 갯수 증가
		}else{
		  msgs.add("좋아요 취소");
		  likeService.like_check_cancel(like);
		  like_check--;
		  like_cnt--;
		  productService.update_Unlike(prodNo);   //좋아요 갯수 감소
		}
		JSONObject obj = new JSONObject();
		obj.put("prodNo", like.getRefId());
		obj.put("like_check", like_check);
		obj.put("like_cnt", like_cnt);
		obj.put("msg", msgs);
		
		out.println(obj);
	}
	
	@RequestMapping( value="json/likeUpdate", method=RequestMethod.POST )
	public void likeUpdate( int prodNo, HttpServletResponse response ) throws Exception {
	
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();
	
		productService.update_Like(prodNo);
		int like=productService.select_Like(prodNo);
		
		JSONObject obj = new JSONObject();
		
		obj.put("like",like);
		out.println(obj);
	}
	
	@RequestMapping( value="json/addProduct", method=RequestMethod.GET )
	public String addProduct() throws Exception{
		
		System.out.println("/product/addProduct : GET");
		
		return "redirect:/product/addProductView.jsp";
	}
	
	@RequestMapping( value="json/addProduct", method=RequestMethod.POST )
	public Product addProduct( @RequestBody Product product ) throws Exception {
		
		System.out.println("/product/addProduct : POST");
		
		productService.addProduct(product);
	
		return product;
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
	
	@RequestMapping( value="json/getProduct/{prodNo}", method=RequestMethod.GET )
	public Product getProduct( @PathVariable int prodNo ) throws Exception {
		
		System.out.println("/product/getProduct : GET");
		
		Product product=productService.getProduct(prodNo);

		return product;
	}
	
	@RequestMapping( value="json/updateProduct/{prodNo}", method=RequestMethod.GET)
	public Product updateProduct( @PathVariable int prodNo ) throws Exception{
	
		System.out.println("/product/updateProduct : GET");
		
		Product product=productService.getProduct(prodNo);
	
		return product;
	}
	
	@RequestMapping( value="json/updateProduct", method=RequestMethod.POST)
	public Product updateProduct( @RequestBody Product product, HttpServletRequest request) throws Exception{
		
		System.out.println("/product/updateProduct : POST");
		
		productService.updateProduct(product);
		
		return product;
	}
	
	@RequestMapping( value="json/listProduct/{currentPage}", method=RequestMethod.GET )
	public Map<String, Object> listProduct( @PathVariable int currentPage ) throws Exception{
		
		System.out.println("/product/json/listProduct : GET");
		
		Search search = new Search();
		
		if(search.getCurrentPage()==0) {
			search.setCurrentPage(1);
		}
		search.setCurrentPage(currentPage);
		search.setPageSize(pageSize);
		System.out.println(currentPage);
		
		Map<String, Object> map = productService.getProductList(search);
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);
		
		map.put("resultPage", resultPage);
		map.put("search", search);
		
		return map;
	}
	
	@RequestMapping( value="json/listProduct", method=RequestMethod.POST )
	public Map<String, Object> listProduct( @RequestBody Search search ) throws Exception{
		
		System.out.println("/product/json/listProduct : POST");
		
		if(search.getCurrentPage()==0) {
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		Map<String, Object> map=productService.getProductList(search);
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);
		
		map.put("resultPage", resultPage);
		map.put("search", search);
		
		return map;
	}
}
