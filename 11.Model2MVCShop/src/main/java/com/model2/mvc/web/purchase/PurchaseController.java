package com.model2.mvc.web.purchase;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.product.ProductService;
import com.model2.mvc.service.purchase.PurchaseService;
import com.model2.mvc.service.user.UserService;

@Controller
@RequestMapping("/purchase/*")
public class PurchaseController {
	
	@Autowired
	@Qualifier("purchaseServiceImpl")
	private PurchaseService purchaseService;
	
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
	
	@Autowired
	@Qualifier("userServiceImpl")
	private UserService userService;

	public PurchaseController() {
		System.out.println(this.getClass());
	}
	
	@Value("#{commonProperties['pageUnit']}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']}")
	int pageSize;
	
	@RequestMapping(value="addPurchase", method=RequestMethod.GET)
	public ModelAndView addPurchase(@RequestParam("prodNo") int prodNo)throws Exception{
		
		System.out.println("/purchase/addPurchase : GET");
		
		Product product=productService.getProduct(prodNo);
		
		ModelAndView modelAndView = new ModelAndView();
		
		modelAndView.addObject("product", product);
		modelAndView.setViewName("/purchase/addPurchaseView.jsp");
		
		return modelAndView;
	}
	
	@RequestMapping(value="addPurchase", method=RequestMethod.POST)
	public ModelAndView addPurchase( @ModelAttribute("purchase") Purchase purchase, HttpSession session, HttpServletRequest request ) throws Exception{
		
		System.out.println("/purchase/addPurchase : POST");
		
		Product product=productService.getProduct(Integer.parseInt(request.getParameter("prodNo")));
		purchase.setPurchaseProd(product);
		
		User user=(User)session.getAttribute("user");
		purchase.setBuyer(user);
		
		product.setStock(product.getStock() - purchase.getQuantity());
		productService.updateProduct(product);
		
		purchaseService.addPurchase(purchase);
		
		ModelAndView modelAndView = new ModelAndView();
		
		modelAndView.setViewName("/purchase/addPurchase.jsp");
		
		return modelAndView;
	}
	
	@RequestMapping(value="getPurchase", method=RequestMethod.GET )
	public ModelAndView getPurchase( @RequestParam("tranNo") int tranNo) throws Exception{
		
		System.out.println("/purchase/getPurchase : GET");
		
		Purchase purchase=purchaseService.getPurchase(tranNo);
		
		ModelAndView modelAndView = new ModelAndView();
		
		modelAndView.addObject("purchase", purchase);
		modelAndView.setViewName("/purchase/getPurchase.jsp");
		
		return modelAndView;
	}
	
	@RequestMapping(value="updatePurchase", method=RequestMethod.GET)
	public ModelAndView updatePurchase( @RequestParam("tranNo") int tranNo) throws Exception{
		
		System.out.println("/purchase/updatePurchase : GET");
		
		Purchase purchase=purchaseService.getPurchase(tranNo);
		
		ModelAndView modelAndView = new ModelAndView();
		
		modelAndView.addObject("purchase", purchase);
		modelAndView.setViewName("/purchase/updatePurchaseView.jsp");
		
		return  modelAndView;
	}
	
	@RequestMapping(value="updatePurchase", method=RequestMethod.POST)
	public ModelAndView updatePurchase(@ModelAttribute("purchase") Purchase purchase, @RequestParam("tranNo") int tranNo ) throws Exception {
		
		System.out.println("/purchase/updatePurchase : POST");
		
		purchase.setTranNo(tranNo);
		
		purchaseService.updatePurchase(purchase);
		
		ModelAndView modelAndView = new ModelAndView();
		
		modelAndView.setViewName("redirect:/purchase/getPurchase?tranNo="+purchase.getTranNo());
		
		return  modelAndView;
	}
	
	@RequestMapping(value="listSale")
	public ModelAndView listSale(@ModelAttribute("search") Search search) throws Exception{
		
		System.out.println("/purchase/listSale : GET / POST");
		
		if(search.getCurrentPage()==0) {
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		Map<String, Object> map=purchaseService.getSaleList(search);
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);
		
		ModelAndView modelAndView=new ModelAndView();
		
		modelAndView.addObject("list", map.get("list"));
		modelAndView.addObject("resultPage", resultPage);
		modelAndView.addObject("search", search);
		
		modelAndView.setViewName("/purchase/listSale.jsp");
		
		return modelAndView;
	}
	
	@RequestMapping(value="listPurchase")
	public ModelAndView listPurchase(@ModelAttribute("search") Search search, HttpSession session) throws Exception{
		
		System.out.println("/purchase/listPurchase : GET / POST");
		
		User user=(User)session.getAttribute("user");
		String buyerId=user.getUserId();
		
		if(search.getCurrentPage()==0) {
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		Map<String, Object> map=purchaseService.getPurchaseList(search, buyerId);
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);
		
		ModelAndView modelAndView=new ModelAndView();
		
		modelAndView.addObject("list", map.get("list"));
		modelAndView.addObject("resultPage", resultPage);
		modelAndView.addObject("search", search);
		modelAndView.addObject("buyerId", buyerId);
		
		modelAndView.setViewName("/purchase/listPurchase.jsp");
		
		return modelAndView;
	}
	
	@RequestMapping(value="updateTranCode", method=RequestMethod.GET)
	public ModelAndView updateTranCode(@RequestParam("tranNo") int tranNo,@RequestParam("tranCode") String tranCode)throws Exception{
		
		System.out.println("/purchase/updateTranCode : GET");
		
		Purchase purchase=purchaseService.getPurchase(tranNo);
		
		purchase.setTranCode(tranCode);	
		purchaseService.updateTranCode(purchase);
		
		ModelAndView modelAndView=new ModelAndView();
		
		modelAndView.addObject("purchase", purchase);
		modelAndView.setViewName("/purchase/listPurchase");
		
		return modelAndView;
	}
	
	@RequestMapping(value="updateTranCodeByProd", method=RequestMethod.GET)
	public ModelAndView updateTranCodeByProd(@RequestParam("prodNo") int prodNo,@RequestParam("tranCode") String tranCode)throws Exception{
		
		System.out.println("/purchase/updateTranCodeByProd : GET");
		
		Purchase purchase=purchaseService.getPurchase2(prodNo);
		
		purchase.setTranCode(tranCode);	
		purchaseService.updateTranCode(purchase);
		
		ModelAndView modelAndView=new ModelAndView();
		
		modelAndView.addObject("purchase", purchase);
		modelAndView.setViewName("redirect:/product/listProduct?menu=manage");
		
		return modelAndView;
	}

}