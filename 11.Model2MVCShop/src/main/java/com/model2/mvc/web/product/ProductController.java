package com.model2.mvc.web.product;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Like;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.likeprod.LikeService;
import com.model2.mvc.service.product.ProductService;

@Controller
@RequestMapping("/product/*")
public class ProductController {
	
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService; 
	
	@Autowired
	@Qualifier("likeServiceImpl")
	private LikeService likeService; 

	public ProductController() {
		System.out.println(this.getClass());
	}
	
	@Value("#{commonProperties['pageUnit']}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']}")
	int pageSize;
	
	@RequestMapping( value="addProduct", method=RequestMethod.GET )
	public String addProduct() throws Exception{
		
		System.out.println("/product/addProduct : GET");
		
		return "redirect:/product/addProductView.jsp";
	}
	
	@RequestMapping( value="addProduct", method=RequestMethod.POST )
	public String addProduct( MultipartHttpServletRequest request, Model model ) throws Exception {
		
		System.out.println("/product/addProduct : POST");

		String files="";
		
		Product product=new Product();
		product.setProdName(request.getParameter("prodName"));
		product.setManuDate(request.getParameter("manuDate"));
		product.setPrice(Integer.parseInt(request.getParameter("price")));
		product.setProdDetail(request.getParameter("prodDetail"));
		product.setStock(Integer.parseInt(request.getParameter("stock")));
		
        List<MultipartFile> fileList = request.getFiles("fileName");
        String fileName = request.getParameter("fileName");
        
        String path = "C:\\Users\\User\\git\\repository2\\11.Model2MVCShop\\WebContent\\images\\uploadFiles\\";
        
        for (MultipartFile mf : fileList) {
        	String originFileName = mf.getOriginalFilename(); // 원본 파일 명

            System.out.println("originFileName : " + originFileName);

            String safeFile = path + originFileName;
            product.setFileName(originFileName);
            files += originFileName+",";
         
            try {
            	//썸머노트 사진추가로 error
                mf.transferTo(new File(safeFile));
            } catch (IllegalStateException e) {
                e.printStackTrace();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        product.setFileName(files);
	
		productService.addProduct(product);
	
		model.addAttribute("product", product);
		
		Thread.sleep(5000);
		
		return "forward:/product/addProduct.jsp";
	}
	
	@RequestMapping( value="getProduct", method=RequestMethod.GET )
	public String getProduct(@RequestParam("prodNo") int prodNo, HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		System.out.println("/product/getProduct : GET");
		
		Product product=productService.getProduct(prodNo);
		
		Like like = new Like();
		User user=(User)session.getAttribute("user");
	    like.setLikeUserId(user.getUserId());
	    like.setRefId(Integer.toString(prodNo));
		
		if(likeService.countByLike(like) == 0) {
			likeService.addLike(like);
		}
		like=likeService.getLike(like);
		
		model.addAttribute("product", product);
		model.addAttribute("like", like);

		String prodNO=request.getParameter("prodNo");
		Cookie cookie = new Cookie(prodNO, prodNO);
	    cookie.setPath("/");
	    
	    response.addCookie(cookie);
		
		return "forward:/product/getProduct.jsp";
	}
	
	@RequestMapping( value="updateProduct", method=RequestMethod.GET)
	public String updateProduct( @RequestParam("prodNo") int prodNo, Model model) throws Exception{
	
		System.out.println("/product/updateProduct : GET");
		
		Product product=productService.getProduct(prodNo);
		
		model.addAttribute("product", product);
		
		return "forward:/product/updateProductView.jsp";
	}
	
	@RequestMapping( value="updateProduct", method=RequestMethod.POST)
	public String updateProduct( MultipartHttpServletRequest request ) throws Exception{
		
		System.out.println("/product/updateProduct : POST");
		
		String files="";
		
		Product product=new Product();
		product.setProdNo(Integer.parseInt(request.getParameter("prodNo")));
		product.setProdName(request.getParameter("prodName"));
		product.setManuDate(request.getParameter("manuDate"));
		product.setPrice(Integer.parseInt(request.getParameter("price")));
		product.setProdDetail(request.getParameter("prodDetail"));
		product.setStock(Integer.parseInt(request.getParameter("stock")));
		
        List<MultipartFile> fileList = request.getFiles("fileName");
        String fileName = request.getParameter("fileName");
        
        String path = "C:\\Users\\User\\git\\repository2\\11.Model2MVCShop\\WebContent\\images\\uploadFiles\\";
        
        for (MultipartFile mf : fileList) {
        	String originFileName = mf.getOriginalFilename(); // 원본 파일 명

            System.out.println("originFileName : " + originFileName);

            String safeFile = path + originFileName;
            product.setFileName(originFileName);
            files += originFileName+",";
         
            try {
                mf.transferTo(new File(safeFile));
            } catch (IllegalStateException e) {
                e.printStackTrace();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        product.setFileName(files);
	
		productService.updateProduct(product);
	
		Thread.sleep(5000);
		
		return "redirect:/product/getProduct?prodNo="+product.getProdNo();
	}
	
	@RequestMapping( value="listProduct" )
	public String listProduct(@ModelAttribute("search") Search search, Model model, HttpServletRequest request)throws Exception{
		
		System.out.println("/product/listProduct : GET / POST");
		
		if(search.getCurrentPage()==0) {
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		Map<String, Object> map=productService.getProductList(search);
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);
		
		model.addAttribute("list", map.get("list"));
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);
		
		return "forward:/product/listProduct.jsp?menu="+request.getParameter("menu");
	}
}
