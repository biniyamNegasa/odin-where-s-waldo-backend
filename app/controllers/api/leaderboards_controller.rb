class Api::LeaderboardsController < ApplicationController
  def show
    image_name = params[:image_name]

    unless ImageCoordinate.exists?(name: image_name)
      render json: { error: "Unknown image: #{image_name}" }, status: :not_found and return
    end

    timers = Timer.completed
      .where(image_name: image_name)
      .order(Arel.sql("julianday(finish_time) - julianday(start_time) ASC"))
      .limit(50)

    render json: timers.map { |timer| { name: timer.name, time_taken: timer.duration } }
  end
end
