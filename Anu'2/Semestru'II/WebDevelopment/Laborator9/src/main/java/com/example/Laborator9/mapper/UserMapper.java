package com.example.Laborator9.mapper;

import com.example.Laborator9.model.User;
import com.example.Laborator9.model.dto.UserDto;
import org.mapstruct.Mapper;

@Mapper(componentModel = "spring")
public interface UserMapper {

    User dtoToUser(UserDto userDto);

    UserDto userToDto(User user);
}
