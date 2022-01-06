package com.example.lab9.controller;

import com.example.lab9.model.AuthenticationRequest;
import com.example.lab9.model.AuthenticationResponse;
import com.example.lab9.model.User;
import com.example.lab9.model.dto.UserDto;
import com.example.lab9.service.MyUserDetailsService;
import com.example.lab9.service.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequiredArgsConstructor
@RequestMapping("/users")
public class UserController {

    private final UserService userService;

    @GetMapping
    ResponseEntity<?> getUsers() {
        return ResponseEntity.ok(this.userService.findAll());
    }

    @GetMapping("/{id}")
    UserDto getUserById(@PathVariable Long id){
        return this.userService.findUserById(id);
    }

}
