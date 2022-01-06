package com.example.Laborator9.util;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class MyQuadruple<T1, T2, T3, T4> {
    T1 key;
    T2 value;
    T3 value2;
    T4 value3;
}
