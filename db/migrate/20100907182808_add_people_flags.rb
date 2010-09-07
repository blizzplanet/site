class AddPeopleFlags < ActiveRecord::Migration
  def self.up
    change_table :people do |t|
      t.boolean :admin,       :default => false, :null => false
      t.boolean :newsmaker,   :default => false, :null => false
      t.boolean :approver,    :default => false, :null => false
      t.boolean :can_comment, :default => true,  :null => false
    end
  end

  def self.down
  end
end
