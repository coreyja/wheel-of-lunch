class RestaurantWheel
  def initialize(num_stops)
    @num_stops = num_stops
  end

  def wheel
    generate_wheel unless defined?(@wheel)

    @wheel
  end

  private

  attr_reader :num_stops

  def ordered_restaurants
    @ordered_restaurants ||= Restaurant.all.sort_by(&:average_rating).reverse
  end

  def generate_wheel
    raise 'Must have restuarants to create a wheel!' if ordered_restaurants.empty?

    @wheel = []
    while @wheel.count < num_stops
      @wheel += ordered_restaurants
    end
    @wheel = @wheel.first(num_stops).shuffle
  end
end
