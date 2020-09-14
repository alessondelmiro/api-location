class Location < ApplicationRecord
  belongs_to :user
  validates :name, uniqueness: true
  validates :name, :address, presence: true
  has_one :address, as: :addressable,	dependent: :destroy
  has_one :general_evaluation, dependent: :destroy
  has_many :evaluations, dependent: :destroy

  def self.search(q)
    where("lower(name) like ?", "%#{q.downcase}%")
  end

  def self.order_as_map(map, lat, long)
    if map
      select('locations.*, locations.distance').from("(SELECT u.*,((ACOS(SIN(#{lat} * PI() / 180) * SIN(addresses.latitude * PI() / 180) + COS(#{lat} * PI() / 180) * COS(addresses.latitude * PI() / 180) * COS((#{long} - addresses.longitude) * PI() / 180)) * 180 / PI()) * 60 * 1.1515) as distance FROM locations u INNER JOIN addresses ON u.id = addresses.addressable_id WHERE addresses.addressable_type = 'Location') locations").order("distance")
    else
      order(name: :asc)
    end

  end
end
