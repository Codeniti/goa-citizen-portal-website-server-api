class AddCommentsTable < ActiveRecord::Migration
  def up
    create_table :comments do |t|
      t.belongs_to :user
      t.belongs_to :issue
      t.text :description
      t.timestamps
    end
  end

  def down
    drop_table :comments
  end
end
