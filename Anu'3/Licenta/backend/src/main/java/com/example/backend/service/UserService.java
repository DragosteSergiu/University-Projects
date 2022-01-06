package com.example.backend.service;

import com.example.backend.model.User;
import com.example.backend.model.dto.UserDto;

import java.util.List;
import java.util.Optional;

public interface UserService {
    List<UserDto> findAll();

    UserDto findUserById(Long id);

    Optional<User> findUserByName(String username);
}
