require 'rails_helper'

RSpec.describe Location, type: :model do
  before(:all) do
    @location = build(:location)
  end
  it "is valid with valid attributes" do
    expect(create(:location)).to be_valid
  end
  it "is valid without a description" do
    expect(create(:location, description: nil)).to be_valid
  end
  it "is not valid without a name" do
    @location.name = nil
    expect(@location).to_not be_valid
  end
  it "is not valid without an user" do
    @location.user = nil
    expect(@location).to_not be_valid
  end
  it "is not valid without an address" do
    @location.address = nil
    expect(@location).to_not be_valid
  end
  it 'is not valid with a duplicated name' do
    name = Faker::Movies::HarryPotter.location
    create(:location, name: name)
    @location.name = name
    expect(@location).to_not be_valid
  end
  describe "Associations" do
    it { should have_one(:address) }
    it { should belong_to(:user) }
  end
end
