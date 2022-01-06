package com.example.ExamenWeb.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import com.example.ExamenWeb.model.PublishingHouse;

@Repository
public interface PublishingHouseRepository extends JpaRepository<PublishingHouse, Long> {
    PublishingHouse findByName(String name);
    PublishingHouse findFirstById(Long id);
}