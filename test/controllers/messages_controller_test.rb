require 'test_helper'

class MessagesControllerTest < ActionController::TestCase

  def setup
    @conversation = Conversation.create
    @user = user = User.create

    @user.user_conversations.create(conversation: @conversation)

    ApplicationController.send(:define_method, :current_user) do
      user
    end
  end

  test 'create messages' do
    post :create, format: 'json', message: {text: 'Hello World'}, conversation_id: @conversation.id

    assert response.success?
  end

  test 'publish new message to Redis' do
    broadcast_message = nil
    Resonanz::Redis.class.send(:define_method, :publish) do |channel, message|
      broadcast_message = message
    end

    post :create, format: 'json', message: {text: 'Hello World'}, conversation_id: @conversation.id

    assert_equal response.body, broadcast_message
  end
end
