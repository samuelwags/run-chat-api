# frozen_string_literal: true

class MileageController < ApplicationController
  def index
    @runs = Run.includes(:user).all.where(date: params[:start]...params[:end])
    @total_mileage = @runs.sum(&:distance)
    @pr_count = PersonalRecord.where(run_id: @runs.pluck(:id)).count
    render json: {
      total: @total_mileage,
      prs: @pr_count
    }, status: 200
  end
end