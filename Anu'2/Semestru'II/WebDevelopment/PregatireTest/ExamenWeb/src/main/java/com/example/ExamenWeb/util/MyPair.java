package com.example.ExamenWeb.util;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class MyPair<T1, T2> {

    T1 key;
    T2 value;
}