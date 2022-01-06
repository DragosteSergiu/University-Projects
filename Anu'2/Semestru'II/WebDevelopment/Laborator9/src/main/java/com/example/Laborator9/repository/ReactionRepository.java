package com.example.Laborator9.repository;

import com.example.Laborator9.model.Post;
import com.example.Laborator9.model.Reaction;
import com.example.Laborator9.model.User;
import com.example.Laborator9.util.MyPair;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.Set;

@Repository
public interface ReactionRepository extends JpaRepository<Reaction, Long> {

    Reaction findFirstByUserAndPost(User user, Post post);
    void deleteByUserAndPost(User user, Post post);

    Set<Reaction> findByPost(Post post);
}
