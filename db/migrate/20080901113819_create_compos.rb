class CreateCompos < ActiveRecord::Migration
  def self.up
    create_table :compos do |t|
      t.string :name
      t.string :tag
      t.date :start_date
      t.date :end_date
      t.text :description
      t.integer :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :compos
  end
end
