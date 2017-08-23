# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20_170_811_082_924) do
  create_table 'comments', force: :cascade do |t|
    t.text 'content'
    t.integer 'picture_id'
    t.integer 'user_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['picture_id'], name: 'index_comments_on_picture_id'
    t.index ['user_id'], name: 'index_comments_on_user_id'
  end

  create_table 'pictures', force: :cascade do |t|
    t.string 'path'
    t.integer 'user_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['user_id'], name: 'index_pictures_on_user_id'
  end

  create_table 'users', force: :cascade do |t|
    t.string 'username'
    t.string 'email'
    t.string 'password_digest'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'votes', force: :cascade do |t|
    t.integer 'vote_type'
    t.integer 'user_id'
    t.integer 'picture_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['picture_id'], name: 'index_votes_on_picture_id'
    t.index ['user_id'], name: 'index_votes_on_user_id'
  end
end
