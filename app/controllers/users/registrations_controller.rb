class Users::RegistrationsController < Devise::RegistrationsController
# before_filter :configure_sign_up_params, only: [:create]
# before_filter :configure_account_update_params, only: [:update]

  before_action :ensure_super_admin, only: [:index, :admin_destroy]

  def index
    @users = User.all
    # if current_user.email == "alyhansen@gmail.com"
    #   render 'index'
    # else
    # redirect_to "/"
    # end
  end

  def admin_destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to "/users", :notice => "#{@user.first_name} #{@user.last_name} destroyed."
  end

  def ensure_super_admin
    if current_user.email != "alyhansen@gmail.com"
      redirect_to root_url, :alert => "Not authorized."
    end
  end

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  # def create
  #   super
  # end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.for(:sign_up) << :first_name, :last_name
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.for(:account_update) << :first_name, :last_name
  # end

  # The path used after sign up.
  def after_sign_up_path_for(resource)
    "/signups/new"
  end

  # The path used after sign up for inactive accounts.
  def after_inactive_sign_up_path_for(resource)
    "/signups/new"
  end
end
