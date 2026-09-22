<?php

namespace Example\Tests;

use PHPUnit\Framework\TestCase;
use Example\Calculator;

class CalculatorTest extends TestCase {
    public function testAdd() {
        $calc = new Calculator();
        $this->assertEquals(7, $calc->add(3, 4));
    }
}
