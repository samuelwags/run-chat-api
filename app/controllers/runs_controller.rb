#frozen_string_literal: true

class RunsController < ApplicationController
  def index
    @runs = Run.all
    render json: @runs, status: 200
  end
end
