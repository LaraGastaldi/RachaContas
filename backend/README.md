# Backend

# Stacks
- Laravel 11
- PHP 8.3
- Postgres 15

# Como rodar

Copie o arquivo `.env.example` para `.env`, e copie também o arquivo `laradock/.env.example` para `laradock/.env`.

No arquivo `.env`, mude os `DATABASE_*` para o abaixo:
```
DB_CONNECTION=pgsql
DB_HOST=postgres
DB_PORT=5432
DB_DATABASE=laravel
DB_USERNAME=user
DB_PASSWORD=root
```

Mude em `laradock/.env` a parte de `POSTGRES_*` para abaixo:
```
POSTGRES_VERSION=13-alpine
POSTGRES_CLIENT_VERSION=15
POSTGRES_DB=laravel
POSTGRES_USER=user
POSTGRES_PASSWORD=root
POSTGRES_PORT=5432
POSTGRES_ENTRYPOINT_INITDB=./postgres/docker-entrypoint-initdb.d
```

Esse app está usando docker-compose, para rodá-lo basta executar o comando abaixo:
```
cd laradock
docker-compose up -d workspace nginx postgres
```

Para funcionar, é necessário rodar as migrações como abaixo:
```
docker-compose run workspace php artisan migrate
```
Ou entrar dentro do container e rodar `php artisan migrate`
