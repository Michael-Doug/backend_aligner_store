require "test_helper"

class CorsTest < ActionDispatch::IntegrationTest
  test "libera a origem configurada" do
    get products_path, headers: { "Origin" => "http://localhost:4200" }

    assert_equal "http://localhost:4200", response.headers["Access-Control-Allow-Origin"]
  end

  test "não libera origem desconhecida" do
    get products_path, headers: { "Origin" => "http://site-aleatorio.example" }

    assert_nil response.headers["Access-Control-Allow-Origin"]
  end
end
