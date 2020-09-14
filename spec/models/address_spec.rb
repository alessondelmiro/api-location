require 'rails_helper'

RSpec.describe Address, type: :model do
  before(:all) do
    @address = build(:address)
  end
  it "is valid with valid attributes" do
    expect(@address).to be_valid
  end

  describe "Validations" do
    it "validates presence of street unless latitude and longitude are present" do
      expect(Address.new(:latitude => nil, :longitude => nil)).to validate_presence_of(:street)
    end
    it "validates presence of suburb unless latitude and longitude are present" do
      expect(Address.new(:latitude => nil, :longitude => nil)).to validate_presence_of(:suburb)
    end
    it "validates presence of city unless latitude and longitude are present" do
      expect(Address.new(:latitude => nil, :longitude => nil)).to validate_presence_of(:city)
    end
    it "validates presence of state unless latitude and longitude are present" do
      expect(Address.new(:latitude => nil, :longitude => nil)).to validate_presence_of(:state)
    end
    it "validates presence of country unless latitude and longitude are present" do
      expect(Address.new(:latitude => nil, :longitude => nil)).to validate_presence_of(:country)
    end
  end
end
