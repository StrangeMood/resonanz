class ConversationsController < ApplicationController
  respond_to :json, :html

  expose(:conversations, strategy: VerifiableStrategy)
  expose(:conversation, finder: :find_by_slug!)

  expose(:public_conversation) { Conversation.find_by(slug: params[:id], is_public: true) }

  before_filter :join_public_conversation, only: :show

  private

  def join_public_conversation
    if public_conversation
      current_user.conversations += [public_conversation]
    end
  end
end