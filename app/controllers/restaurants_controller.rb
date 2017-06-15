class RestaurantsController < AuthenticatedController
  def index
    @restaurants = Restaurant.by_name
  end

  def show
    @restaurant = Restaurant.find(params[:id])
  end

  def new
    @restaurant = Restaurant.new
  end

  def create
    @restaurant = Restaurant.new restaurant_params

    if @restaurant.save
      redirect_to restaurant_path(@restaurant.id)
    else
      render :new
    end
  end

  def destroy
    Restaurant.find(params[:id]).destroy!
    redirect_to restaurants_path
  end

  private

  def restaurant_params
    params.require(:restaurant).permit(:name, :walking_minutes_away, :street_address,
      :phone_number, :menu_link, :string_tags)
  end
end
