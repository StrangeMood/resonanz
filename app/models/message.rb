class Message < ActiveRecord::Base
  include Concerns::ApiPartialPath

  belongs_to :conversation
  belongs_to :author, class_name: 'User'
end
