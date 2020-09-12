class GeneralEvaluation < ApplicationRecord
  belongs_to :location

  validates :avg_rating, :location_id, presence: true

  def count_evaluations
    self.one_star + self.two_stars + self.three_stars + self.four_stars + self.five_stars
  end
end
