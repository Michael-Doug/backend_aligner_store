require "test_helper"

class OrderItemsControllerTest < ActionDispatch::IntegrationTest
  test "busca por quantidade não quebra em coluna inteira" do
    get by_attr_order_items_path, params: { quantity: 2 }, headers: admin_headers

    assert_response :success
    assert_equal 1, response.parsed_body.size
  end

  test "busca por valor total não quebra em coluna decimal" do
    get by_attr_order_items_path, params: { total_value: "300.0" }, headers: admin_headers

    assert_response :success
    assert_equal 1, response.parsed_body.size
  end

  test "quantidade zero devolve 422" do
    post order_items_path, params: {
      order_item: { quantity: 0, order_id: orders(:joana_pix).id, product_id: products(:clareamento).id },
    }, headers: admin_headers

    assert_response :unprocessable_entity
  end

  test "valor vem do produto e não do que o cliente mandar" do
    post order_items_path, params: {
      order_item: {
        quantity: 2,
        order_id: orders(:joana_pix).id,
        product_id: products(:clareamento).id,
        total_value: 0.01,
        unitary_value: 0.01,
      },
    }, headers: admin_headers

    assert_response :created
    assert_equal 161.0, response.parsed_body["total_value"].to_f
  end

  test "cliente não consegue incluir item no pedido de outro" do
    post order_items_path, params: {
      order_item: { quantity: 1, order_id: orders(:joana_pix).id, product_id: products(:clareamento).id },
    }, headers: auth_headers(users(:pedro))

    assert_response :forbidden
  end

  test "sem token devolve 401" do
    get order_items_path

    assert_response :unauthorized
  end
end
