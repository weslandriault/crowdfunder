class SettingDefaultAmountRaisedToZero < ActiveRecord::Migration
  def change
    change_column :projects, :amount_raised, :integer, :default => 0
  end
end
