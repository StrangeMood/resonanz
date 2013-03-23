class User < ActiveRecord::Base
  include Concerns::HaikuNames

  before_create :ensure_token
  before_save :ensure_name

  private

  def ensure_name
    self.name = haiku_name unless name
  end

  def ensure_token
    self.token = SecureRandom.hex(10) unless token
  end
end
