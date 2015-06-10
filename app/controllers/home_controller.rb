class HomeController < ApplicationController

  skip_before_action :authenticate_user!

  def index
    return redirect_to "/users/sign_in" if current_user.nil?
    if current_user.building
      redirect_to current_user.building
    else
      redirect_to(signup_to_building_path)
    end
  end

end
