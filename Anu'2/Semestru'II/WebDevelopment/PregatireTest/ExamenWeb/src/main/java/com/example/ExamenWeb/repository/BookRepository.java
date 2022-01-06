package com.example.ExamenWeb.repository;

import org.springframework.context.annotation.Bean;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import com.example.ExamenWeb.model.Book;

import java.util.Collection;
import java.util.List;

@Repository
public interface BookRepository extends JpaRepository<Book, Long> {
    //Collection<Object> findByPublishing_house_id(Long id);
    List<Book> findByPid(Long id);
}

