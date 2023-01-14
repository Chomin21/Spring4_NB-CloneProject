package com.nb.web.auth.dao;

import com.nb.web.auth.dto.UserInfo;

public interface AuthDAO {
	public UserInfo findUserInfo(String userId);
}
