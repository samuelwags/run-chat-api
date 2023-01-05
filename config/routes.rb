# frozen_string_literal: true

Rails.application.routes.draw do
  resources :users
  resources :runs

  post '/auth/login', to: 'authentication#login'
  post '/auth/logout', to: 'authentication#logout'
  get '/auth/session', to: 'authentication#session'
end
