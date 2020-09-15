class Evaluation < ApplicationRecord
  belongs_to :user
  belongs_to :location

  validates :user_id, uniqueness: { scope: :location_id }
  validates :rating, :user_id, :location_id, presence: true
  validates :rating, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }

  def save_update_general!
    transaction do
      evaluations = Evaluation.where(location_id: self.location_id)
      avg_rating = evaluations.present? ? ((evaluations.sum(:rating) + self.rating).to_f / (evaluations.count+1).to_f) : self.rating
      general_evaluation = GeneralEvaluation.find_or_initialize_by(location_id: self.location_id)
      general_evaluation.avg_rating = avg_rating
      case self.rating
      when 1
        general_evaluation.one_star += 1
      when 2
        general_evaluation.two_stars += 1
      when 3
        general_evaluation.three_stars += 1
      when 4
        general_evaluation.four_stars += 1
      when 5
        general_evaluation.five_stars += 1
      end

      unless self.save && general_evaluation.save
        return false
      end
      return true
    end
  end
end
