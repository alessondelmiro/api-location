class AddUniqueIndexToEvaluation < ActiveRecord::Migration[6.0]
  def change
    add_index :evaluations, [:user_id, :location_id], unique: true
  end
end
