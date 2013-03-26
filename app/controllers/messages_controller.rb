class MessagesController < ApplicationController
  respond_to :json

  expose(:conversation, strategy: VerifiableStrategy)
  expose(:messages, ancestor: :conversation)
  expose(:message, attributes: :message_params)

  def create
    message.author ||= current_user

    if message.save
      json_message = render_for_api(message)
      channel = "conversation/#{conversation.to_param}"
      Resonanz::Redis.publish(channel, json_message)

      render text: json_message
    end
  end

  private

  def message_params
    params.require(:message).permit(:text)
  end

end
