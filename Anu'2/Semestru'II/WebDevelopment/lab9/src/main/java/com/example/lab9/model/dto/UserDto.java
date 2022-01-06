package com.example.lab9.model.dto;

import lombok.Data;

@Data
public class UserDto {
    Long id;
    String username;
    String email;
    String token;
}
