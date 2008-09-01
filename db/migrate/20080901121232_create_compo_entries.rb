class CreateCompoEntries < ActiveRecord::Migration
  def self.up
    create_table :compo_entries do |t|
      t.integer :compo_id
      t.integer :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :compo_entries
  end
end
