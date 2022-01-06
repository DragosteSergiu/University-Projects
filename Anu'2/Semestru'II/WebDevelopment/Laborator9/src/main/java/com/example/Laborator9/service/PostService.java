package com.example.Laborator9.service;

import com.example.Laborator9.model.User;
import com.example.Laborator9.model.dto.PostDto;

import java.util.List;
import java.util.Optional;

public interface PostService {

    Optional<PostDto> savePost(PostDto postDto, Long id);

    Optional<Boolean> deletePost(Long postId, Long id);

    List<PostDto> getPosts();

}
