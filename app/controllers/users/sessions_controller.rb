class Users::SessionsController < Devise::SessionsController
# before_filter :configure_sign_in_params, only: [:create]

  def index
    @user = User.find(params[:id])
    @building = Building.find(@user.building_id)
    @posts = @building.posts.where({ :user_id => @user.id}).paginate(:page => params[:page], :per_page => 10).order("id DESC")

    render('index.html.erb', :layout => 'main')
  end

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.for(:sign_in) << :attribute
  # end
end
