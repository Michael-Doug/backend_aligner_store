require "test_helper"

class CustomersControllerTest < ActionDispatch::IntegrationTest
  test "busca por nome ignora maiúsculas e acentos digitados igual" do
    get by_attr_customers_path, params: { name: "joana" }, headers: admin_headers

    assert_response :success
    assert_equal ["Joana Ribeiro"], response.parsed_body.map { |c| c["name"] }
  end

  test "cliente sem loja devolve 422 em vez de estourar no banco" do
    post customers_path, params: { customer: { name: "Sem loja", cpf: "33333333333" } }

    assert_response :unprocessable_entity
    assert_includes response.parsed_body["errors"].keys, "store"
  end

  test "cpf duplicado devolve 422" do
    post customers_path, params: {
      customer: { name: "Clone", cpf: customers(:joana).cpf, store_id: stores(:matriz).id },
    }

    assert_response :unprocessable_entity
    assert_includes response.parsed_body["errors"].keys, "cpf"
  end

  test "email inválido devolve 422" do
    post customers_path, params: {
      customer: { name: "Fulano", cpf: "44444444444", email: "não-é-email", store_id: stores(:matriz).id },
    }

    assert_response :unprocessable_entity
  end

  test "remover devolve 204 e leva junto a conta de acesso" do
    customer = customers(:pedro)
    customer.orders.destroy_all

    assert_difference("User.count", -1) do
      delete customer_path(customer), headers: admin_headers
    end
    assert_response :no_content
  end

  test "payload sem a chave customer devolve 400" do
    post customers_path, params: { name: "Solto" }

    assert_response :bad_request
  end

  test "cliente não enxerga o cadastro de outro" do
    get customer_path(customers(:joana)), headers: auth_headers(users(:pedro))

    assert_response :forbidden
  end

  test "listar clientes é restrito a admin" do
    get customers_path, headers: auth_headers(users(:joana))

    assert_response :forbidden
  end
end
