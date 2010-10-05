class CreateCategories < ActiveRecord::Migration
  def self.up
    create_table :categories do |t|
      t.string :title
      t.integer :parent_id
      t.integer :lft
      t.integer :rgt
    end
  end

  def self.down
  end
end
