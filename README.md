# backend_aligner_store

API em Ruby on Rails de uma loja de alinhadores, feita como estudo a partir do
site da sousmile. O front que consome esta API está em
[frontend_aligner_store](https://github.com/Michael-Doug/frontend_aligner_store).

## Como rodar

Precisa de Ruby 3.2.2 e PostgreSQL.

```bash
bundle install
bin/rails db:prepare
bin/rails db:seed
bin/rails server
```

O `db:seed` cria o admin, as formas de pagamento e um catálogo de exemplo.
Em produção, defina `ADMIN_EMAIL` e `ADMIN_PASSWORD` antes de rodar.

### Variáveis de ambiente

| Variável | Para que serve | Default |
|---|---|---|
| `DATABASE_HOST` / `DATABASE_PORT` | Conexão com o Postgres | `localhost` / `5432` |
| `DATABASE_USERNAME` / `DATABASE_PASSWORD` | Credenciais do Postgres | `postgres` / `postgres` |
| `DATABASE_NAME` | Prefixo do banco | `sou_store` |
| `ALLOWED_ORIGINS` | Origens liberadas no CORS, separadas por vírgula | `http://localhost:4200` |
| `ADMIN_EMAIL` / `ADMIN_PASSWORD` | Admin criado pelo seed | — |

Em produção o Rails usa `DATABASE_URL` se ela estiver definida.

## Autenticação

Token JWT no header `Authorization: Bearer <token>`, válido por 24 horas.

```bash
curl -X POST localhost:3000/auth/login \
  -d 'email=admin@example.com&password=sua-senha'
```

| Rota | Quem pode |
|---|---|
| `POST /auth/signup`, `POST /auth/login` | qualquer um |
| `GET` de `/products`, `/stores`, `/payments` | qualquer um |
| `POST /customers` | qualquer um (é a pré-avaliação do site) |
| escrever em `/products`, `/stores`, `/payments`, tudo em `/sellers` | admin |
| listar `/customers`, `/orders`, `/order_items` | admin |
| ver e mexer em um cliente, pedido ou item | admin, ou o próprio cliente |

## Recursos

`stores`, `customers`, `sellers`, `products`, `payments`, `orders`,
`order_items` — todos com `index`, `show`, `create`, `update` e `destroy`.

Cada um também tem `GET /<recurso>/by_attr`, que filtra pelos atributos
passados na query: colunas de texto por trecho (sem diferenciar maiúsculas) e
colunas numéricas por valor exato.

```bash
curl 'localhost:3000/products/by_attr?name=alinhador'
curl 'localhost:3000/products/by_attr?price=1890.0'
```

### Valores do pedido

`total_value` e `unitary_value` não são aceitos na requisição. O valor unitário
é copiado do preço do produto no momento da compra, e o total do pedido é
sempre a soma dos itens, recalculada quando um item entra ou sai.

## Testes

```bash
bin/rails test
```
