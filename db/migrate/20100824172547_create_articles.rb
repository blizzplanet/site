class CreateArticles < ActiveRecord::Migration
  def self.up
    create_table :articles do |t|
      t.string  :title, :null => false
      t.text    :body_raw
      t.text    :body
      t.timestamps
    end
  end

  def self.down
  end
end
