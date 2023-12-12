package com.itwillbs.tradeup;

import java.text.DateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.itwillbs.tradeup.service.MainService;
import com.itwillbs.tradeup.service.ShopService;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	@Autowired
	ShopService shopService;
	
	@Autowired
	MainService mainService;
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model,HttpSession session) {
		logger.info("Welcome home! The client locale is {}.", locale);
		List<Map<String, Object>> productList = null;
		String sId = (String)session.getAttribute("sId");
		System.out.println("세션이없을땐 어케 찍히나? " + sId);
		if(session.getAttribute("sId") != null) {
			productList = mainService.mainProductList(sId);
		}else {
			productList = shopService.selectProductList();
		}
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
//		System.out.println(productList);
		model.addAttribute("serverTime", formattedDate );
		model.addAttribute("productList", productList );
		
		return "home";
	}
	
}
