package com.example.backend.service.mapper;

import com.example.backend.model.User;
import com.example.backend.model.dto.UserDto;
import org.mapstruct.Mapper;

import java.util.List;

@Mapper(componentModel = "spring")
public interface UserMapper {
    User dtoToEntity(UserDto userDto);

    UserDto entityToDto(User user);

    List<User> dtosToEntities(List<UserDto> usersDto);

    List<UserDto> entitiesToDtos(List<User> users);
}
