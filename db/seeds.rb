# Cria o primeiro admin. Em produção, defina ADMIN_EMAIL e ADMIN_PASSWORD.
email = ENV.fetch("ADMIN_EMAIL", "admin@example.com")
password = ENV.fetch("ADMIN_PASSWORD", "trocar-esta-senha")

admin = User.find_or_initialize_by(email: email)
admin.password = password if admin.new_record?
admin.role = :admin
admin.save!

puts "Admin disponível: #{admin.email}"

Payment.find_or_create_by!(name: "Pix")
Payment.find_or_create_by!(name: "Cartão de crédito")
Payment.find_or_create_by!(name: "Boleto")

store = Store.find_or_create_by!(name: "Sousmile Centro") do |s|
  s.address = "Rua das Flores, 100"
  s.manager = "Ana Lima"
end

[
  ["Alinhador Light", "Casos leves de apinhamento e espaçamento dos dentes e correções de problemas leves na mordida.", 1890.0],
  ["Alinhador Smart", "Casos moderados de apinhamento e espaçamento dos dentes e correções moderadas na mordida.", 2890.0],
  ["Alinhador Plus", "Casos severos de apinhamento e espaçamento, associados a problemas ortodônticos mais significativos.", 3890.0],
  ["Clareamento", "Plaquinha feita sob medida: é só aplicar o gel e usar cerca de 8h por dia.", 690.0],
  ["Contenção", "Mantém os dentes na posição correta depois do tratamento com alinhadores.", 390.0],
  ["Limpeza", "Remoção de placa bacteriana, tártaro e manchas, com polimento. Recomendada a cada seis meses.", 250.0],
].each do |name, description, price|
  product = Product.find_or_initialize_by(name: name, store: store)
  product.update!(description: description, price: price)
end

puts "Catálogo: #{Product.count} produtos em #{Store.count} loja(s)"
