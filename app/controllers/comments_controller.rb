# CommentsController class
# author: Lukas Bischof
class CommentsController < ApplicationController
  before_action :find_comment, only: [:destroy]

  def find_comment
    @comment = Comment.find(params[:id])
  end

  def create
    @picture = Picture.find(params[:picture_id])
    @comment = @picture.comments.create(content: comment_params[:content], user_id: params[:user_id])
    if @comment
      respond_to_successful_creation params, @picture
    else
      redirect_to root_path
    end
  end

  def respond_to_successful_creation(params, picture)
    respond_to do |format|
      format.html do
        redirect_to url_for(action: 'show',
                            controller: 'pictures',
                            id: params[:picture_id].to_s,
                            user_id: picture.user.id)
      end
      format.json { render json: { 'success' => 'created' } }
      format.js
    end
  end

  def destroy
    if destroy_comment @comment, @comment.user, @comment.picture
      respond_to_destroy_success
    else
      respond_to_destroy_failure
    end
  end

  def destroy_comment(comment, user, picture)
    comment.destroy if user == current_user || picture.user == current_user
    false
  end

  def respond_to_destroy_success
    respond_to do |format|
      format.html { redirect_to get_pic_url @comment.picture.id, @comment.picture.user.id }
      format.js
    end
  end

  def respond_to_destroy_failure
    respond_to do |format|
      format.html { redirect_to root_path }
      format.js
    end
  end

  def comment_params
    params.require(:comment).permit(:content)
  end

  def get_pic_url(picid, userid)
    url_for(
      action: 'show',
      controller: 'pictures',
      id: picid.to_s,
      user_id: userid.to_s
    )
  end
end
