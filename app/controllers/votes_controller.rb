class VotesController < ApplicationController
    def create
        user = User.find(params[:user_id])
        type = vote_params[:type].to_i.positive? ? '1' : '-1'

        picture = user.pictures.find(params[:picture_id])
        p picture
        if picture.votes.create(vote_type: type, user_id: params[:user_id])
            redirect_to url_for(action: 'show', controller: 'pictures', id: params[:picture_id].to_s, user_id: params[:user_id].to_s)
        else
            redirect_to root_path
        end
    end

    def vote_params
        params.require(:vote).permit(:type)
    end
end
