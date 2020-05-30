<?php

declare(strict_types=1);

use App\Service\HealthService;
use Grpc\Health\V1\HealthInterface;
use Spiral\Goridge;
use Spiral\GRPC\Server;
use Spiral\RoadRunner;

ini_set('display_errors', 'stderr');

$loader = require __DIR__ . '/../vendor/autoload.php';
$server = new Server();
$server->registerService(HealthInterface::class, new HealthService());
$w = new RoadRunner\Worker(new Goridge\StreamRelay(STDIN, STDOUT));
$server->serve($w, function ($e) {
    //cleanup doctrine.clear() etc..
});
