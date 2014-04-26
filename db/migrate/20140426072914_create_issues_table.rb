class CreateIssuesTable < ActiveRecord::Migration
  def up
    create_table :issues do |t|
      t.text :title
      t.text :description
      t.string_array :location_tags
      t.string :state, :not_null => true
      t.string_array :verified_by
      t.string_array :categories
      t.timestamps
    end
  end

  def down
    drop_table :issues
  end
end
