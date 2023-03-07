# frozen_string_literal: true

class TrainingPlansController < ApplicationController
  def index
    render json: @training_plans
  end

  def show
    training_plan = TrainingPlan.includes(:user, :planned_runs, :members).find(params[:id])
    render json: training_plan, include: [:user, { planned_runs: { include: :user, methods: :completed } }, :members], status: 200
  end

  def create
    @plan = TrainingPlan.new(training_plan_params)
    if @plan.save
      render json: @plan, status: 201
    else
      render json: { errors: @plan.errors.full_messages }, status: 503
    end
  end

  def training_plan_params
    params.permit(:name, :penalty).merge({ user: @current_user })
  end
end
