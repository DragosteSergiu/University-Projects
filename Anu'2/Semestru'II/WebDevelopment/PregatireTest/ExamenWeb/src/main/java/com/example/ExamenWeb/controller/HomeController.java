package com.example.ExamenWeb.controller;

import com.example.ExamenWeb.model.PublishingHouse;
import com.example.ExamenWeb.repository.BookRepository;
import com.example.ExamenWeb.repository.PublishingHouseRepository;
import com.example.ExamenWeb.util.MyPair;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.ArrayList;
import java.util.List;

@Controller
public class HomeController {

    @Autowired
    private PublishingHouseRepository publishingHouseRepository;

    @Autowired
    private BookRepository bookRepository;

    @GetMapping("/")
    public String home(Model model){

        List<PublishingHouse> publishingHouses = this.publishingHouseRepository.findAll();
        List<MyPair<PublishingHouse, Integer>> myList = new ArrayList<>();
        publishingHouses.forEach(e -> {myList.add(new MyPair<>(e,
                this.bookRepository.findByPid(e.getId()).size()));});
        model.addAttribute("pair", myList);
        return "index";
    }

    @GetMapping("/login")
    public String login(){
        return "journals";
    }
}
