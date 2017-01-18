class CreateReviews < ActiveRecord::Migration[5.0]
  def change
    create_table :reviews do |t|
      t.references :user, foreign_key: true
      t.references :room, foreign_key: true
      t.integer :poins

      t.index [:user_id, :room_id], unique: true

      t.timestamps
    end
  end
end
