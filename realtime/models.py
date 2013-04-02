from sqlalchemy import create_engine, Integer, Column, Text, ForeignKey, String
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker, relationship, backref
from sqlalchemy.orm.events import orm

engine = create_engine('postgresql+psycopg2://postgres@localhost/resonanz_development', echo=True)

Base = declarative_base()
Session = sessionmaker(bind=engine)


class User(Base):
    __tablename__ = 'users'

    id = Column(Integer, primary_key=True)
    name = Column(String)

    def as_json(self):
        return dict(id=self.id, name=self.name)

    def __repr__(self):
        return "<User: id=%s, name='%s'" % (self.id, self.name)


class Conversation(Base):
    __tablename__ = 'conversations'

    id = Column(Integer, primary_key=True)

    def __init__(self, data):
        self.data = data
        self.connected_users = []

    @orm.reconstructor
    def init_on_load(self):
        self.connected_users = []

    def __repr__(self):
        return "<Conversation: id=%s" % self.id


class Message(Base):
    __tablename__ = 'messages'

    id = Column(Integer, primary_key=True)
    text = Column(Text)
    conversation_id = Column(Integer, ForeignKey('conversations.id'))
    author_id = Column(Integer, ForeignKey('users.id'))

    conversation = relationship('Conversation', backref=backref('messages', order_by=id))
    author = relationship('User')

    def as_json(self):
        return dict(text=self.text, author=self.author.as_json())

    def __repr__(self):
        return "<Message: id=%s, text='%s'" % (self.id, self.text)
