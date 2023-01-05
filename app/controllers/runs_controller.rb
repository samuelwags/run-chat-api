# frozen_string_literal: true

class RunsController < ApplicationController
  def index
    @runs = Run.includes(:user).all
    render json: @runs, include: { user: { only: :user_name } }, status: 200
  end

  def create
    @run = Run.new(
      date: Date.today,
      distance: params[:distance],
      time: params[:time],
      description: params[:description],
      user: @current_user
    )

    if @run.save
      render json: @run, inclued: { user: { only: :user_name } }, status: 201
    else
      render json: { errors: @run.errors.full_messages }, status: 503
    end
  end
end
