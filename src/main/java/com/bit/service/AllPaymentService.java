package com.bit.service;

import java.time.LocalDate;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.bit.model.AllPaymentDTO;

@Repository
public class AllPaymentService {
    private final String NAMESPACE = "com.bit.mapper.AllPaymentMapper";
    private final SqlSession SESSION;

    @Autowired
    public AllPaymentService(SqlSession sqlSession) {
        this.SESSION = sqlSession;
    }

    // 보험료 즉시출금시 insert
    public void insert(List<AllPaymentDTO> list) {
        SESSION.insert(NAMESPACE + ".insert", list);
    }

    // 증번별 납입내역 + 납입상태
    public List<AllPaymentDTO> selectAllByContract(@Param("number") int number,
            @Param("paymentStatus") String paymentStatus) {
        return SESSION.selectList(NAMESPACE + ".selectAllByContract", new HashMap<String, Object>() {
            {
                put("number", number);
                put("paymentStatus", paymentStatus);
            }
        });
    }

    // 증번별 납입내역
    public List<AllPaymentDTO> selectAll(int number) {
        return SESSION.selectList(NAMESPACE + ".selectAll", number);
    }

    // 납입상태 반송으로 변경
    public void updateConfirm(AllPaymentDTO allPaymentDTO) {
        SESSION.update(NAMESPACE + ".updateConfirm", allPaymentDTO);
    }

    // 납입회차 업데이트(insert)
    public void updateCount(AllPaymentDTO allPaymentDTO) {
        SESSION.update(NAMESPACE + ".updateCount", allPaymentDTO);
    }

    // 날짜별 처리건수
    public List<AllPaymentDTO> countByDate() {
        return SESSION.selectList(NAMESPACE + ".countByDate");
    }

    // 인별 처리건수
    public List<AllPaymentDTO> countByName() {
        return SESSION.selectList(NAMESPACE + ".countByName");
    }

    // 납입방법별 건수
    public List<AllPaymentDTO> countByMethod() {
        return SESSION.selectList(NAMESPACE + ".countByMethod");
    }

    // 상품별 보험료
    public List<AllPaymentDTO> premiumByProduct() {
        return SESSION.selectList(NAMESPACE + ".premiumByProduct");
    }

    // 월별 보험료 + 조회 추가
    public List<AllPaymentDTO> premiumByMonth(LocalDate startDate, LocalDate endDate) {
        Map<Object, Object> params = new HashMap<>();
        params.put("startDate", startDate);
        params.put("endDate", endDate);

        return SESSION.selectList(NAMESPACE + ".premiumByMonth", params);
    }
}
