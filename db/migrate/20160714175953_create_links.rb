class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.string :address
      t.string :title
      t.text :summary
      t.integer :vote_score
      t.integer :subreddit_id
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
