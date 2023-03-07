# frozen_string_literal: true

class RunsController < ApplicationController
  def index
    @runs = Run.includes(:user).all.order(created_at: :desc).first(10)
    render(
      json: @runs,
      include: {
        user: { only: :user_name }
      },
      methods: :prs,
      status: 200
    )
  end

  def create
    @run = Run.new(
      date: params[:date],
      distance: params[:distance],
      time: params[:time],
      description: params[:description],
      user: @current_user
    )

    if @run.save!
      render json: @run, include: { user: { only: :user_name } }, status: 201
    else
      render json: { errors: @run.errors }, status: 503
    end
  end
end
