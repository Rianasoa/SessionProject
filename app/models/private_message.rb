class PrivateMessage < ApplicationRecord
  validates :content, presence: true, length: {in: 2..500}
  belongs_to :sender, class_name: "User"
  has_many :private_messages_recipients
  has_many :recipients,class_name: "User", through: :private_messages_recipients
end
