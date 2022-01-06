package com.example.Laborator9.controller;

import com.example.Laborator9.model.dto.UserDto;
import com.example.Laborator9.service.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequiredArgsConstructor
public class UserController {

    private final UserService userService;

    @PostMapping("/auth")
    ResponseEntity<?> authenticate(@RequestBody UserDto userDto){
        try{
            UserDto responseDto = this.userService.authenticate(userDto.getUsername(), userDto.getPassword())
                    .orElseThrow(() -> new RuntimeException("Login failed"));
            return new ResponseEntity<>(responseDto, HttpStatus.OK);
        }
        catch (RuntimeException exception){
            return new ResponseEntity<>(null, HttpStatus.FORBIDDEN);
        }
    }

    @PostMapping("/register")
    ResponseEntity<?> register(@RequestBody UserDto userDto){
        try{
            UserDto responseDto = this.userService.register(userDto.getUsername(), userDto.getEmail(), userDto.getPassword())
                    .orElseThrow(() -> new RuntimeException("Register failed!"));
            return new ResponseEntity<>(responseDto, HttpStatus.OK);
        }catch (RuntimeException exception){
            return new ResponseEntity<>(null, HttpStatus.FORBIDDEN);
        }
    }

}
