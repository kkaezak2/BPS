package com.bit.service;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.bit.model.AccountDTO;
import com.bit.model.AutoPaymentDTO;


@Repository
public class AccountService {
    private final String NAMESPACE = "com.bit.mapper.AccountMapper";
    private final SqlSession SESSION;
    
    @Autowired
    public AccountService(SqlSession sqlSession) {
        this.SESSION = sqlSession;
    }
    // 계좌등록
    public void register(AccountDTO accountDTO) {
        SESSION.insert(NAMESPACE + ".register", accountDTO);
    }
    // 증서번호 자동이체 정보 조회_지헌
    public List<AccountDTO> selectOne(int number) {
        return SESSION.selectList(NAMESPACE + ".selectOne", number);
    }
    //주민번호로 자동이체 정보 조회_지헌
    public List<AccountDTO> selectAll(String ssn) {
        return SESSION.selectList(NAMESPACE + ".selectAll", ssn);
    }
}
