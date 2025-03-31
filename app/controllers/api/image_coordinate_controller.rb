class Api::ImageCoordinateController < ApplicationController
  def check
    name = params[:name]
    who = params[:who]
    coord = params[:coord]

    if name.blank?
      render json: {
        status: "error",
        message: "Missing required parameter: name"
      }, status: :bad_request and return
    end
    if who.blank?
      render json: {
        status: "error",
        message: "Missing required parameter: who"
      }, status: :bad_request and return
    end
    if coord.blank?
      render json: {
        status: "error",
        message: "Missing required parameter: coord"
      }, status: :bad_request and return
    end

    image_record = ImageCoordinate.find_by(name: name)
    unless image_record
      render json: {
        status: "error",
        message: "Image #{name} not found."
      }, status: :not_found and return
    end


    main_coord =  case who.downcase
    when "waldo" then image_record.waldo
    when "wenda" then image_record.wenda
    when "wizard" then image_record.wizard
    when "odlaw" then image_record.odlaw
    else
      render json: {
        status: "error",
        message: "Invalid value for 'who'. Expected one of: waldo, wenda, wizard, odlaw."
      }, status: :unprocessable_entity and return
    end

    found = valid_coord?(coord, main_coord)

    render json: { status: "success", found: found }
  end

  private
  def valid_coord?(coord, main_coord)
    begin
      x, y = coord.split(",").map(&:to_i)
      raise ArgumentError unless x && y && coord.count(",") == 1
    rescue ArgumentError, NoMethodError, TypeError
      return false
    end

    tolerance = 20
    (x - main_coord[0]).abs <= tolerance &&
      (y - main_coord[1]).abs <= tolerance
  end
end
