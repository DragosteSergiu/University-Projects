package com.example.Laborator9.service.impl;

import com.example.Laborator9.mapper.ReactionMapper;
import com.example.Laborator9.model.Post;
import com.example.Laborator9.model.Reaction;
import com.example.Laborator9.model.User;
import com.example.Laborator9.model.dto.ReactionDto;
import com.example.Laborator9.repository.PostRepository;
import com.example.Laborator9.repository.ReactionRepository;
import com.example.Laborator9.repository.UserRepository;
import com.example.Laborator9.service.ReactionService;
import com.example.Laborator9.util.MyPair;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class ReactionServiceImpl implements ReactionService {

    private final ReactionRepository reactionRepository;
    private final UserRepository userRepository;
    private final PostRepository postRepository;
    private final ReactionMapper reactionMapper;

    @Override
    public Optional<Boolean> saveReaction(ReactionDto reactionDto) {
        try{
            this.reactionRepository.save(this.reactionMapper.dtoToEntity(reactionDto,
                    this.userRepository.getById(reactionDto.getUser_id()),
                    this.postRepository.getById(reactionDto.getPost_id())));
            return Optional.of(Boolean.TRUE);
        }catch (Exception exception){
            return Optional.of(Boolean.FALSE);
        }
    }

    @Override
    public Optional<Boolean> deleteReaction(Long userId, Long postId) {
        try{

            this.reactionRepository.delete(this.reactionRepository.findFirstByUserAndPost(
                    this.userRepository.getById(userId), this.postRepository.getById(postId)
            ));
            return Optional.of(Boolean.TRUE);
        }catch (Exception exception){
            return Optional.of(Boolean.FALSE);
        }
    }

    @Override
    public Boolean findById(User user, Post post) {
        Reaction reaction = this.reactionRepository.findFirstByUserAndPost(user, post);
        if (reaction != null)
            return Boolean.TRUE;
        else
            return Boolean.FALSE;
    }

    @Override
    public Integer findNumberOfReactions(Post post) {
        return this.reactionRepository.findByPost(post).size();
    }

}
