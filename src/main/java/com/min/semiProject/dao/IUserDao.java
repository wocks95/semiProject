package com.min.semiProject.dao;

import java.util.Map;

import com.min.semiProject.dto.UserDto;



public interface IUserDao {
  int insertUser(UserDto userDto);
  UserDto selectUserByMap(Map<String, Object> map);
  int updateUserInfo(UserDto userDto) throws Exception;
  int updateUserProfile(UserDto userDto);
  int updateUserPassword(UserDto userDto);
  int deleteUser(int userId);
}
