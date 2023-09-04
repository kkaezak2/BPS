package com.bit.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.bit.model.EmployeeDTO;
import com.bit.service.EmployeeService;

@Service
public class UserAuthenticationProvider implements AuthenticationProvider {
    private final EmployeeService EMPLOYEE_SERVICE;
    private final BCryptPasswordEncoder PASSWORD_ENCODER;

    @Autowired
    public UserAuthenticationProvider(EmployeeService employeeService, BCryptPasswordEncoder passwordEncoder) {
        this.EMPLOYEE_SERVICE = employeeService;
        this.PASSWORD_ENCODER = passwordEncoder;
    }

    @Override
    public Authentication authenticate(Authentication authentication) throws AuthenticationException {
        String username = authentication.getPrincipal().toString();
        String password = authentication.getCredentials().toString();
        EmployeeDTO employeeDTO = (EmployeeDTO) EMPLOYEE_SERVICE.loadUserByUsername(username);
        if (employeeDTO != null && PASSWORD_ENCODER.matches(password, employeeDTO.getPassword())) {
            System.out.println("★로그인 성공");
            UsernamePasswordAuthenticationToken token = new UsernamePasswordAuthenticationToken(employeeDTO, null,
                    employeeDTO.getAuthorities());
            SecurityContextHolder.getContext().setAuthentication(token);
            return token;
        }
        return null;
    }

    @Override
    public boolean supports(Class<?> authentication) {
        return true;
    }

}
