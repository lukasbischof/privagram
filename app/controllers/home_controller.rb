# Home controller for index page
class HomeController < ApplicationController
  def index
    query = '
        (SELECT sum(vote_type)
        FROM votes
        WHERE votes.picture_id=pictures.id) DESC'
    @all_pictures = Picture.order(query)
    p @all_pictures
  end
end
