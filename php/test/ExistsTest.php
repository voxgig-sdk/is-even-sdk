<?php
declare(strict_types=1);

// IsEven SDK exists test

require_once __DIR__ . '/../iseven_sdk.php';

use PHPUnit\Framework\TestCase;

class ExistsTest extends TestCase
{
    public function test_create_test_sdk(): void
    {
        $testsdk = IsEvenSDK::test(null, null);
        $this->assertNotNull($testsdk);
    }
}
