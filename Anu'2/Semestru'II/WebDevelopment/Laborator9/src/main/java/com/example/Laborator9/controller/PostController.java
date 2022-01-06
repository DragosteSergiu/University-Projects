package com.example.Laborator9.controller;

import com.example.Laborator9.mapper.PostMapper;
import com.example.Laborator9.model.Post;
import com.example.Laborator9.model.User;
import com.example.Laborator9.model.dto.PostDto;
import com.example.Laborator9.service.PostService;
import com.example.Laborator9.service.ReactionService;
import com.example.Laborator9.service.UserService;
import com.example.Laborator9.util.MyTriple;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;

@RestController
@RequiredArgsConstructor
@RequestMapping("/posts")
public class PostController {

    private final PostService postService;
    private final UserService userService;
    private final ReactionService reactionService;
    private final PostMapper postMapper;

    @PostMapping("/save/{id}")
    public PostDto savePost(@RequestBody PostDto postDto, @PathVariable Long id){
        return this.postService.savePost(postDto, id)
                .orElseThrow(() -> new RuntimeException("Something went wrong!"));
    }

    @PostMapping("/delete/{id}")
    public ResponseEntity<?> deletePost(@RequestBody Long postId, @PathVariable Long id){
        this.postService.deletePost(postId, id)
                .orElseThrow(() -> new RuntimeException("Something went wrong!"));
        return new ResponseEntity<>("Delete succeeded", HttpStatus.OK);
    }

    @GetMapping
    public List<PostDto> getPosts(){
        return this.postService.getPosts();
    }


}
