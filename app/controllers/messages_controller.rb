class MessagesController < ApplicationController
  respond_to :json

  expose(:conversation, strategy: VerifiableStrategy)
  expose(:messages, ancestor: :conversation)
  expose(:message)
end
