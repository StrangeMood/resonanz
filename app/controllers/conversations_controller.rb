class ConversationsController < ApplicationController
  expose(:conversations) { Conversation.accessible_by(current_ability) }
  expose(:conversation)
end
