# frozen_string_literal: true

class PlannedRunsController < ApplicationController
  def create
    permitted_params = planned_run_params
    @run = PlannedRun.new(
      date: permitted_params[:date],
      distance: permitted_params[:distance],
      description: permitted_params[:description],
      user_id: permitted_params[:user_id],
      training_plan_id: permitted_params[:training_plan_id]
    )

    if @run.save!
      render json: @run, methods: :completed, status: 201
    else
      render json: { errors: @run.errors }, status: 503
    end
  end

  def planned_run_params
    params.permit(:distance, :description, :user_id, :training_plan_id, :date)
  end
end
