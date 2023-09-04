package com.bit.service;

import java.time.LocalDate;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.bit.model.ContractDTO;

@Repository
public class ContractService {
    private final String NAMESPACE = "com.bit.mapper.ContractMapper";
    private final SqlSession SESSION;

    @Autowired
    public ContractService(SqlSession sqlSession) {
        this.SESSION = sqlSession;
    }

    // 고객별 보유계약
    public List<ContractDTO> selectAllByCustomer(String ssn) {
        return SESSION.selectList(NAMESPACE + ".selectAllByCustomer", ssn);
    }

    // 고객별 보유계약
    public List<ContractDTO> selectOne(int number) {
        return SESSION.selectList(NAMESPACE + ".selectOne", number);
    }

    // 계약 종납월 등 업데이트
    public void update(ContractDTO contractDTO) {
        SESSION.update(NAMESPACE + ".update", contractDTO);
    }

    // 자동이체 납입방법 변경(AutoPayment)하면 Contract 납입방법에 반영_지헌
    public void updatePaymentMethod(ContractDTO contractDTO) {
        SESSION.update(NAMESPACE + ".updatePaymentMethod", contractDTO);
    }

    // 자동이체 내역 최신 1건만 조회(증서번호)
    public List<ContractDTO> selectOneCombined(int number) {
        return SESSION.selectList(NAMESPACE + ".selectOneCombined", number);
    }

    // 자동이체 내역 최신 1건만 조회(주민번호)
    public List<ContractDTO> selectSsnOneCombined(String ssn) {
        return SESSION.selectList(NAMESPACE + ".selectSsnOneCombined", ssn);
    }

    // contract 및 autopayment combined(자동이체 내역 조회)
    public List<ContractDTO> selectcombined(int number, LocalDate startDate, LocalDate endDate) {
        Map<String, Object> params = new HashMap<>();
        params.put("number", number);
        params.put("startDate", startDate);
        params.put("endDate", endDate);

        return SESSION.selectList(NAMESPACE + ".selectcombined", params);
    }

    // 자동이체 내역조회(주민번호 기준)
    public List<ContractDTO> selectssncombined(String ssn, LocalDate startDate, LocalDate endDate) {
        Map<String, Object> params = new HashMap<>();
        params.put("ssn", ssn);
        params.put("startDate", startDate);
        params.put("endDate", endDate);

        return SESSION.selectList(NAMESPACE + ".selectssncombined", params);
    }
}