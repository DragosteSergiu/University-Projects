package com.example.lab9.service;

import com.example.lab9.model.User;
import com.example.lab9.model.dto.UserDto;

import java.util.List;
import java.util.Optional;

public interface UserService {
    List<UserDto> findAll();

    UserDto findUserById(Long id);

    Optional<User> findUserByName(String username);
}
