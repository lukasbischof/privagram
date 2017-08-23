class Picture < ApplicationRecord # :nodoc:
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :votes, dependent: :destroy
  validates :path, presence: true

  def count_votes
    count = 0
    votes.each do |vote|
      count += vote.vote_type.to_i
    end

    count
  end
end
