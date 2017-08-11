class CommentsController < ApplicationController
    def create
        user = User.find(params[:user_id])

        picture = user.pictures.find(params[:picture_id])
        if picture.comments.create(content: comment_params[:content], user_id: params[:user_id])
            redirect_to url_for({:action=>"show", :controller=>"pictures", :id=>"#{params[:picture_id]}", :user_id=>"#{params[:user_id]}"})
        else
            redirect_to root_path
        end
    end

    def destroy
        comment = Comment.find(params[:id])
        user = comment.user
        picture = comment.picture
        if user == current_user or picture.user == current_user
            comment.destroy
            redirect_to get_pic_url picture.id, user.id
        else
            redirect_to root_path
        end
    end

    def comment_params
        params.require(:comment).permit(:content)
    end

    def get_pic_url(picid, userid)
        url_for({:action=>"show", :controller=>"pictures", :id=>"#{picid}", :user_id=>"#{userid}"})
    end
end