from sqlalchemy import create_engine, Integer, Column, Text, ForeignKey
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker, relationship, backref, foreign

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

print session.query(Message).all()