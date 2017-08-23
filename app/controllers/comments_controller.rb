# CommentsController class
# author: Lukas Bischof
class CommentsController < ApplicationController
  def create
    picture = Picture.find(params[:picture_id])
    if picture.comments.create(content: comment_params[:content], user_id: params[:user_id])
      redirect_to url_for(action: 'show',
                          controller: 'pictures',
                          id: params[:picture_id].to_s,
                          user_id: picture.user.id)
    else
      redirect_to root_path
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    if destroy_comment @comment, @comment.user, @comment.picture
      respond_to do |format|
        format.html { redirect_to get_pic_url picture.id, picture.user.id }
        format.js
      end
    else
      respond_to do |format|
        format.html { redirect_to root_path }
        format.js
      end
    end
  end

  def destroy_comment(comment, user, picture)
    if user == current_user || picture.user == current_user
      comment.destroy
      true
    end

    false

    # if user == current_user || picture.user == current_user
    #   comment.destroy
    #   redirect_to get_pic_url picture.id, picture.user.id
    # else
    #   redirect_to root_path
    # end
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
