class Address < ApplicationRecord
  belongs_to :addressable, polymorphic: true
  before_save :titleize_attributes
  geocoded_by :full_address
  reverse_geocoded_by :latitude, :longitude do |obj, results|
    if geo = results.first
      obj.street = geo.street
      obj.suburb = geo.suburb || geo.neighbourhood
      obj.city = geo.city || geo.municipality
      obj.state = geo.state
      obj.country = geo.country
    end
  end
  after_validation :geocode, if: ->(obj){obj.street.present? and obj.street_changed?}
  after_validation :reverse_geocode, unless: ->(obj){ obj.street.present? and obj.street_changed? },
                   if: ->(obj){ obj.latitude.present? and obj.latitude_changed? and obj.longitude.present? and obj.longitude_changed? }
  validates :street, :suburb, :city, :state, :country, presence: true, unless: -> { latitude && longitude }

  def full_address
    [street, suburb, city, state, country].compact.join(', ')
  end

  def titleize_attributes
    self.street = self.street.titleize if self.street
    self.suburb = self.suburb.titleize if self.suburb
    self.city = self.city.titleize  if self.city
    self.state = self.state.titleize  if self.state
    self.country = self.country.titleize  if self.country
	end
end
