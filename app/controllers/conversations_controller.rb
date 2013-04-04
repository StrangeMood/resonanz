class ConversationsController < ApplicationController
  respond_to :json, :html

  expose(:conversations, strategy: VerifiableStrategy)
  expose(:conversation, finder: :find_by_slug)
end
