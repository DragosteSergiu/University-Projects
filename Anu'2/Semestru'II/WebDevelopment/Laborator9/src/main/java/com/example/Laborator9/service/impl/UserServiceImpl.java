package com.example.Laborator9.service.impl;

import com.example.Laborator9.mapper.UserMapper;
import com.example.Laborator9.model.User;
import com.example.Laborator9.model.dto.UserDto;
import com.example.Laborator9.repository.UserRepository;
import com.example.Laborator9.service.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
@RequiredArgsConstructor
public class UserServiceImpl implements UserService {

    private final UserRepository userRepository;

    private final UserMapper userMapper;

    @Override
    public Optional<UserDto> authenticate(String username, String password) {
        User responseUser = this.userRepository.findByUsernameAndPassword(username, password);
        if (responseUser != null){
            responseUser.setIs_logged(Boolean.TRUE);
            this.userRepository.save(responseUser);
            //this.userRepository.updateIsLogged(Boolean.TRUE, responseUser.getUsername());
            UserDto responseDto = this.userMapper.userToDto(responseUser);
            return Optional.of(responseDto);
        }
        return Optional.empty();
    }

    @Override
    public Optional<UserDto> logout(Long id) {
        User response = this.userRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Something went wrong!"));
        response.setIs_logged(Boolean.FALSE);
        this.userRepository.save(response);
        return Optional.of(this.userMapper.userToDto(response));
    }

    @Override
    public Optional<Boolean> getLoggedIn(Long id){
        return Optional.of(this.userRepository.findById(id)
                        .orElseThrow(() -> new RuntimeException("Something went wrong!")).getIs_logged());
    }

    @Override
    public Optional<User> findById(Long id) {
        return Optional.of(this.userRepository.findById(id)
        .orElseThrow(() -> new RuntimeException("Something went wrong!")));
    }

    @Override
    public Optional<UserDto> register(String username, String email, String password) {
        User newUser = new User();
        newUser.setUsername(username);
        newUser.setEmail(email);
        newUser.setPassword(password);
        this.userRepository.save(newUser);
        return Optional.of(this.userMapper.userToDto(newUser));
    }
}
