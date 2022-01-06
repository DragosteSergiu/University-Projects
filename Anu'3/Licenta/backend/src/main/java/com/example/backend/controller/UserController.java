package com.example.backend.controller;

import com.example.backend.model.AuthenticationRequest;
import com.example.backend.model.AuthenticationResponse;
import com.example.backend.model.User;
import com.example.backend.model.dto.UserDto;
import com.example.backend.service.MyUserDetailsService;
import com.example.backend.service.UserService;
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
