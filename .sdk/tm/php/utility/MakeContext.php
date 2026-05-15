<?php
declare(strict_types=1);

// IsEven SDK utility: make_context

require_once __DIR__ . '/../core/Context.php';

class IsEvenMakeContext
{
    public static function call(array $ctxmap, ?IsEvenContext $basectx): IsEvenContext
    {
        return new IsEvenContext($ctxmap, $basectx);
    }
}
