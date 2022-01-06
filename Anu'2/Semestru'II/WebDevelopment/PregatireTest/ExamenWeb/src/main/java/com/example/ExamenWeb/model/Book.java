package com.example.ExamenWeb.model;

import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.*;

import javax.persistence.*;
import java.io.Serializable;
import java.sql.Date;

@Entity
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Builder
@Table(name = "book")
public class Book implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "name")
    private String name;

    //@JsonIgnore
    //@ManyToOne
    //@JoinColumn(name = "publishing_house_id")
    //private PublishingHouse publishingHouse;

    @Column(name = "publishing_house_id")
    private Long pid;

    @Column(name = "topic1")
    private String topic1;

    @Column(name = "topic2")
    private String topic2;

    @Column(name = "topic3")
    private String topic3;

    @Column(name = "topic4")
    private String topic4;

    @Column(name = "topic5")
    private String topic5;
}

