package com.example.lab9.service.impl;

import com.example.lab9.model.User;
import com.example.lab9.model.dto.UserDto;
import com.example.lab9.repository.UserRepository;
import com.example.lab9.service.UserService;
import com.example.lab9.service.mapper.UserMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class UserServiceImpl implements UserService {

    private final UserRepository userRepository;
    private final UserMapper userMapper;

    @Override
    public List<UserDto> findAll() {
        return this.userMapper.entitiesToDtos(this.userRepository.findAll());
    }

    @Override
    public UserDto findUserById(Long id) {
        return this.userMapper.entityToDto(this.userRepository.findUserById(id));
    }

    @Override
    public Optional<User> findUserByName(String username) {
        return userRepository.findByUsername(username);
    }


}
