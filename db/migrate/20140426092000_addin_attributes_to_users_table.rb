class AddinAttributesToUsersTable < ActiveRecord::Migration
  def up
    add_column :users, :name, :string
    add_column :users, :dob, :datetime
    add_column :users, :gender, :string
    add_column :users, :phone, :string
    add_column :users, :location_tags, :string_array
  end

  def down
    remove_column :users, :name
    remove_column :users, :dob
    remove_column :users, :gender
    remove_column :users, :phone
  end
end
