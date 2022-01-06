package com.example.Laborator9.mapper;

import com.example.Laborator9.model.Post;
import com.example.Laborator9.model.User;
import com.example.Laborator9.model.dto.PostDto;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;

import java.util.List;

@Mapper(componentModel = "spring", uses = {UserMapper.class})
public interface PostMapper {

    default Post dtoToEntity(PostDto postDto, User user)
    {
        Post post = new Post();
        post.setId(postDto.getId());
        post.setDescription(postDto.getDescription());
        post.setUser(user);
        return post;
    }

    @Mapping(target = "user", source = "user.id")
    PostDto entityToDto(Post post);

    List<PostDto> entitiesToDto(List<Post> posts);

}
