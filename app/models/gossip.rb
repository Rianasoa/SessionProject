class Gossip < ApplicationRecord
  validates :title, presence: true, length: { in: 2..50 }
  validates :content, presence: true, length: { in: 10..500 }
  belongs_to :user
  has_many :gossips_tags
  has_many :tags, through: :gossips_tags
  accepts_nested_attributes_for :tags, allow_destroy: true
  has_many :comments
end
