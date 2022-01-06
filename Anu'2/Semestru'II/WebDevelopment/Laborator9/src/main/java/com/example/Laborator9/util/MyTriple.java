package com.example.Laborator9.util;

import lombok.AllArgsConstructor;
import lombok.Data;

import javax.xml.crypto.dom.DOMURIReference;

@Data
@AllArgsConstructor
public class MyTriple<T1, T3> implements Comparable<MyTriple<T1, T3>> {
    T1 key;
    Integer value;
    T3 value2;


    @Override
    public int compareTo(MyTriple<T1, T3> o) {
        return this.value.compareTo(o.value);
    }
}
