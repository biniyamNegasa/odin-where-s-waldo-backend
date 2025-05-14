class Api::LeaderboardsController < ApplicationController
  def show
    image_name = params[:image_name]

    timers = Timer.completed.where(image_name: image_name).order(Arel.sql("finish_time - start_time ASC")).limit(50)
    leaderboard_data = timers.map do | timer |
      { name: timer.name, time_taken: timer.duration }
    end

    render json: leaderboard_data

  rescue ActiveRecord::RecordNotFound
    render json: { error: "Leaderboard not found for #{image_name}" }, status: :not_found
  rescue
    render json: { error: "An unexpected error occured" }, status: :internal_server_error
  end
end
