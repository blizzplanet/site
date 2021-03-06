class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.integer :author_id
      t.text    :body_raw
      t.text    :body
      t.timestamps
    end
  end

  def self.down
    drop_table :comments
  end
end
