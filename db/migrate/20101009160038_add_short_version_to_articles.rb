class AddShortVersionToArticles < ActiveRecord::Migration
  def self.up
    change_table :articles do |t|
      t.text :short_version
    end
  end

  def self.down
  end
end
