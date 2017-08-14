class HomeController < ApplicationController
    def index
        @all_pictures = Picture.order("(SELECT sum(vote_type) FROM votes WHERE votes.picture_id=pictures.id) DESC")
        p @all_pictures
    end
end
