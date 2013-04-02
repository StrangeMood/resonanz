import json
from tornado import websocket
from models import User, Conversation, Message


class Chat(websocket.WebSocketHandler):

    def initialize(self, db):
        self.db = db

    def get_current_user(self):
        user_id = self.get_secure_cookie('id', None, 365*20)
        if user_id:
            return self.db.query(User).get(user_id)

    def open(self, conversation_id):
        if self.current_user:
            self.conversation = self.db.query(Conversation).get(conversation_id)
            self.conversation.connected_users.append(self)
        else:
            self.close()

    def on_message(self, message):
        message = Message(**json.loads(message))
        message.author = self.current_user

        self.conversation.messages.append(message)
        self.db.add(message)
        self.db.commit()

        for user in self.conversation.connected_users:
            user.write_message(json.dumps(message.as_json()))

    def on_close(self):
        self.conversation.connected_users.remove(self)
        print 'WebSocket closed'
