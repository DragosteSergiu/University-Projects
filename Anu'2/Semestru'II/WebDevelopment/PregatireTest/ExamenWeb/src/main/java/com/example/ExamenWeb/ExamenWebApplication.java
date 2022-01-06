package com.example.ExamenWeb;

import com.example.ExamenWeb.controller.HomeController;
import com.example.ExamenWeb.controller.MainController;
import com.example.ExamenWeb.repository.BookRepository;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;

@SpringBootApplication
@ComponentScan(basePackageClasses = {MainController.class, HomeController.class})
@EnableJpaRepositories(basePackageClasses = BookRepository.class)
public class ExamenWebApplication {

	public static void main(String[] args) {
		SpringApplication.run(ExamenWebApplication.class, args);
	}

}
