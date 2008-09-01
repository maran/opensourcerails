class CreateCompoCategories < ActiveRecord::Migration
  def self.up
    create_table :compo_categories do |t|
      t.integer :compo_id
      t.string :name
      t.integer :weight
      t.timestamps
    end
  end

  def self.down
    drop_table :compo_categories
  end
end
