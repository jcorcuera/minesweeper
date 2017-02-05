class AddFinishedAtToGames < ActiveRecord::Migration[5.0]
  def change
    add_column :games, :finished_at, :datetime
    add_column :games, :won, :boolean, default: false
  end
end
