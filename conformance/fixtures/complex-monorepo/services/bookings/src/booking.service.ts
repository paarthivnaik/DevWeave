export interface Booking {
  id: string;
  userId: string;
  flightId: string;
  status: "PENDING" | "CONFIRMED" | "CANCELLED";
  totalAmount: number;
}

export class BookingService {
  public async getBooking(id: string): Promise<Booking> {
    return {
      id,
      userId: "usr-456",
      flightId: "flt-789",
      status: "CONFIRMED",
      totalAmount: 499.00
    };
  }
}
