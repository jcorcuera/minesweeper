class CreateGames < ActiveRecord::Migration[5.0]
  def change
    create_table :games do |t|
      t.integer :rows
      t.integer :cols
      t.integer :mines
      t.text :state

      t.timestamps
    end
  end
end
