# frozen_string_literal: true

Rails.application.routes.draw do
  resources :planned_runs
  resources :runs
  resources :training_plans
  resources :users

  post '/auth/login', to: 'authentication#login'
  post '/auth/logout', to: 'authentication#logout'
  post '/auth/create', to: 'authentication#create'
  get '/auth/session', to: 'authentication#session'

  get '/mileage', to: 'mileage#index'
end
