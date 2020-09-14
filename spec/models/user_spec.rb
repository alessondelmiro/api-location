require 'rails_helper'

RSpec.describe User, type: :model do
  before(:all) do
    @user = build(:user)
  end
  it "is valid with valid attributes" do
    expect(create(:user)).to be_valid
  end
  it "is not valid without a name" do
    @user.name = nil
    expect(@user).to_not be_valid
  end
  it "is not valid without an email" do
    @user.email = nil
    expect(@user).to_not be_valid
  end
  it "is not valid without a password" do
    @user.password = nil
    expect(@user).to_not be_valid
  end
  it "is not valid without an address" do
    @user.address = nil
    expect(@user).to_not be_valid
  end
  it 'is not valid with a duplicated email' do
    email = Faker::Internet.email
    create(:user, email: email)
    @user.email = email
    expect(@user).to_not be_valid
  end

  describe "Associations" do
    it { should have_one(:address) }
  end
end
