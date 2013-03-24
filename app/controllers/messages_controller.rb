class MessagesController < ApplicationController
  respond_to :json

  expose(:conversation, strategy: VerifiableStrategy)
  expose(:messages, ancestor: :conversation)
  expose(:message, attributes: :message_params)

  def create
    message.author ||= current_user

    message.save
    render json: message
  end

  private

  def message_params
    params.require(:message).permit(:text)
  end

end
