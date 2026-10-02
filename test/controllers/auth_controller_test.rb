require "test_helper"

class AuthControllerTest < ActionDispatch::IntegrationTest
  test "login devolve token válido" do
    post auth_login_path, params: { email: "joana@example.com", password: "senha-de-teste" }

    assert_response :success
    token = response.parsed_body["token"]
    assert_equal users(:joana).id, AuthToken.decode(token)["user_id"]
  end

  test "senha errada devolve 401 sem vazar se o e-mail existe" do
    post auth_login_path, params: { email: "joana@example.com", password: "errada" }
    com_usuario = response.parsed_body["error"]

    post auth_login_path, params: { email: "ninguem@example.com", password: "errada" }

    assert_response :unauthorized
    assert_equal com_usuario, response.parsed_body["error"]
  end

  test "login ignora maiúsculas no e-mail" do
    post auth_login_path, params: { email: "JOANA@Example.com", password: "senha-de-teste" }

    assert_response :success
  end

  test "cadastro cria usuário comum e amarra no cliente de mesmo e-mail" do
    post auth_signup_path, params: { user: { email: "mariana@example.com", password: "outra-senha" } }

    assert_response :created
    assert_equal "customer", response.parsed_body["user"]["role"]
    assert_equal customers(:mariana).id, response.parsed_body["user"]["customer_id"]
  end

  test "cadastro não deixa escolher o cliente de outra pessoa" do
    post auth_signup_path, params: {
      user: { email: "novo@example.com", password: "senha-forte", customer_id: customers(:joana).id },
    }

    assert_response :created
    assert_nil response.parsed_body["user"]["customer_id"]
  end

  test "cadastro não deixa virar admin" do
    post auth_signup_path, params: {
      user: { email: "esperto@example.com", password: "senha-forte", role: "admin" },
    }

    assert_response :created
    assert_equal "customer", response.parsed_body["user"]["role"]
  end

  test "senha curta devolve 422" do
    post auth_signup_path, params: { user: { email: "curta@example.com", password: "123" } }

    assert_response :unprocessable_entity
  end

  test "token adulterado não autentica" do
    get auth_me_path, headers: { "Authorization" => "Bearer nao.e.um.token" }

    assert_response :unauthorized
  end

  test "token expirado não autentica" do
    token = travel_to(2.days.ago) { AuthToken.encode(users(:joana)) }

    get auth_me_path, headers: { "Authorization" => "Bearer #{token}" }

    assert_response :unauthorized
  end
end
