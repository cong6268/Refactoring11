package com.model2.mvc.web.purchase;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.product.ProductService;
import com.model2.mvc.service.purchase.PurchaseService;
import com.model2.mvc.service.user.UserService;

@RestController
@RequestMapping("/purchase/*")
public class PurchaseRestController {
	
	@Autowired
	@Qualifier("purchaseServiceImpl")
	private PurchaseService purchaseService;
	
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
	
	@Autowired
	@Qualifier("userServiceImpl")
	private UserService userService;

	public PurchaseRestController() {
		System.out.println(this.getClass());
	}
	
	@Value("#{commonProperties['pageUnit']}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']}")
	int pageSize;
	
	@RequestMapping(value="json/addPurchase/{prodNo}", method=RequestMethod.GET)
	public String addPurchase( @PathVariable int prodNo )throws Exception{
		
		System.out.println("/purchase/addPurchase : GET");
		
		productService.getProduct(prodNo);
	
		return "forward:/purchase/addPurchaseView.jsp";
	}
	
	@RequestMapping(value="json/addPurchase", method=RequestMethod.POST)
	public Purchase addPurchase( @RequestBody Purchase purchase ) throws Exception{
		
		System.out.println("/purchase/addPurchase : POST");
		
//		Product product=productService.getProduct(Integer.parseInt(request.getParameter("prodNo")));
//		purchase.setPurchaseProd(product);
//		
//		User user=(User)session.getAttribute("user");
//		purchase.setBuyer(user);
		
		purchaseService.addPurchase(purchase);

		return purchase;
	}
	
	@RequestMapping(value="json/getPurchase/{tranNo}", method=RequestMethod.GET )
	public Purchase getPurchase( @PathVariable int tranNo) throws Exception{
		
		System.out.println("/purchase/getPurchase : GET");
		
		Purchase purchase=purchaseService.getPurchase(tranNo);
		
		return purchase;
	}
	
	@RequestMapping(value="json/updatePurchase/{tranNo}", method=RequestMethod.GET)
	public Purchase updatePurchase( @PathVariable int tranNo) throws Exception{
		
		System.out.println("/purchase/updatePurchase : GET");
		
		Purchase purchase=purchaseService.getPurchase(tranNo);
		
		return  purchase;
	}
	
	@RequestMapping(value="json/updatePurchase", method=RequestMethod.POST)
	public Purchase updatePurchase(@RequestBody Purchase purchase ) throws Exception {
		
		System.out.println("/purchase/updatePurchase : POST");
	
		purchaseService.updatePurchase(purchase);
		
		return purchase;
	}
	
	@RequestMapping(value="json/listSale/{currentPage}", method=RequestMethod.GET)
	public Map listSale(@PathVariable int currentPage) throws Exception{
		
		System.out.println("/purchase/listSale : GET");
		
		Search search=new Search();
		
		if(search.getCurrentPage()==0) {
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		Map<String, Object> map=purchaseService.getSaleList(search);
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);
	
		map.put("resultPage", resultPage);
		map.put("search", search);
		
		return map;
	}
	
	@RequestMapping(value="json/listPurchase/{currentPage}/{buyerId}", method=RequestMethod.GET)
	public Map listPurchase( @PathVariable int currentPage, @PathVariable String buyerId ) throws Exception{
		
		System.out.println("/purchase/listPurchase : GET");
		
		Search search=new Search();
	
		if(search.getCurrentPage()==0) {
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		Map<String, Object> map=purchaseService.getPurchaseList(search, buyerId);
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);
	
		map.put("resultPage", resultPage);
		map.put("search", search);
		map.put("buyerId", buyerId);
	
		return map;
	}
	
	@RequestMapping(value="json/updateTranCode/{tranNo}/{tranCode}", method=RequestMethod.GET)
	public Purchase updateTranCode(@PathVariable int tranNo, @PathVariable String tranCode)throws Exception{
		
		System.out.println("/purchase/updateTranCode : GET");
		
		Purchase purchase=purchaseService.getPurchase(tranNo);
		
		purchase.setTranCode(tranCode);	
		purchaseService.updateTranCode(purchase);
		
		return purchase;
	}
	
	@RequestMapping(value="json/updateTranCodeByProd/{prodNo}/{tranCode}", method=RequestMethod.GET)
	public Purchase updateTranCodeByProd(@PathVariable int prodNo, @PathVariable String tranCode)throws Exception{
		
		System.out.println("/purchase/updateTranCodeByProd : GET");
		
		Purchase purchase=purchaseService.getPurchase2(prodNo);
		
		purchase.setTranCode(tranCode);	
		purchaseService.updateTranCode(purchase);
		
		return purchase;
	}

}