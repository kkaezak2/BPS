package com.bit.service;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Repository;

import com.bit.model.EmployeeDTO;

@Repository
public class EmployeeService implements UserDetailsService {
    private final String NAMESPACE = "com.bit.mapper.EmployeeMapper";
    private final SqlSession SESSION;
    private final int PAGE_SIZE = 8;

    @Autowired
    public EmployeeService(SqlSession sqlSession) {
        this.SESSION = sqlSession;
    }

    public EmployeeDTO auth(EmployeeDTO employeeDTO) {
        return SESSION.selectOne(NAMESPACE + ".auth", employeeDTO);
    }

    // 직원등록
    public boolean register(EmployeeDTO employeeDTO) {
        if (SESSION.selectOne(NAMESPACE + ".selectOneByUsername", employeeDTO) == null) {
            SESSION.insert(NAMESPACE + ".register", employeeDTO);
            return true;
        } else {
            return false;
        }
    }

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        EmployeeDTO employeeDTO = new EmployeeDTO();
        employeeDTO.setUsername(username);

        return SESSION.selectOne(NAMESPACE + ".selectOneByUsername", employeeDTO);
    }

    // 직원리스트 페이징처리
    public List<EmployeeDTO> selectAll(int pageNo) {

        HashMap<String, Integer> paramMap = new HashMap<>();
        paramMap.put("size", PAGE_SIZE);
        paramMap.put("startRow", (pageNo - 1) * PAGE_SIZE);

        return SESSION.selectList(NAMESPACE + ".selectAll", paramMap);
    }

    // 직원업데이트
    public void update(EmployeeDTO employeeDTO) {
        SESSION.update(NAMESPACE + ".update", employeeDTO);
    }

    // 직원권한(직책) 수정
    public void updateGrade(EmployeeDTO employeeDTO) {
        SESSION.update(NAMESPACE + ".updateGrade", employeeDTO);
    }

    // 직원삭제
    public void delete(String username) {
        SESSION.delete(NAMESPACE + ".delete", username);
    }

    // 직원상세
    public EmployeeDTO selectOne(String username) {
        return SESSION.selectOne(NAMESPACE + ".selectOne", username);
    }

    // 최대페이지
    public int selectMaxPage() {
        int total = SESSION.selectOne(NAMESPACE + ".count"); // 총 글의 갯수가 나옴
        int maxPage = total / PAGE_SIZE; // 글의 갯수 나누기 각 페이지 사이즈
        if (total % PAGE_SIZE != 0) { // 나머지가 0이 아니면 최대페이지는 1 늘리는것
            maxPage++;
        }
        return maxPage;
    }

    // 직원검색
    public List<EmployeeDTO> search(String search) {
        return SESSION.selectList(NAMESPACE + ".search", search);
    }

    // 직원본인 비밀번호 변경하기
    public void updatePassword(EmployeeDTO employeeDTO) {
        SESSION.update(NAMESPACE + ".updatePassword", employeeDTO);
    }

    // 결재자 선택
    public List<EmployeeDTO> selectApprover() {
        return SESSION.selectList(NAMESPACE + ".selectApprover");
    }
}
