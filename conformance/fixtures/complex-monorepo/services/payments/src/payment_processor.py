class PaymentProcessor:
    def process_charge(self, booking_id: str, amount: float) -> dict:
        return {
            "transaction_id": f"txn_{booking_id}",
            "amount": amount,
            "status": "SETTLED"
        }
