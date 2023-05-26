# Projeto API em Ruby on Rails

Este é um projeto de API desenvolvido em Ruby on Rails, inspirado na Sousmile. A API possui um CRUD completo e utiliza o PostgreSQL para armazenar os dados nas tabelas.

## Pré-requisitos

Certifique-se de ter os seguintes requisitos instalados em sua máquina:

- Ruby (versão 3.2.0)
- Ruby on Rails (versão 7.0.4.3)
- PostgreSQL (versão 15.2)

## Configuração do ambiente

1. Clone este repositório para o seu diretório local:

```prompt
git clone https://github.com/seu-usuario/seu-projeto.git
```

2. Acesse o diretório do projeto:

```prompt
cd seu-projeto
```

3. Instale as dependências do projeto:

```prompt
bundle install
```

4. Crie o banco de dados:

```prompt
rails db:create
```

5. Execute as migrações do banco de dados:

```prompt
rails db:migrate
```

6. Inicie o servidor da aplicação:

```prompt
rails server
```

A API estará disponível em `http://localhost:3000`.

## Endpoints

A API possui os seguintes endpoints:

### Stores

GET /stores/by_attr: Busca lojas com base em atributos específicos.
GET /stores: Retorna uma lista de todas as lojas no formato JSON.
GET /stores/:id: Retorna os detalhes de uma loja específica no formato JSON.
POST /stores: Cria uma nova loja com base nos dados fornecidos no corpo da requisição.
PUT /stores/:id: Atualiza uma loja existente com base nos dados fornecidos no corpo da requisição.
DELETE /stores/:id: Remove uma loja específica.

### Customers

GET /customers/by_attr: Busca clientes com base em atributos específicos.
GET /customers: Retorna uma lista de todos os clientes no formato JSON.
GET /customers/:id: Retorna os detalhes de um cliente específico no formato JSON.
POST /customers: Cria um novo cliente com base nos dados fornecidos no corpo da requisição.
PUT /customers/:id: Atualiza um cliente existente com base nos dados fornecidos no corpo da requisição.
DELETE /customers/:id: Remove um cliente específico.

### Products

GET /products/by_attr: Busca produtos com base em atributos específicos.
GET /products: Retorna uma lista de todos os produtos no formato JSON.
GET /products/:id: Retorna os detalhes de um produto específico no formato JSON.
POST /products: Cria um novo produto com base nos dados fornecidos no corpo da requisição.
PUT /products/:id: Atualiza um produto existente com base nos dados fornecidos no corpo da requisição.
DELETE /products/:id: Remove um produto específico.

### Sellers

GET /sellers/by_attr: Busca vendedores com base em atributos específicos.
GET /sellers: Retorna uma lista de todos os vendedores no formato JSON.
GET /sellers/:id: Retorna os detalhes de um vendedor específico no formato JSON.
POST /sellers: Cria um novo vendedor com base nos dados fornecidos no corpo da requisição.
PUT /sellers/:id: Atualiza um vendedor existente com base nos dados fornecidos no corpo da requisição.
DELETE /sellers/:id: Remove um vendedor específico.

### Payments

GET /payments/by_attr: Busca pagamentos com base em atributos específicos.
GET /payments: Retorna uma lista de todos os pagamentos no formato JSON.
GET /payments/:id: Retorna os detalhes de um pagamento específico no formato JSON.
POST /payments: Cria um novo pagamento com base nos dados fornecidos no corpo da requisição.
PUT /payments/:id: Atualiza um pagamento existente com base nos dados fornecidos no corpo da requisição.
DELETE /payments/:id: Remove um pagamento específico.

### Orders

GET /orders/by_attr: Busca pedidos com base em atributos específicos.
GET /orders: Retorna uma lista de todos os pedidos no formato JSON.
GET /orders/:id: Retorna os detalhes de um pedido específico no formato JSON.
POST /orders: Cria um novo pedido com base nos dados fornecidos no corpo da requisição.
PUT /orders/:id: Atualiza um pedido existente com base nos dados fornecidos no corpo da requisição.
DELETE /orders/:id: Remove um pedido específico.

### Order Items

GET /order_items/by_attr: Busca itens de pedido com base em atributos específicos.
GET /order_items: Retorna uma lista de todos os itens de pedido no formato JSON.
GET /order_items/:id: Retorna os detalhes de um item de pedido específico no formato JSON.
POST /order_items: Cria um novo item de pedido com base nos dados fornecidos no corpo da requisição.
PUT /order_items/:id: Atualiza um item de pedido existente com base nos dados fornecidos no corpo da requisição.
DELETE /order_items/:id: Remove um item de pedido específico.

Certifique-se de enviar as requisições no formato JSON adequado, de acordo com os parâmetros esperados pelos endpoints.

## Frontend

O frontend deste projeto está disponível no repositório frontend_aligner_store https://github.com/Michael-Doug/frontend_aligner_store no GitHub. Certifique-se de visitar o repositório para obter mais informações sobre a interface do usuário e o código frontend do projeto.

## Agradecimentos

Gostaria de expressar minha sincera gratidão aos seguintes professores e líderes que contribuíram significativamente para o desenvolvimento deste projeto:

Douglas Camargo Campos - Senior Software Engineering Manager na SouSmile
Luiza Nathália Garzim - Senior Software Engineer (Tech Lead) na SouSmile
Ramon Andrade - Senior Software Engineer na SouSmile
Willian Martinez - Software Engineer na SouSmile

Agradeço a cada um de vocês pela orientação, suporte e conhecimento compartilhado ao longo deste projeto. Suas contribuições foram inestimáveis e desempenharam um papel fundamental no sucesso desta iniciativa.

## Contribuição

Contribuições são bem-vindas! Se você tiver sugestões, correções de bugs ou melhorias para o projeto, fique à vontade para enviar um pull request.
