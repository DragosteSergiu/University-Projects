package com.example.ExamenWeb.controller;

import com.example.ExamenWeb.model.Book;
import com.example.ExamenWeb.model.PublishingHouse;
import com.example.ExamenWeb.repository.BookRepository;
import com.example.ExamenWeb.repository.PublishingHouseRepository;
import com.example.ExamenWeb.util.TransferObject;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;


import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.stream.Collectors;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api")
public class MainController {
    private final PublishingHouseRepository publishingHouseRepository;
    private final BookRepository bookRepository;


    @PostMapping("/delete/{id}")
    public ResponseEntity<?> deletePublishingHouse(@PathVariable Long id){
        PublishingHouse publishingHouse = this.publishingHouseRepository.findFirstById(id);
        this.publishingHouseRepository.delete(publishingHouse);
        return new ResponseEntity<>("Deleted", HttpStatus.OK);
    }

    @PostMapping("/find")
    public List<Book> findBooks(@RequestBody TransferObject transferObject){
        String topic1 = transferObject.getTopic1();
        String topic2 = transferObject.getTopic2();
        String topic3 = transferObject.getTopic3();

        List<Book> books = this.bookRepository.findAll();
        //List<Book> filteredList = books.forEach(e -> {});
        return books;
    }

    //private final HttpSession httpSession;

    /*
    @PostMapping("/auth")
    ResponseEntity<?> authenticate(@RequestBody String username){
        //String newUser = username.substring(1, username.length() - 1);
        //httpSession.setAttribute("username", newUser);
        return new ResponseEntity<>("Successful", HttpStatus.OK);
    }

    @GetMapping("/journals")
    public List<PublishingHouse> getAllJournals(@RequestParam String username) {
        String sessionUsername = (String) httpSession.getAttribute("username");
        if (sessionUsername.equals(username.toString())) {
            return this.publishingHouseRepository.findAll();
        }
        else{
            return null;
        }
    }

    @GetMapping("/articles/{name}")
    public List<Book> getALLArticles(@PathVariable String name,
                                     @RequestParam String user){

        String sessionUsername = (String) httpSession.getAttribute("username");
        if (sessionUsername.equals(user)) {
            return this.bookRepository.findAll()
                    .stream()
                    .filter(e -> e.getJournal().getName().equals(name))
                    .filter(e -> e.getUsername().equals(user))
                    .collect(Collectors.toList());
        }
        else{
            return null;
        }
    }

    @PostMapping("/articles/{name}")
    public Book addArticle(@PathVariable String name,
                           @RequestBody Book article){

        String sessionUsername = (String) httpSession.getAttribute("username");
        if (sessionUsername.equals(article.getUsername())) {
            var journal = this.publishingHouseRepository.findByName(name);
            if (journal == null) {
                journal = PublishingHouse.builder().name(name).build();
                journal = this.publishingHouseRepository.save(journal);
            }
            article.setJournal(journal);
            return this.bookRepository.save(article);
        }
        else{
            return null;
        }
    }
     */
}
