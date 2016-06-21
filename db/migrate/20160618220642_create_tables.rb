class CreateTables < ActiveRecord::Migration
  def change
    create_table :tables do |t|
      t.references :reservation, index: true, foreign_key: true
      t.integer :size
      t.integer :time
      t.timestamps null: false
    end
  end
end
