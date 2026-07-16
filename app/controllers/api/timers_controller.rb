class Api::TimersController < ApplicationController
  # POST /api/timers — start a game
  def create
    timer = Timer.new(timer_params.merge(start_time: Time.current))

    if timer.save
      render json: timer, status: :created
    else
      render json: { errors: timer.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # POST /api/timers/:id/check — guess a character's location
  def check
    timer = Timer.find(params[:id])

    if timer.finished?
      render json: { error: "Game already finished" }, status: :unprocessable_entity and return
    end

    who = params[:who].to_s.downcase
    unless Timer::CHARACTERS.include?(who)
      render json: {
        error: "Invalid value for 'who'. Expected one of: #{Timer::CHARACTERS.join(', ')}."
      }, status: :unprocessable_entity and return
    end

    if params[:coord].blank?
      render json: { error: "Missing required parameter: coord" }, status: :bad_request and return
    end

    image = ImageCoordinate.find_by(name: timer.image_name)
    unless image
      render json: { error: "Image #{timer.image_name} not found." }, status: :not_found and return
    end

    found = image.character_at?(who, params[:coord])
    timer.record_found(who) if found

    render json: {
      found: found,
      found_characters: timer.found_characters,
      all_found: timer.all_found?
    }
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Timer not found" }, status: :not_found
  end

  # PATCH /api/timers/:id — finish a game (only when everyone has been found)
  def update
    timer = Timer.find(params[:id])

    if timer.finished?
      render json: { error: "Game already finished" }, status: :unprocessable_entity and return
    end

    unless timer.all_found?
      render json: { error: "Not all characters have been found yet" }, status: :unprocessable_entity and return
    end

    timer.update!(finish_time: Time.current)
    render json: { time_taken: timer.duration }, status: :ok
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Timer not found" }, status: :not_found
  end

  private

  def timer_params
    params.require(:timer).permit(:name, :image_name)
  end
end
