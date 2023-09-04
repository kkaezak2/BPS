package com.bit.model;

import java.util.Collection;
import java.util.List;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import lombok.Data;

@Data
public class EmployeeDTO implements UserDetails {
    private String username; // (user)직원사번(empId에서 수정함)
    private String password; // (user)직원비밀번호(password1에서 수정함)
    private String name; // 직원이름
    private String teamCode; // 부서코드
    private String teamName; // 부서명
    private String grade; // 직원권한구분(팀원, 팀장, 관리자(인사팀))

    private List<GrantedAuthority> authorities;

    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        return authorities;
    }

    public void setAuthorities(String authority) {
        authorities.add(new SimpleGrantedAuthority(authority));
    }

    @Override
    public boolean isAccountNonExpired() {
        return true;
    }

    @Override
    public boolean isAccountNonLocked() {
        return true;
    }

    @Override
    public boolean isCredentialsNonExpired() {
        return true;
    }

    @Override
    public boolean isEnabled() {
        return true;
    }
}
