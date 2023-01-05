Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins 'http://localhost:3002'
    resource '*', headers: :any, methods: [:get, :post], credentials: true
  end
end