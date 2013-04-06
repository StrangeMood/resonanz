class Conversation < ActiveRecord::Base
  include ApiPartialPath

  has_many :user_conversations, dependent: :destroy
  has_many :users, through: :user_conversations

  has_many :messages, dependent: :destroy

  after_save :ensure_slug

  def to_param
    slug
  end

  private

  def ensure_slug
    update_attribute(:slug, "id#{id}") unless self.slug.present?
  end
end
