package com.notifications;

public class Sender {
    public void sendBookingConfirmation(String email, String bookingId) {
        System.out.println("Dispatched confirmation for booking " + bookingId + " to " + email);
    }
}
