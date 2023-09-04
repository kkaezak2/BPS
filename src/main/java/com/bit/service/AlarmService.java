package com.bit.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.bit.model.AlarmDTO;
import com.bit.model.RefundDTO;

@Repository
public class AlarmService {
    private final String NAMESPACE = "com.bit.mapper.AlarmMapper";
    private final SqlSession SESSION;

    @Autowired
    public AlarmService(SqlSession sqlSession) {
        this.SESSION = sqlSession;
    }

    public void insert(AlarmDTO alarmDTO) {
        SESSION.insert(NAMESPACE + ".insert", alarmDTO);
    }

    // 요청자 사번
    public List<AlarmDTO> selectAlarm(String username2) {        
        return SESSION.selectList(NAMESPACE + ".selectAlarm", username2);
    }

    public List<AlarmDTO> selectAll() {
        return SESSION.selectList(NAMESPACE + ".selectAll");
    }
    
    // checked 0 으로 변경
    public void updateChecked(AlarmDTO alarmDTO) {
        SESSION.update(NAMESPACE + ".updateChecked", alarmDTO);
    }
}