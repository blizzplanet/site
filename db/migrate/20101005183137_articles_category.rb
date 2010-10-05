class ArticlesCategory < ActiveRecord::Migration
  def self.up
    change_table :articles do |t|
      t.integer :category_id
    end
  end

  def self.down
  end
end
