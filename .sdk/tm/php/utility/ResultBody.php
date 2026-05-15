<?php
declare(strict_types=1);

// IsEven SDK utility: result_body

class IsEvenResultBody
{
    public static function call(IsEvenContext $ctx): ?IsEvenResult
    {
        $response = $ctx->response;
        $result = $ctx->result;
        if ($result && $response && $response->json_func && $response->body) {
            $result->body = ($response->json_func)();
        }
        return $result;
    }
}
