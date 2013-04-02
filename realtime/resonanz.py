from sqlalchemy import create_engine, Integer, Column, Text, ForeignKey
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker, relationship, backref, foreign
from tornado import websocket, web, ioloop

engine = create_engine('postgresql+psycopg2://postgres@localhost/resonanz_development', echo=True)

Base = declarative_base()
Session = sessionmaker(bind=engine)

class Conversation(Base):
    __tablename__ = 'conversations'

    id = Column(Integer, primary_key=True)

class Message(Base):
    __tablename__ = 'messages'

    id = Column(Integer, primary_key=True)
    text = Column(Text)
    conversation_id = Column(Integer, ForeignKey('conversations.id'))
    author_id = Column(Integer)

    conversation = relationship('Conversation', backref=backref('messages', order_by=id))

    def __repr__(self):
        return "<Message: id=%d, text='%s'" % (self.id, self.text)

session = Session()

class Chat(websocket.WebSocketHandler):
    def open(self):
        self.user_id = self.get_secure_cookie('id', None, 10000)
        print 'User #%s connected' % self.user_id
        print 'WebSocket opened'

    def on_message(self, message):
        self.write_message('User #%s: %s' % (self.user_id, message))
        self.close()

    def on_close(self):
        print 'WebSocket closed'

application = web.Application([
    (r'/realtime/chat', Chat),
], cookie_secret='SOME_SECRET_HERE')

if __name__ == '__main__':
    application.listen(8888)
    ioloop.IOLoop.instance().start()
