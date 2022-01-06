package com.example.Laborator9.service;

import com.example.Laborator9.model.Post;
import com.example.Laborator9.model.Reaction;
import com.example.Laborator9.model.User;
import com.example.Laborator9.model.dto.ReactionDto;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public interface ReactionService {

    Optional<Boolean> saveReaction(ReactionDto reactionDto);

    Optional<Boolean> deleteReaction(Long userId, Long postId);

    Boolean findById(User user, Post post);

    Integer findNumberOfReactions(Post post);
}
