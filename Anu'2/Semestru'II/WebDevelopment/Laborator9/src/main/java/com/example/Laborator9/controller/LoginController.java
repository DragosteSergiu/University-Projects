package com.example.Laborator9.controller;

import com.example.Laborator9.mapper.PostMapper;
import com.example.Laborator9.model.Post;
import com.example.Laborator9.model.User;
import com.example.Laborator9.model.dto.PostDto;
import com.example.Laborator9.model.dto.UserDto;
import com.example.Laborator9.service.PostService;
import com.example.Laborator9.service.ReactionService;
import com.example.Laborator9.service.UserService;
import com.example.Laborator9.util.MyPair;
import com.example.Laborator9.util.MyQuadruple;
import com.example.Laborator9.util.MyTriple;
import javassist.compiler.ast.Pair;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Controller
@RequiredArgsConstructor
public class LoginController {

    private final UserService userService;
    private final PostService postService;
    private final PostMapper postMapper;
    private final ReactionService reactionService;

    @GetMapping("/")
    public String Login(){
        return "login";
    }

    @GetMapping("/logged-in")
    public String LoggedIn(@RequestParam String username,
                           @RequestParam Long id,
                           Model model){
        if (this.userService.getLoggedIn(id)
            .orElseThrow(() -> new RuntimeException("Something went wrong!")) == Boolean.TRUE)
        {
            List<MyQuadruple<String, PostDto, Boolean, Integer>> posts = new ArrayList<>();
            this.postService.getPosts()
                    .forEach(e -> {
                        String name = this.userService.findById(e.getUser()).orElseThrow().getUsername();
                        User user = this.userService.findById(id).orElseThrow();
                        posts.add(new MyQuadruple<>(name, e,
                                this.reactionService.findById(user, this.postMapper.dtoToEntity(e, user)),
                                this.reactionService.findNumberOfReactions(this.postMapper.dtoToEntity(e, user))));
                    });
            model.addAttribute("username", username);
            //model.addAttribute("top", Boolean.FALSE);
            model.addAttribute("posts", posts);
            return "home";
        }
        else{
            return "login";
        }
    }

    @PostMapping("/logout/{id}")
    public ResponseEntity<?> logout(@PathVariable Long id){
        this.userService.logout(id)
                .orElseThrow(() -> new RuntimeException("Something went wrong!"));
        return new ResponseEntity<>("Logged out!", HttpStatus.OK);
    }
}
