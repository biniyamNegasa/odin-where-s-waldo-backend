class Api::TimersController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    timer = Timer.new(timer_params.merge(start_time: Time.current))

    if timer.save
      render json: timer, status: :created
    else
      render json: timer.errors.full_messages, status: :unprocessable_entity
    end
  end

  def update
    timer = Timer.find(params[:id])

    if timer.finish_time.present?
      render json: { error: "Game already finished" }, status: :unprocessable_entity
      return
    end

    if timer.update(finish_time: Time.current)
      render json: { time_taken: timer.duration }, status: :ok
    else
      render json: timer.errors.full_messages, status: :unprocessable_entity
    end

  rescue ActiveRecord::RecordNotFound
    render json: { error: "Timer not found" }, status: :not_found
  end

  private
  def timer_params
    params.require(:timer).permit(:name, :image_name)
  end
end
