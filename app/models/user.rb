class User < ApplicationRecord
  validates :password, presence: true, length: { minimum: 6 }
  validates :first_name, presence: true, length: { minimum: 2 }
  validates :last_name, presence: true, length: { minimum: 2 }
  validates :description, presence: true, length: { maximum: 500 }
  validates :email, presence: true, uniqueness: {case_sensitive:false}, format: { with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/, message: "email adress please" }
  validates :age, presence: true, numericality: { greater_than_or_equal_to: 0, less_than: 100 }
  has_many :gossips
  has_many :comments
  belongs_to :city
  has_many :sent_messages, foreign_key: 'sender_id', class_name: "PrivateMessage"
  has_many :received_messages, foreign_key: 'recipient_id', class_name: "PrivateMessagesRecipient"
  has_secure_password
end

