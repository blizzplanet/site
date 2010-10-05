class ArticleAuthors < ActiveRecord::Migration
  def self.up
    change_table :articles do |t|
      t.integer :author_id
    end
  end

  def self.down
  end
end
