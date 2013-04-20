require 'test_helper'

class ConversationsControllerTest < ActionController::TestCase

  setup do
    @user1 = User.create(conversations: [Conversation.create(is_public: false)])
    @user2 = User.create(conversations: [Conversation.create(is_public: false)])
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

  test 'user becomes a member when access public conversation' do
    public_conversation = Conversation.create(is_public: true)

    @controller.stub(:current_user, @user1) do
      get(:show, id: public_conversation.slug)

      assert response.success?
      assert_includes @user1.conversations, public_conversation
    end
  end

  test 'GET request for non existent slug creates new conversation' do
    @controller.stub(:current_user, @user1) do
      get(:show, id: 'joppadriller')

      assert response.success?
      assert_includes @user1.conversations.pluck(:slug), 'joppadriller'
    end
  end

end
