package com.bit.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.bit.model.NoticeDTO;

@Repository
public class NoticeService {
    private final String NAMESPACE = "com.bit.mapper.NoticeMapper";
    private final SqlSession SESSION;
    
    @Autowired
    public NoticeService(SqlSession sqlSession) {
        this.SESSION = sqlSession;
    }
    
    // 공지사항전체
    public List<NoticeDTO> selectAll(){
        return SESSION.selectList(NAMESPACE + ".selectAll");
    }
    
    // 공지사항등록
    public void insert(NoticeDTO noticeDTO) {
       SESSION.insert(NAMESPACE+".insert", noticeDTO);
    }
    
    // 공지사항상세
    public NoticeDTO selectOne(int id) {
        return SESSION.selectOne(NAMESPACE+".selectOne", id);
    }
    
    // 공지사항삭제
    public void delete(int id) {
        SESSION.delete(NAMESPACE+".delete", id);
    }
    
    // 공지사항수정
    public void update(NoticeDTO noticeDTO) {
        SESSION.update(NAMESPACE+".update", noticeDTO);
    }
}
