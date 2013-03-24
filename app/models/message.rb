class Message < ActiveRecord::Base
  belongs_to :conversation
  belongs_to :author, class_name: 'User'
end
