package com.nb.web.auth.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.nb.web.auth.dao.AuthDAO;
import com.nb.web.auth.dto.UserInfo;

public class UserDetailsServiceImpl implements UserDetailsService {
	
	@Autowired
	private AuthDAO authDAO = null;
	
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		UserInfo userInfo = this.authDAO.findUserInfo(username);

        if(userInfo == null) {
            throw new UsernameNotFoundException(username);
        }
        
        return userInfo;
    }

}
