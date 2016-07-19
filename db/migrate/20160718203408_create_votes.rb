class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.float :value
      t.integer :user_id
      t.integer :link_id

      t.timestamps null: false
    end
  end
end
