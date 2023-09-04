package com.bit.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.bit.model.CustomerDTO;

@Repository
public class CustomerService {
    private final String NAMESPACE = "com.bit.mapper.CustomerMapper";
    private final SqlSession SESSION;

    @Autowired
    public CustomerService(SqlSession sqlSession) {
        this.SESSION = sqlSession;
    }

    // 고객별 보유계약
    public List<CustomerDTO> selectOne(String ssn) {
        return SESSION.selectList(NAMESPACE + ".selectOne", ssn);
    }

}