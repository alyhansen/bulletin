class SignupsController < ApplicationController

  before_action :ensure_admin, only: [:approve]
  before_action :ensure_super_admin, only: [:index]

  def index
    @signups = Signup.all
  end

  def show
    @signup = Signup.find(params[:id])
  end

  def approve
    @signup = Signup.find(params[:id])
    @user = User.find_by({ :id => @signup.user_id})
    @user.building_id = @signup.building_id
    @user.role = "Resident"
    @user.save
    @signup.destroy
    redirect_to "/", :notice => "Signup approved."
  end

  def new
    @signup = Signup.new
  end

  def create
    @signup = Signup.new
    @signup.status = "Pending"
    @signup.user_id = current_user.id
    @signup.building_id = params[:building_id]

    if @signup.save
      redirect_to "/", :notice => "Signup created successfully."
    else
      render 'new'
    end
  end

  def edit
    @signup = Signup.find(params[:id])
  end

  def update
    @signup = Signup.find(params[:id])

    if @signup.save
      redirect_to "/signups", :notice => "Signup updated successfully."
    else
      render 'edit'
    end
  end

  def destroy
    @signup = Signup.find(params[:id])

    @signup.destroy

    redirect_to "/signups", :notice => "Signup deleted."
  end

  def ensure_admin
    @signup = Signup.find(params[:id])
    @building = Building.find(@signup.building_id)
    if current_user.id != @building.id
      redirect_to root_url, :alert => "Not authorized."
    end
  end

  def ensure_super_admin
    if current_user.email != "alyhansen@gmail.com"
      redirect_to root_url, :alert => "Not authorized."
    end
  end

end
