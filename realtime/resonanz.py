from tornado import websocket, web, ioloop
from chat import Chat
from models import Session

database_session = Session()

application = web.Application([
    (r'/conversations/([0-9]+)', Chat, dict(db=database_session)),
], cookie_secret='SOME_SECRET_HERE')

if __name__ == '__main__':
    application.listen(8888)
    ioloop.IOLoop.instance().start()
