package com.example.Laborator9;

import com.example.Laborator9.controller.UserController;
import com.example.Laborator9.mapper.UserMapper;
import com.example.Laborator9.repository.UserRepository;
import com.example.Laborator9.service.ReactionService;
import com.example.Laborator9.service.UserService;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;

@SpringBootApplication
@ComponentScan(basePackageClasses = {UserService.class, UserController.class, UserMapper.class, ReactionService.class})
@EnableJpaRepositories(basePackageClasses = UserRepository.class)
public class Laborator9Application {

	public static void main(String[] args) {
		SpringApplication.run(Laborator9Application.class, args);
	}

}
