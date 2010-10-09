class AddVersionsToArticles < ActiveRecord::Migration
  def self.up
    change_table :articles do |t|
      t.integer :version, :default => 0
    end
    
    change_table :comments do |t|
      t.integer :version, :default => 0
    end    
  end

  def self.down
  end
end
