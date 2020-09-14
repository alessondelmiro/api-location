require 'rails_helper'

RSpec.describe Evaluation, type: :model do
  before(:all) do
    @evaluation = build(:evaluation)
  end

  it "is valid with valid attributes" do
    expect(create(:evaluation)).to be_valid
  end
  it "is not valid without user" do
    @evaluation.user = nil
    expect(@evaluation).not_to be_valid
  end
  it "is not valid without location" do
    @evaluation.location = nil
    expect(@evaluation).not_to be_valid
  end
  it "is not valid without rating" do
    @evaluation.rating = nil
    expect(@evaluation).not_to be_valid
  end
  it "is not with location and user duplicated" do
    ev = create(:evaluation)
    @evaluation.user = ev.user
    @evaluation.location = ev.location
    expect(@evaluation).not_to be_valid
  end
  it { should validate_numericality_of(:rating).only_integer.is_greater_than_or_equal_to(1).is_less_than_or_equal_to(5) }
end
