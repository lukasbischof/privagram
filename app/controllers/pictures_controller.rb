class PicturesController < ApplicationController
    def new
        @picture = Picture.new
    end

    def show
        user = User.find(params[:user_id])

        @is_owner = user == current_user

        @picture = user.pictures.find(params[:id])

        @votes_count = 0
        @picture.votes.each do |vote|
            @votes_count += vote.vote_type.to_i
        end

        @alreadyVoted = Vote.exists?(picture_id: @picture.id, user_id: current_user.id)
    end

    def create
        user = User.find(params[:user_id])
        return unless user == current_user

        uploaded_io = picture_params[:picture]
        new_filename = "#{user.id}#{Time.now.to_i}_#{uploaded_io.original_filename}"
        File.open(Rails.root.join('public', 'uploads', new_filename), 'wb') do |file|
            file.write(uploaded_io.read)

            user.pictures.create({
                :path => new_filename
            })

            redirect_to root_path
        end
    end

    def destroy
        user = User.find(params[:user_id])

        @is_owner = user == current_user
        p "isowner #{@is_owner}"
        if @is_owner
            picture = Picture.find(params[:id])
            picture.destroy
        end

        redirect_to home_index_path
    end

    private
    def picture_params
        params.require(:picture).permit(:picture)
    end
end
