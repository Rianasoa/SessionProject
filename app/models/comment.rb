class Comment < ApplicationRecord
  validates :content, presence: true ,  length: { in: 2..200 }
  belongs_to :user
  belongs_to :gossip
end
