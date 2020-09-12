class CreateGeneralEvaluations < ActiveRecord::Migration[6.0]
  def change
    create_table :general_evaluations do |t|
      t.references :location, null: false, foreign_key: true
      t.float :avg_rating
      t.integer :one_star, default: 0
      t.integer :two_stars, default: 0
      t.integer :three_stars, default: 0
      t.integer :four_stars, default: 0
      t.integer :five_stars, default: 0

      t.timestamps
    end
  end
end
