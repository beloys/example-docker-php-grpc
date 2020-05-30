<?php

use Grpc\ChannelCredentials;
use Grpc\Health\V1\HealthCheckRequest;
use Grpc\Health\V1\HealthCheckResponse;
use Grpc\Health\V1\HealthClient;

$loader = require __DIR__ . '/vendor/autoload.php';

$client = new HealthClient('127.0.0.1:8080', [
    'credentials' => ChannelCredentials::createInsecure(),
]);

[$reply, $error] = $client->Check((new HealthCheckRequest())->setService('test'))->wait();
/** @var HealthCheckResponse|null $reply */

if (! $reply) {
    throw new Exception(sprintf('No reply %s', json_encode($error)));
}

echo $reply->serializeToJsonString();
