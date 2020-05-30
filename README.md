# Playground of gRPC communication in PHP

Start container
```bash
docker-compose up
```

Install dependencies
```bash
docker-compose exec -T grpc bash -c 'composer install
```

Generate messages and clients
```bash
docker-compose exec -T grpc bash -c 'composer proto:generate
```

Start gRPC server
```bash
docker-compose exec -T grpc bash -c 'rr-grpc serve -v -d'
```

Demo request
```bash
docker-compose exec -T grpc bash -c 'php client.php'
```
