class AddArticleIdToComments < ActiveRecord::Migration
  def self.up
    change_table :comments do |t|
      t.integer :article_id
    end
  end

  def self.down
  end
end
