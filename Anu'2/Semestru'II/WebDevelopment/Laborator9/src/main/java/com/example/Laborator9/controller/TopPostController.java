package com.example.Laborator9.controller;

import com.example.Laborator9.mapper.PostMapper;
import com.example.Laborator9.model.User;
import com.example.Laborator9.model.dto.PostDto;
import com.example.Laborator9.service.PostService;
import com.example.Laborator9.service.ReactionService;
import com.example.Laborator9.service.UserService;
import com.example.Laborator9.util.MyTriple;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.List;

@Controller
@RequiredArgsConstructor
public class TopPostController {

    private final PostService postService;
    private final UserService userService;
    private final ReactionService reactionService;
    private final PostMapper postMapper;

    @GetMapping("/top")
    public String getTopPosts(Model model) {
        List<MyTriple<PostDto, String>> posts = new ArrayList<>();
        this.postService.getPosts()
                .forEach(e -> {
                    String name = this.userService.findById(e.getUser()).orElseThrow().getUsername();
                    User user = this.userService.findById(e.getUser()).orElseThrow();
                    posts.add(new MyTriple<>(e,
                            this.reactionService.findNumberOfReactions(this.postMapper.dtoToEntity(e, user)), name));
                });
        Collections.sort(posts, Collections.reverseOrder());
        model.addAttribute("top", posts);
        return "top-post";
    }
}
