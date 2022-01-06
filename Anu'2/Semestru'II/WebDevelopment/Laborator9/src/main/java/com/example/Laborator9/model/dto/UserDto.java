package com.example.Laborator9.model.dto;

import lombok.Data;

@Data
public class UserDto {

    Long id;
    String username;
    String email;
    String password;
    Boolean is_logged;
}
