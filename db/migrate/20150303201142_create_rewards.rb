class CreateRewards < ActiveRecord::Migration
  def change
    create_table :rewards do |t|
      t.string :name
      t.string :description
      t.integer :price
      t.integer :backer_limit
      t.integer :project_id

      t.timestamps null: false
    end
  end
end
