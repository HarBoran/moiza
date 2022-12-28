package com.code.springdemo.controller;

import java.util.List;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.code.springdemo.dao.CustomerDAO;
import com.code.springdemo.entity.Customer;
import com.code.springdemo.service.CustomerService;

@Controller //MVC의 컨트롤러라는 것을 알려줌
@RequestMapping("/customer") //URL 주소 매핑
public class CustomerController {	
		
	//customerdao를 inject 하세요
	//customerService를 inject 하세요	
	@Autowired
	//private CustomerDAO customerDAO;
	private CustomerService customerService;
		

	@RequestMapping("/list")
	//@RequestMapping(value = "/mainBanner", method = {RequestMethod.POST}
	//전달 받는 파리미터가 없을떄 사용가능
	public String listCustomer(Model theModel) {
		
		//customers라는 이름으로 customerDAO의 return값을 받아오도록 코딩하세요.
		//List<Customer> theCustomers = customerDAO.getCustomers();	
		List<Customer> theCustomers = customerService.getCustomers();	
		theModel.addAttribute("customers",theCustomers);		
		return "list-customers";
	}	
	
	@GetMapping("/showFormForAdd")
	public String showFormForAdd(Model theModel) {
		Customer theCustomer = new Customer();
		theModel.addAttribute("customer", theCustomer);
		return "customer-form";
	}
	
	
	@GetMapping("/saveCustomer")
	public String addCustomer(/* @ModelAttribute("customer") */ Customer theCustomer,Model theModel) {
		//System.out.println("id = "+ theCustomer.getId());
		customerService.saveCustomer(theCustomer);
		return "redirect:/customer/list";
	}
	
	@GetMapping("/showFormForUpdate")
	public String showFormForUpdate(@RequestParam("customerId") int theId, Model theModel) {
		Customer theCustomer = customerService.getCustomer(theId);
		theModel.addAttribute("customer", theCustomer);
		return "customer-form";
	}
	
	@GetMapping("/delete")
	public String showFormForDelete(@RequestParam("customerId") int theId, Model theModel) {
		customerService.deleteCustomer(theId);
		return "redirect:/customer/list";
	}
	

}