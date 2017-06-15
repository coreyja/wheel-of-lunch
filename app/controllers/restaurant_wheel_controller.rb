class RestaurantWheelController < AuthenticatedController
  def index
    @restaurant_wheel = RestaurantWheel.new(wheel_params.to_h.symbolize_keys)
  end

  private

  def wheel_params
    params.permit(:num_stops)
  end
end
