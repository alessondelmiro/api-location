require 'rails_helper'

RSpec.describe GeneralEvaluation, type: :model do
  it "is valid with valid attributes" do
    expect(create(:general_evaluation)).to be_valid
  end
  it "is not valid without avg_rating" do
    expect(build(:general_evaluation, avg_rating: nil)).not_to be_valid
  end
  it "is valid without one_star" do
    expect(create(:general_evaluation, one_star: nil)).to be_valid
  end
  it "is valid without two_star" do
    expect(create(:general_evaluation, two_stars: nil)).to be_valid
  end
  it "is valid without three_star" do
    expect(create(:general_evaluation, three_stars: nil)).to be_valid
  end
  it "is valid without four_star" do
    expect(create(:general_evaluation, four_stars: nil)).to be_valid
  end
  it "is valid without five_star" do
    expect(create(:general_evaluation, five_stars: nil)).to be_valid
  end

  
end
