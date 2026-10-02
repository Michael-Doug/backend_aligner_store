require "test_helper"

class ProductsControllerTest < ActionDispatch::IntegrationTest
  test "busca por preço não quebra em coluna numérica" do
    get by_attr_products_path, params: { price: "150.0" }

    assert_response :success
    assert_equal ["Alinhador Light"], response.parsed_body.map { |p| p["name"] }
  end

  test "busca por nome ignora maiúsculas e minúsculas" do
    get by_attr_products_path, params: { name: "alinhador" }

    assert_response :success
    assert_equal 1, response.parsed_body.size
  end

  test "sem filtro devolve todos" do
    get by_attr_products_path

    assert_response :success
    assert_equal Product.count, response.parsed_body.size
  end

  test "criar sem preço devolve 422 com os erros" do
    post products_path, params: { product: { name: "Sem preço", store_id: stores(:matriz).id } }

    assert_response :unprocessable_entity
    assert_includes response.parsed_body["errors"].keys, "price"
  end

  test "atualizar com dado inválido devolve 422 em vez de estourar" do
    patch product_path(products(:clareamento)), params: { product: { price: -1 } }

    assert_response :unprocessable_entity
  end

  test "remover devolve 204 sem corpo" do
    product = products(:clareamento)
    product.order_items.destroy_all

    assert_difference("Product.count", -1) do
      delete product_path(product)
    end
    assert_response :no_content
  end

  test "buscar id inexistente devolve 404" do
    get product_path(id: 0)

    assert_response :not_found
  end
end
