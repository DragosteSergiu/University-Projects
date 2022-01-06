package com.example.backend.service.implementation;

import com.example.backend.model.User;
import com.example.backend.model.dto.UserDto;
import com.example.backend.repository.UserRepository;
import com.example.backend.service.UserService;
import com.example.backend.service.mapper.UserMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class UserServiceImplementation implements UserService {

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
