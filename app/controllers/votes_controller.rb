class VotesController < ApplicationController # :nodoc:
  def create
    type = vote_params[:type].to_i.positive? ? '1' : '-1'

    picture = Picture.find(params[:picture_id])
    p picture
    if picture.votes.create(vote_type: type, user_id: params[:user_id])
      redirect_to url_for(pictures_url(params[:picture_id].to_s, picture.user.id))
    else
      redirect_to root_path
    end
  end

  def vote_params
    params.require(:vote).permit(:type)
  end

  def pictures_url(id, userid)
    {
      action: 'show',
      controller: 'pictures',
      id: id,
      user_id: userid
    }
  end
end
