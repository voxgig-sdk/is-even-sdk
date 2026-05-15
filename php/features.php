<?php
declare(strict_types=1);

// IsEven SDK feature factory

require_once __DIR__ . '/feature/BaseFeature.php';
require_once __DIR__ . '/feature/TestFeature.php';


class IsEvenFeatures
{
    public static function make_feature(string $name)
    {
        switch ($name) {
            case "base":
                return new IsEvenBaseFeature();
            case "test":
                return new IsEvenTestFeature();
            default:
                return new IsEvenBaseFeature();
        }
    }
}
