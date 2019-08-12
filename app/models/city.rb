class City < ApplicationRecord
  validates :city_name, presence: true, uniqueness: true, length: { minimum: 2 }
  validates :zip_code, presence: true, uniqueness: true, length: { minimum: 5 }
  has_many :users
end
