class PicturesController < ApplicationController # :nodoc:
  before_action :retrieve_user, only: %i[show create destroy]
  before_action :test_is_owner, only: %i[show destroy]

  def retrieve_user
    @user = User.find(params[:user_id])
  end

  def test_is_owner
    @is_owner = @user == current_user
  end

  def new
    @picture = Picture.new
  end

  def show
    @picture = @user.pictures.includes(:comments).find(params[:id])

    @votes_count = 0
    @votes_count = @picture.count_votes

    respond_to do |format|
      format.html do
        @already_voted = Vote.exists?(picture_id: @picture.id,
                                      user_id: current_user.id)
      end
      format.json { render json: @picture }
    end
  end

  def create
    return unless @user == current_user

    uploaded_io = picture_params[:picture]
    new_filename = generate_filename(uploaded_io)
    File.open(Rails.root.join('public', 'uploads', new_filename), 'wb') do |f|
      f.write(uploaded_io.read)

      @user.pictures.create(path: new_filename)

      redirect_to root_path
    end
  end

  def destroy
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

  def generate_filename(uploaded_io)
    "#{@user.id}#{Time.now.to_i}_#{uploaded_io.original_filename.strip.delete(' ')}"
  end
end
