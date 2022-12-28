package com.code.springdemo.dao;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.code.springdemo.entity.Customer;


@Repository
public class CustomerDAOImpl implements CustomerDAO {

	@Autowired
	//dependency injection : 의존성주입
	//Datasource datasource
	private SessionFactory sessionFactory;
	
	@Override
	//@Transactional 
	//주석처리하면 실행은 하지 않음 
	//트렌잭션이란?	
	//데이터베이스의 상태를 변화시키기 위해 수행하는 작업 단위
	public List<Customer> getCustomers() {
		
		//현제 hibernate세션을 가져옴		
		Session currentSession = sessionFactory.getCurrentSession();		
									//entity 클래스 네임
		String hql = "from Customer";
		//String hql = "from Customer order by lastName";
		//String hql = "from Customer where lastName = 'Writer'";
		Query<Customer> theQuery = currentSession.createQuery(hql, Customer.class);
		List<Customer> customers = theQuery.getResultList();		
		return customers;
	}

	@Override
	public void saveCustomer(Customer theCustomer) {
		Session currentSession = sessionFactory.getCurrentSession();
		currentSession.saveOrUpdate(theCustomer);			
	}

	@Override
	public Customer getCustomer(int theId) {
		Session currentSession = sessionFactory.getCurrentSession();
		Customer theCustomer = currentSession.get(Customer.class, theId);
		return theCustomer;			
	}

	@Override
	public void deleteCustomer(int theId) {
		Session currentSession = sessionFactory.getCurrentSession();
		Customer theCustomer = getCustomer(theId);
		//Customer theCustomer = currentSession.get(Customer.class, theId);
		currentSession.delete(theCustomer);
		currentSession.remove(theCustomer);		
		/*
		복잡한 조선을 줄때
		String hql = "DELETE FROM Customer WHERE id = :id";
		Query query = currentSession.createQuery(hql);
		query.setParameter("id", theId);
		query.executeUpdate();
		 */		
	}

}
