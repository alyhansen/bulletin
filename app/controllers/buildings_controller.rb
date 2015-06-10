class BuildingsController < ApplicationController

  before_action :ensure_resident, only: [:show]
  before_action :ensure_admin, only: [:pending, :edit, :update, :destroy]
  before_action :ensure_super_admin, only: [:index]

  def index
    @buildings = Building.all
  end

  def show
    @building = Building.find(params[:id])
    @post = @building.posts.new

    if params[:filter_post] != nil
      @posts = @building.posts.where({ :post_type => params[:filter_post].titleize }).paginate(:page => params[:page], :per_page => 10).order("id DESC")
    else
      @posts = @building.posts.paginate(:page => params[:page], :per_page => 10).order("id DESC")
    end

    if current_user.admin?
      render('show_admin.html.erb', :layout => 'main')
    else
      render('show.html.erb', :layout => 'main')
    end
  end

  def residents
    @building = Building.find(params[:id])
    @users = @building.users.paginate(:page => params[:page], :per_page => 50).order("last_name")
    render('residents.html.erb', :layout => 'main')
  end

  def pending
    @building = Building.find(params[:id])
    @building.signups = @building.signups.where(status: 'Pending')
    render('pending.html.erb', :layout => 'main')
  end

  def new
    @building = Building.new
  end

  def create
    @building = Building.new
    @building.name = params[:name]
    @building.phone = params[:phone]
    @building.address = params[:address]
    @building.admin_id = current_user.id

    if @building.save
      current_user.building_id = @building.id
      current_user.role = "Admin"
      current_user.save
      redirect_to "/buildings/#{@building.id}", :notice => "Building created successfully."
    else
      render 'new'
    end
  end

  def edit
    @building = Building.find(params[:id])
    render('edit.html.erb', :layout => 'main')
  end

  def update
    @building = Building.find(params[:id])
    @building.name = params[:name]
    @building.phone = params[:phone]
    @building.address = params[:address]

    if @building.save
      redirect_to "/buildings/#{@building.id}", :notice => "Building updated successfully."
    else
      render 'edit'
    end
  end

  def destroy
    @building = Building.find(params[:id])

    @building.destroy

    redirect_to "/", :notice => "Building deleted."
  end

  def ensure_resident
    if current_user.building_id != params[:id].to_i
      redirect_to root_url, :alert => "Not authorized."
    end
  end

  def ensure_admin
    @building = Building.find(params[:id])
    if current_user.id != @building.admin_id
      redirect_to root_url, :alert => "Not authorized."
    end
  end

  def ensure_super_admin
    if current_user.email != "alyhansen@gmail.com"
      redirect_to root_url, :alert => "Not authorized."
    end
  end

end
