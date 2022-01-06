package com.example.Laborator9.mapper;

import com.example.Laborator9.model.Post;
import com.example.Laborator9.model.Reaction;
import com.example.Laborator9.model.User;
import com.example.Laborator9.model.dto.PostDto;
import com.example.Laborator9.model.dto.ReactionDto;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;

@Mapper(componentModel = "spring", uses = {UserMapper.class, PostMapper.class})
public interface ReactionMapper {

    default Reaction dtoToEntity(ReactionDto reactionDto, User user, Post post)
    {
        Reaction reaction = new Reaction();
        reaction.setUser(user);
        reaction.setPost(post);
        return reaction;
    }


}
