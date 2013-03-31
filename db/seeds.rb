user = User.create
conversation = Conversation.create

conversation.messages = [
    Message.create(text: 'Some message', author: user),
    Message.create(text: 'Another one message', author: user)
]
conversation.save

user.conversations = [conversation]
user.save
