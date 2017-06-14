class RestaurantRatingsController < AuthenticatedController
  def index
    @restaurant = Restaurant.find(params[:restaurant_id])
    @ratings = @restaurant.ratings
  end

  def new
    @restaurant = Restaurant.find(params[:restaurant_id])
    @rating = @restaurant.ratings.new
  end

  def create
    @restaurant = Restaurant.find(params[:restaurant_id])
    @rating = @restaurant.ratings.new create_params.merge(user: current_user)

    if @rating.save
      redirect_to action: :index
    else
      render :new
    end
  end

  private

  def create_params
    params.require(:rating).permit(:rating)
  end
end
