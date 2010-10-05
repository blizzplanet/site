class CategorySlugs < ActiveRecord::Migration
  def self.up
    change_table :categories do |t|
      t.string :base_slug
      t.string :slug
    end
  end

  def self.down
  end
end
