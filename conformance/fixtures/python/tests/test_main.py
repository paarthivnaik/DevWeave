import pytest
from src.app.main import calculate_discount

def test_calculate_discount_valid():
    assert calculate_discount(100.0, 20.0) == 80.0
    assert calculate_discount(50.0, 0.0) == 50.0

def test_calculate_discount_invalid():
    with pytest.raises(ValueError):
        calculate_discount(100.0, 150.0)
