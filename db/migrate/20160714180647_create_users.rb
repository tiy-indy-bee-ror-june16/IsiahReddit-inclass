class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.text :description

      t.timestamps null: false
    end
  end
end
