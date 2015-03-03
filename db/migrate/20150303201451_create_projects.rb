class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name
      t.date :end_date
      t.date :start_date
      t.string :photo_url
      t.string :description
      t.integer :funding_goal
      t.integer :owner_id

      t.timestamps null: false
    end
  end
end
