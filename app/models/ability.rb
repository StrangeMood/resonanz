class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, Conversation, user_conversations: {user_id: user.id}
  end
end
