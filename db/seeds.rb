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
