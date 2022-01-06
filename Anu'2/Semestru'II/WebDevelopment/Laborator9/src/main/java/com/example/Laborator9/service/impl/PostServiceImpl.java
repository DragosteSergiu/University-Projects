package com.example.Laborator9.service.impl;

import com.example.Laborator9.mapper.PostMapper;
import com.example.Laborator9.model.User;
import com.example.Laborator9.model.dto.PostDto;
import com.example.Laborator9.repository.PostRepository;
import com.example.Laborator9.repository.UserRepository;
import com.example.Laborator9.service.PostService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class PostServiceImpl implements PostService {

    private final PostRepository postRepository;
    private final PostMapper postMapper;

    private final UserRepository userRepository;

    @Override
    public Optional<PostDto> savePost(PostDto postDto, Long id) {
        return Optional.of(this.postMapper.entityToDto(
                this.postRepository.save(this.postMapper.dtoToEntity(postDto,
                        this.userRepository.getById(id)))
        ));
    }

    @Override
    public Optional<Boolean> deletePost(Long postId, Long id) {
        try {
            this.postRepository.delete(this.postMapper.dtoToEntity(
                    this.postMapper.entityToDto(this.postRepository.getById(postId)), this.userRepository.getById(id)));
            return Optional.of(Boolean.TRUE);
        }catch (Exception exception){
            return Optional.of(Boolean.FALSE);
        }
    }

    @Override
    public List<PostDto> getPosts() {
        return this.postMapper.entitiesToDto(this.postRepository.findAll());
    }
}
