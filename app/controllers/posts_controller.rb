class PostsController < ApplicationController

  before_filter :load_building

  before_action :ensure_author, only: [:edit, :delete, :update]
  before_action :ensure_resident, only: [:show, :create]
  before_action :ensure_admin, only: [:index]

  def index
    @posts = @building.posts.all
  end

  def show
    @post = Post.find(params[:id])
    @comment = @post.comments.new
    @comments = @post.comments.order("id DESC")
    render('show.html.erb', :layout => 'main')
  end

  def create
    @post = @building.posts.new(params[:post].permit[:post])
    @post.building_id = current_user.building_id
    @post.user_id = current_user.id
    @post.subject = params[:post]["subject"]
    @post.post_type = params[:post]["post_type"]
    @post.content = params[:post]["content"]

    if @post.save
      redirect_to "/buildings/#{current_user.building_id}", :notice => "Post created successfully."
    else
      redirect_to :controller => 'buildings', :action => 'show', :id => @post.building_id, :post_mess => @post.errors.full_messages
    end

  end

  def edit
    @post = @building.posts.find(params[:id])
    render('edit.html.erb', :layout => 'main')
  end

  def update
    @post = @building.posts.find(params[:id])
    @post.subject = params[:subject]
    @post.post_type = params[:post_type]
    @post.content = params[:content]

    if @post.save
      redirect_to "/buildings/#{@post.building_id}", :notice => "Post updated successfully."
    else
      render 'edit'
    end
  end

  def destroy
    @post = @building.posts.find(params[:id])

    @post.destroy

    redirect_to "/", :notice => "Post deleted."
  end

  def ensure_author
    @post = @building.posts.find(params[:id])
    if current_user.id != @post.user_id
      redirect_to root_url, :alert => "Not authorized."
    end
  end

  def ensure_resident
    if current_user.building_id != params[:building_id].to_i
      redirect_to root_url, :alert => "Not authorized."
    end
  end

  def ensure_admin
    @building = Building.find(params[:building_id])
    if current_user.id != @building.admin_id
      redirect_to root_url, :alert => "Not authorized."
    end
  end

  private

  def load_building
    @building = Building.find(params[:building_id])
  end

end
