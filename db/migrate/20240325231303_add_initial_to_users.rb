class AddInitialToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :player, :integer
  end
end
