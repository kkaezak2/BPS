package com.bit.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.bit.model.ContractDTO;
import com.bit.model.RefundDTO;

@Repository
public class RefundService {
    private final String NAMESPACE = "com.bit.mapper.RefundMapper";
    private final SqlSession SESSION;

    @Autowired
    public RefundService(SqlSession sqlSession) {
        this.SESSION = sqlSession;
    }

    // 납입상태 업데이트
    public void update(RefundDTO refundDTO) {
        SESSION.update(NAMESPACE + ".update", refundDTO);
    }

    // 반송요청
    public void insert(List<RefundDTO> list) {
        SESSION.insert(NAMESPACE + ".insert", list);
    }

    // 전체 결재건 조회(결재자용)
    public List<RefundDTO> selectAll() {
        return SESSION.selectList(NAMESPACE + ".selectAll");
    }

    // 결재상태 완료로 변경
    public void updateConfirm(RefundDTO refundDTO) {
        SESSION.update(NAMESPACE + ".updateConfirm", refundDTO);
    }

    // 전체 건별 결재건 조회(결재자용)
    public List<RefundDTO> selectOne(int applyNumber) {
        return SESSION.selectList(NAMESPACE + ".selectOne", applyNumber);
    }

    // 최대number
    public int maxApplyNumber() {
        return SESSION.selectOne(NAMESPACE + ".maxApplyNumber");
    }

    // 결재 완료건 조회(결재자용)
    public List<RefundDTO> confirmDone() {
        return SESSION.selectList(NAMESPACE + ".confirmDone");
    }

    // 결재상태 반려로 변경
    public void updateReject(RefundDTO refundDTO) {
        SESSION.update(NAMESPACE + ".updateReject", refundDTO);
    }

    // 결재상태 상신취소로 변경
    public void updateCancel(RefundDTO refundDTO) {
        SESSION.update(NAMESPACE + ".updateCancel", refundDTO);
    }

    // 결재요청건 중복체크 위한 service
    public List<RefundDTO> selectAllForCheck() {
        return SESSION.selectList(NAMESPACE + ".selectAllForCheck");
    }

    // 반송처리 결재요청 중복체크
    public int refundCheck(int allpaymentId) {
        return SESSION.selectOne(NAMESPACE + ".refundCheck", allpaymentId);
    }
}