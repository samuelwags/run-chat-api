Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins 'http://localhost:3002', 'https://runchat.net', 'https://www.runchat.net'
    resource '*', headers: :any, methods: [:get, :post], credentials: true
  end
end
