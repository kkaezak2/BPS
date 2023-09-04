package com.bit.service;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.bit.model.AttachmentDTO;

@Repository
public class AttachmentService {
    private final String NAMESPACE = "com.bit.mapper.AttachmentMapper";
    private final SqlSession SESSION;

    @Autowired
    public AttachmentService(SqlSession session) {
        this.SESSION = session;
    }

    public List<AttachmentDTO> selectAll(int noticeId) {
        return SESSION.selectList(NAMESPACE + ".selectAll", noticeId);
    }

    public String pathById(int noticeId) {
        return SESSION.selectOne(NAMESPACE + ".pathById", noticeId);
    }

    // attachment 전체
    public List<AttachmentDTO> selectAllAttached() {
        return SESSION.selectList(NAMESPACE + ".selectAllAttached");
    }

    public void insert(List<AttachmentDTO> list) {
        SESSION.insert(NAMESPACE + ".insert", list);
    }

}
