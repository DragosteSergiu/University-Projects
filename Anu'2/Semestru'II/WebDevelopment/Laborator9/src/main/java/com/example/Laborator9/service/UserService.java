package com.example.Laborator9.service;

import com.example.Laborator9.model.User;
import com.example.Laborator9.model.dto.UserDto;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
public interface UserService {

    Optional<UserDto> authenticate(String username, String password);

    Optional<UserDto> logout(Long id);

    Optional<Boolean> getLoggedIn(Long id);

    Optional<User> findById(Long id);

    Optional<UserDto> register(String username, String email, String password);
}
