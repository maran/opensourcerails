class CreateScores < ActiveRecord::Migration
  def self.up
    create_table :scores do |t|
      t.integer :compo_category_id
      t.integer :score
      t.text :description

      t.timestamps
    end
  end

  def self.down
    drop_table :scores
  end
end
