package com.example.lab9.model;

import lombok.Data;

@Data
public class AuthenticationResponse {

    private final String jwt;


    public AuthenticationResponse(String jwt) {
        this.jwt = jwt;
    }
}
