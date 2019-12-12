package com.model2.mvc.web.product;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.StringTokenizer;
import java.io.InputStream;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.DiskFileUpload;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUpload;
import org.apache.commons.io.FileUtils;
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
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.product.ProductService;
import com.model2.mvc.service.product.impl.ProductServiceImpl;

@RestController
@RequestMapping("/product/*")
public class ProductRestController {
	
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService; 

	public ProductRestController() {
		System.out.println(this.getClass());
	}
	
	@Value("#{commonProperties['pageUnit']}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']}")
	int pageSize;
	
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
