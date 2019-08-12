class Tag < ApplicationRecord
  validates :content, presence: true, uniqueness:true, length: {minimum: 2}
  has_many :gossips_tags
  has_many :gossips, through: :gossips_tags

end
