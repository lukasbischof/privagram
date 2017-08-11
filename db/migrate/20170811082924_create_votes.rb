class CreateVotes < ActiveRecord::Migration[5.1]
  def change
    create_table :votes do |t|
      t.integer :vote_type
      t.references :user, foreign_key: true
      t.references :picture, foreign_key: true

      t.timestamps
    end
  end
end
