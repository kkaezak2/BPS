package com.bit.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.bit.model.ScheduleDTO;

@Repository
public class ScheduleService {
    private final String NAMESPACE = "com.bit.mapper.ScheduleMapper";
    private final SqlSession SESSION;

    @Autowired
    public ScheduleService(SqlSession sqlSession) {
        this.SESSION = sqlSession;
    }

    // 스케쥴추가
    public void addSchedule(ScheduleDTO scheduleDTO) {
        SESSION.insert(NAMESPACE + ".insert", scheduleDTO);
    }

    // 스케쥴출력
    public List<ScheduleDTO> getAllSchedules() {
        return SESSION.selectList(NAMESPACE + ".selectAll");
    }

    // 스케쥴출력(작성자별)
    public List<ScheduleDTO> getAllSchedulesByWriter(String username) {
        return SESSION.selectList(NAMESPACE + ".selectAllByWriterId", username);

    }

    // 스케쥴삭제
    public void delete(int id) {
        SESSION.delete(NAMESPACE + ".delete", id);
    }
}
