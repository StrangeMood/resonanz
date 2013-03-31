class User < ActiveRecord::Base
  include HaikuNames
  include ApiPartialPath

  before_create :ensure_token
  before_save :ensure_name

  has_many :user_conversations, dependent: :destroy
  has_many :conversations, through: :user_conversations

  private

  def ensure_name
    self.name = haiku_name unless name
  end

  def ensure_token
    self.token = SecureRandom.hex(10) unless token
  end
end
