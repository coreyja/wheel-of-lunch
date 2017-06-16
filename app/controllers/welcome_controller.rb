class WelcomeController < ApplicationController
  def index
    if signed_in?
      redirect_to wheel_path
    end
  end
end
