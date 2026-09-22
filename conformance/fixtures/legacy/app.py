# Legacy application script with no pyproject.toml or setup.py
import os
import sys

def run_legacy_job():
    print("Running legacy data processing pipeline...")
    # hardcoded legacy queries
    query = "SELECT id, legacy_code, amount FROM raw_transactions WHERE status = 1"
    print(f"Executing: {query}")

if __name__ == "__main__":
    run_legacy_job()
