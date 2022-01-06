package com.example.Laborator9.controller;

import com.example.Laborator9.model.dto.ReactionDto;
import com.example.Laborator9.service.ReactionService;
import lombok.RequiredArgsConstructor;
import org.apache.coyote.Response;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequiredArgsConstructor
public class ReactionController {

    private final ReactionService reactionService;

    @PostMapping("/save-reaction")
    public ResponseEntity<?> saveReaction(@RequestBody ReactionDto reactionDto){
        this.reactionService.saveReaction(reactionDto)
                .orElseThrow(() -> new RuntimeException("Something went wrong!"));
        return new ResponseEntity<>("Reaction saved", HttpStatus.OK);
    }

    @PostMapping("/delete-reaction/{id}")
    public ResponseEntity<?> deleteReaction(@RequestBody Long postId, @PathVariable Long id){
        this.reactionService.deleteReaction(id, postId)
                .orElseThrow(() -> new RuntimeException("Something went wrong!"));
        return new ResponseEntity<>("Reaction deleted", HttpStatus.OK);
    }
}
