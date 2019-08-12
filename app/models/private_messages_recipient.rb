class PrivateMessagesRecipient < ApplicationRecord
  belongs_to :private_message, optional: true
  belongs_to :recipient, class_name: "User", optional: true
end
