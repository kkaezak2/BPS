package com.bit.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.bit.model.AutoPaymentDTO;
import com.bit.model.ContractDTO;

@Repository
public class AutoPaymentService {
    private final String NAMESPACE = "com.bit.mapper.AutoPaymentMapper";
    private final SqlSession SESSION;
    private final ContractService CONTRACT_SERVICE;

    @Autowired
    public AutoPaymentService(SqlSession sqlSession, ContractService contractService) {
        this.SESSION = sqlSession;
        this.CONTRACT_SERVICE = contractService;
    }

    // 고객별 보유계약
    public List<AutoPaymentDTO> selectOne(String ssn) {
        return SESSION.selectList(NAMESPACE + ".selectOne", ssn);
    }

    // 주민번호로 자동이체 정보 조회_지헌
    public List<AutoPaymentDTO> selectAll(String ssn) {
        return SESSION.selectList(NAMESPACE + ".selectAll", ssn);
    }

    // 증서번호 자동이체 정보 조회_지헌
    public List<AutoPaymentDTO> selectOne(int number) {
        return SESSION.selectList(NAMESPACE + ".selectOne", number);
    }

    // 자동이체 정보 등록하기_지헌
    @Transactional
    public void insert(List<AutoPaymentDTO> autoPaymentList) {
        for (AutoPaymentDTO autoPaymentDTO : autoPaymentList) {
            SESSION.insert(NAMESPACE + ".insert", autoPaymentDTO);
            // contract 테이블 업데이트
            ContractDTO contractDTO = new ContractDTO();
            contractDTO.setNumber(autoPaymentDTO.getNumber());
            contractDTO.setSsn(autoPaymentDTO.getSsn());
            contractDTO.setPaymentMethod(autoPaymentDTO.getPaymentMethod());
            CONTRACT_SERVICE.updatePaymentMethod(contractDTO);
        }
    }

}