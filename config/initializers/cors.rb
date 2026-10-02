# Origens liberadas vêm de ALLOWED_ORIGINS, separadas por vírgula.
allowed_origins = ENV.fetch("ALLOWED_ORIGINS", "http://localhost:4200").split(",").map(&:strip)

Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins(*allowed_origins)
    resource "*",
             headers: :any,
             expose: %w[Authorization],
             methods: %i[get post put patch delete options head]
  end
end
