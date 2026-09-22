package main

import "testing"

func TestCalculateTotal(t *testing.T) {
	items := []int{10, 20, 30}
	expected := 60
	actual := CalculateTotal(items)
	if actual != expected {
		t.Errorf("Expected %d, got %d", expected, actual)
	}
}
