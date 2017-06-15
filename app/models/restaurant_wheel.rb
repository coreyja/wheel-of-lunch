class RestaurantWheel
  DEFAULT_NUM_STOPS = 32

  delegate :each_with_index, to: :wheel

  def initialize(num_stops: DEFAULT_NUM_STOPS, included_tags: [], excluded_tags: [], max_walking_time: nil)
    @num_stops = num_stops.to_i
    @included_tags = included_tags
    @excluded_tags = excluded_tags
    @max_walking_time = max_walking_time&.to_i
  end

  def wheel
    generate_wheel unless defined?(@wheel)

    @wheel
  end

  private

  attr_reader :num_stops, :included_tags, :excluded_tags, :max_walking_time

  def filtered_restaurants
    unless defined?(@filtered_restaurants)
      @filtered_restaurants = Restaurant.all
      @filtered_restaurants = @filtered_restaurants.within_minutes(max_walking_time) if max_walking_time.present?
      @filtered_restaurants = @filtered_restaurants.with_tag_names(included_tags) if included_tags.present?
      @filtered_restaurants = @filtered_restaurants.without_tag_names(excluded_tags) if excluded_tags.present?
    end
    @filtered_restaurants
  end

  def ordered_restaurants
    @ordered_restaurants ||= filtered_restaurants.sort_by(&:average_rating).reverse
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
