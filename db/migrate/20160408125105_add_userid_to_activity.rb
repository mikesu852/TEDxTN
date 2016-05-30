class AddUseridToActivity < ActiveRecord::Migration
  def change
    add_column :activities, :status, :integer , :default => '0'
    add_column :activities, :user_id, :integer
    add_index :activities, :user_id
  end
end
