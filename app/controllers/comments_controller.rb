class CommentsController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(params[:comment].permit[:comment])
    @comment.user_id = current_user.id
    @comment.building_id = current_user.building_id
    @comment.post_id = params[:post_id]
    @comment.content = params[:comment]["content"]

    if @comment.save
      redirect_to "/buildings/#{@comment.building_id}/posts/#{@comment.post_id}"
    else
      redirect_to :controller => 'posts', :action => 'show', :id => @comment.post_id, :comm_mess => @comment.errors.full_messages
    end

  end

  def edit
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    render('edit.html.erb', :layout => 'main')
  end

  def update
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    @comment.content = params[:content]

    if @comment.save
      redirect_to "/buildings/#{@comment.building_id}/posts/#{@comment.post_id}"
    else
      render 'edit'
    end

  end

  def destroy
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])

    @comment.destroy

    redirect_to "/buildings/#{@comment.building_id}/posts/#{@comment.post_id}", :notice => "Comment deleted."
  end
end
