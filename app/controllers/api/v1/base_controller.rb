class Api::V1::BaseController < Api::V1::ApplicationController

  def render_json_error data, status
    render json: {errors: data}, status: status
  end

  def render_json_data data, status
    render json: data, status: status
  end

  def response_data class_serializer, object
    class_serializer.new object
  end
end
