require 'test_helper'

class ConversationsControllerTest < ActionController::TestCase

  setup do
    @user1 = User.create(conversations: [Conversation.create])
    @user2 = User.create(conversations: [Conversation.create])
  end

  test 'user sees only his conversations' do
    @controller.stub(:current_user, @user1) do
      assert_equal @controller.conversations.to_a, @user1.conversations.to_a

      get(:show, id: @user1.conversations.first.slug)
      assert response.success?
    end
  end

  test 'send 404 when access foreign conversations' do
    @controller.stub(:current_user, @user1) do
      assert_raises(ActionController::RoutingError) do
        get(:show, id: @user2.conversations.first.slug)
      end
    end
  end

end
