package com.example;

import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.assertEquals;

public class AppTest {
    @Test
    public void testMultiply() {
        assertEquals(20, App.multiply(4, 5));
    }
}
