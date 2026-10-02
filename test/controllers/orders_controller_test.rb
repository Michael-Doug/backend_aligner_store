require "test_helper"

class OrdersControllerTest < ActionDispatch::IntegrationTest
  test "busca por valor total não quebra em coluna decimal" do
    orders(:joana_pix).recalculate_total_value!

    get by_attr_orders_path, params: { total_value: "300.0" }, headers: admin_headers

    assert_response :success
    assert_equal 1, response.parsed_body.size
  end

  test "pedido novo nasce zerado mesmo se o cliente mandar outro valor" do
    post orders_path, params: {
      order: {
        customer_id: customers(:joana).id,
        store_id: stores(:matriz).id,
        payment_id: payments(:pix).id,
        total_value: 999.0,
      },
    }, headers: admin_headers

    assert_response :created
    assert_equal 0.0, response.parsed_body["total_value"].to_f
  end

  test "total acompanha os itens incluídos e removidos" do
    order = orders(:pedro_cartao)
    order.recalculate_total_value!
    assert_equal 80.5, order.reload.total_value

    item = order.order_items.create!(quantity: 2, product: products(:alinhador_light))
    assert_equal 380.5, order.reload.total_value

    item.destroy
    assert_equal 80.5, order.reload.total_value
  end

  test "pedido sem cliente devolve 422" do
    post orders_path, params: {
      order: { store_id: stores(:matriz).id, payment_id: payments(:pix).id },
    }, headers: admin_headers

    assert_response :unprocessable_entity
  end

  test "cliente não enxerga o pedido de outro" do
    get order_path(orders(:joana_pix)), headers: auth_headers(users(:pedro))

    assert_response :forbidden
  end

  test "cliente enxerga o próprio pedido" do
    get order_path(orders(:joana_pix)), headers: auth_headers(users(:joana))

    assert_response :success
  end

  test "pedido criado por cliente fica no nome dele, não no que ele mandar" do
    post orders_path, params: {
      order: {
        customer_id: customers(:joana).id,
        store_id: stores(:matriz).id,
        payment_id: payments(:pix).id,
      },
    }, headers: auth_headers(users(:pedro))

    assert_response :created
    assert_equal customers(:pedro).id, response.parsed_body["customer_id"]
  end

  test "listar todos é restrito a admin" do
    get orders_path, headers: auth_headers(users(:joana))

    assert_response :forbidden
  end
end
